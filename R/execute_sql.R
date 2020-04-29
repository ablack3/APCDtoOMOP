#' Execute SQL on a database and log results
#'
#' \code{execute_sql} breaks a SQL script into batches,
#' executes the batches sequentially on a database,
#' and return the results to a log table.
#'
#' @param connection A valid database connection.
#' @param file_path The file path of the SQL script to be executed.
#' @param parameters A named list of parameters that will be used
#'   to substitute placeholders in the SQL script with user-defined
#'   values.
#' @param log_table The name of the schema and table on the database
#'   where log records will be written (e.g. "schema.table").
#'   Change this value to NA to prevent writing log records to the database.
#' @param quit_on_error A logical scalar. Should the function
#'   exit if it encounters an error?
#' @param batch_separator A regex expression used to break the SQL script
#'   into batches.
#' @return A data.frame containing the log records.
#' @example
#' execute_sql(connection = con,
#'   file_path = "sql/postgreSQL/create_schema.sql",
#'   parameters = list(
#'     "database" = "somedb",
#'     "schema_name" = "etl"),
#'   log_table = "etl.run_log")
#'
execute_sql <- function(connection,
                        file_path,
                        parameters = NA,
                        log_table = "etl.run_log",
                        quit_on_error = FALSE,
                        batch_separator = "\\bGO\\s*") {

  # Check that odbc connection is valid
  assertthat::assert_that(odbc::dbIsValid(connection),
                          msg = "Not a valid database connection."
  )

  # Check that the SQL script being called exists
  assertthat::assert_that(file.exists(file_path),
                          msg = "SQL script does not exist at specified file path."
  )

  # Check that the SQL script is a valid text file
  assertthat::assert_that(is.character(readr::read_file(file_path)),
                          msg = "File is not a valid SQL script."
  )

  # If used, check that the parameters are a list object
  if (all(!is.na(parameters))) {
    assertthat::assert_that(is.list(parameters),
                            msg = "Parameters are not a valid list object."
    )
  }


  # If used, check that the parameters were input correctly
  if (all(!is.na(parameters))) {
    assertthat::assert_that(length(names(parameters)) == length(parameters),
                            msg = "Not all parameters are named."
    )
  }

  # Check that log table exists, if log_table != NA
  if (!is.na(log_table)) {
    log_schema <- stringr::str_replace(log_table, "(.*)(\\..*)", "\\1")
    log_tbl <- stringr::str_replace(log_table, "(.*\\.)(.*)", "\\2")
    assertthat::assert_that(
      DBI::dbExistsTable(
        conn = connection,
        name = DBI::Id(
          #catalog = parameters[["database"]],
          schema = log_schema,
          table = log_tbl
        )
      ),
      msg = "Log table does not exist - Use NA as log_table argument to disable logging"
    )
  }

  # Read SQL script
  sql_script <- readr::read_file(file_path)

  # Remove all multi-line /**/ comments
  # match any /* , followed by zero or more of anything except * or * not followed by /, followed by */
  multiline_comment_regex <- "(\\/\\*)([^\\*]|\\*(?!\\/))*(\\*\\/)"
  sql_script <- stringr::str_remove_all(sql_script, multiline_comment_regex)

  # Add parameter identifiers (@) to both sides of parameter names
  if (all(!is.na(parameters))) {
    names(parameters) <- paste0("@", names(parameters), "@")
  }

  # Replace parameter names with parameter values in SQL script
  if (all(!is.na(parameters))) {
    if (length(parameters) == 1) {
      sql_script <- stringr::str_replace_all(sql_script, names(parameters), parameters[[1]])
    } else if (length(parameters) > 1) {
      for (i in 1:length(parameters)) {
        sql_script <- stringr::str_replace_all(sql_script, names(parameters)[i], parameters[[i]])
      }
    }
  }

  # Break SQL script into N batches to be sent to the server sequentially.
  sql_batches <- stringr::str_split(sql_script, batch_separator, simplify = TRUE)

  # Remove empty batches
  sql_batches <- stringr::str_subset(sql_batches, "^\\s*$", negate = T)

  # Create log object
  log_list <- list()

  # Begin populating log object
  log_start <- tibble::tibble(
    # Create a process identifier
    pid = paste0(Sys.info()["user"], "-", Sys.getpid(), "-", digest::sha1(Sys.Date())),
    # Extract the name of the SQL script from the file path
    script_name = stringr::str_extract(file_path, "[A-Za-z_]*\\.sql"),
    # Flatten the parameters into a single record, separated by "|"
    parameters =
      if (all(!is.na(parameters))) {
        paste(purrr::map2_chr(
          names(parameters), purrr::flatten_chr(parameters),
          ~ paste(.x, " = ", .y)
        ), collapse = " | ")
      } else {
        ""
      },
    # Record name of user executing the script
    user_name = as.character(Sys.info()["user"])
  )

  # Count batches in SQL script, as identified by the batch_separator argument
  batch_count <- length(sql_batches)

  # What should this function do if the batch count is zero?

  # Loop through batches and execute on server
  for (i in 1:batch_count) {
    tryCatch({
      # Remove "--" from comments from SQL script
      sql_script <- stringr::str_replace_all(sql_batches[[i]], "--.*\\n", "")
      # Remove slash/star style comments from SQL code
      # sql_script <- stringr::str_replace_all(sql_script, "^/\\*{2,}\\n", "")
      # sql_script <- stringr::str_replace_all(sql_script, "^params:.*\\n", "")
      # sql_script <- stringr::str_replace_all(sql_script, "^\\*{2,}/\\n", "")

      # Extract first -- style comment from batch and save as job name
      job_name <- stringr::str_extract(sql_batches[[i]], "--.*\\n")
      job_name <- stringr::str_replace(job_name, "--", "")
      job_name <- stringr::str_replace(job_name, "\\n", "")

      batch_number <- i
      start_dtm <- Sys.time()

      duration <- system.time({
        res <- DBI::dbExecute(connection, sql_script)
      })

      # tryCatch did not find an error, so exit status = 0
      exit_status <- 0
      duration <- round(duration[3], 3)
      # Record message returned from server
      s_message <- stringr::str_replace_all(res, "\\n", " | ")
      # Catch error-related information
    },
    error = function(e) {
      print(conditionMessage(e))
      s_message <<- stringr::str_replace_all(conditionMessage(e), "\\n", " | ")
      exit_status <<- 1
      duration <<- NA
      # Concatenate all log info into a single record
    },
    finally = {
      log_entry <- log_start
      log_entry$job_name <- job_name
      log_entry$batch_number <- batch_number
      log_entry$start_dtm <- start_dtm
      log_entry$exit_status <- exit_status
      log_entry$message <- as.character(s_message)
      log_entry$duration <- duration
      log_list[[i]] <- log_entry

      log_record <- dplyr::bind_rows(log_list[[i]])

      cat(paste(
        stringr::str_extract(file_path, "[A-Za-z_]*\\.sql"), "-",
        job_name, "-", "batch", batch_number, "-", "exit status =", exit_status, "\n"
      ))

      # Write log record to database table specified by log_table argument
      tryCatch({
        if (!is.na(log_table)) {
          DBI::dbWriteTable(connection,
                            DBI::Id(schema = log_schema, table = log_tbl), log_record,
                            append = TRUE
          )
        }
      },
      error = function(err) {
        cat(paste(
          "Could not write log record for batch number", i,
          "to", log_table, "\n", conditionMessage(err), "\n"
        ))
      }
      )

      # Exit function when one of the batches return an error
      if (quit_on_error == TRUE) {
        assertthat::assert_that(exit_status == 0,
                                msg = "Error during ETL process. See run_log for details"
        )
      }
    }
    )

    # Bind log records into a single dataframe
    log_records <- dplyr::bind_rows(log_list)
  }

  # Return log records to R session
  return(log_records)
}

