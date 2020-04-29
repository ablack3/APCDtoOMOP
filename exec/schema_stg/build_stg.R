library(DBI)
library(dplyr)
devtools::load_all() # Load the APCDtoOMOP package

# note: exit status 0 implies no errors

database_name <- 'APCD'
log_table = 'dbo.etl_run_log'
# server_name <- "my_sql_server"
# port_number <- 1234

# Connect to database server 
con <- DBI::dbConnect(odbc::odbc(),
                      driver = 'SQLServer',
                      database = database_name,
                      server = server_name,
                      port = port_number)



# Create stg.patkey_list table (These patient IDs drive the rest of the ETL)
etl00 <- execute_sql(connection = con,
                     file_path = 'sql/schema_stg/stg_patkey_list.sql',
                     parameters = list('NUM_PATIENTS' = '1000', 'DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = log_table)

# Create stg tables
etl01 <- execute_sql(connection = con,
                     file_path = 'sql/schema_stg/stg_me.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)

etl02 <- execute_sql(connection = con,
                     file_path = 'sql/schema_stg/stg_mc.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)


etl03 <- execute_sql(connection = con,
                     file_path = 'sql/schema_stg/stg_dx.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)

etl04 <- execute_sql(connection = con,
                     file_path = 'sql/schema_stg/stg_icdproc.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)


etl05 <- execute_sql(connection = con,
                     file_path = 'sql/schema_stg/stg_npi.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)


etl06 <- execute_sql(connection = con,
                     file_path = 'sql/schema_stg/stg_pc.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)



log_objs <- ls() %>%
  tibble::enframe(name = NULL) %>%
  filter(stringr::str_detect(value, pattern = 'etl'))

run_log <- purrr::map_dfr(log_objs$value, get)

readr::write_csv(run_log, paste0("run_logs/run_log-", Sys.Date(), ".csv"))

rm(list = ls(pattern = '^etl[0-9]*$'))

sum(run_log$duration, na.rm = T)/60/60 # overall runtime
count(ungroup(run_log), script_name, wt = duration/60/60) %>% print(n=100)# runtime by script

DBI::dbDisconnect(con)

