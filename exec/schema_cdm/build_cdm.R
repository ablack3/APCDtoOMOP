library(tidyverse)
library(DBI)
devtools::load_all() # Load the APCDtoOMOP package


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

### create health system tables
etl07 <- execute_sql(connection = con,
                     file_path = 'sql/schema_cdm/cdm_location.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)

etl08 <- execute_sql(connection = con,
                     file_path = 'sql/schema_cdm/cdm_care_site.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)

etl09 <- execute_sql(connection = con,
                     file_path = 'sql/schema_cdm/cdm_provider.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = log_table)

### create the person and observation period tables
etl10 <- execute_sql(connection = con,
                     file_path = 'sql/schema_cdm/cdm_person.sql',
                     parameters = list('DATABASE' = database_name),
                     quit_on_error = T,
                     log_table = NA)

etl101 <- execute_sql(connection = con,
                      file_path = 'sql/schema_cdm/cdm_observation_period.sql',
                      parameters = list('DATABASE' = database_name),
                      quit_on_error = T,
                      log_table = NA)

etl102 <- execute_sql(connection = con,
                      file_path = 'sql/schema_cdm/cdm_payer_plan_period.sql',
                      parameters = list('DATABASE' = database_name),
                      quit_on_error = T,
                      log_table = NA)

### create visit tables
etl11 <- execute_sql(connection = con,
                     file_path = 'sql/schema_trm/trm_visit_detail.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)

etl12 <- execute_sql(connection = con,
                     file_path = 'sql/schema_cdm/cdm_visit_detail.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)

etl13 <- execute_sql(connection = con,
                     file_path = 'sql/schema_cdm/cdm_visit_occurrence.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)

### create event tables
etl14 <- execute_sql(connection = con,
                     file_path = 'sql/schema_trm/ddl_trm_event_tables.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)

etl15 <- execute_sql(connection = con,
                     file_path = 'sql/schema_trm/trm_cpt_map.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)

etl16 <- execute_sql(connection = con,
                     file_path = 'sql/schema_trm/trm_dx_map.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)


etl17 <- execute_sql(connection = con,
                     file_path = 'sql/schema_trm/trm_ndc_map.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)

etl18 <- execute_sql(connection = con,
                     file_path = 'sql/schema_cdm/cdm_event_tables.sql',
                     parameters = list('database' = 'APCD'),
                     quit_on_error = T,
                     log_table = log_table)


# collect execution log info
log_objs <- ls() %>%
  tibble::enframe(name = NULL) %>%
  filter(stringr::str_detect(value, pattern = 'etl'))

run_log <- purrr::map_dfr(log_objs$value, get)

readr::write_csv(run_log, paste0("run_logs/build_cdm_run_log-", Sys.Date(), ".csv"))

rm(list = ls(pattern = '^etl[0-9]*$'))

# total execution time (7 hours for full dataset, 1 hour for small subset of patients)
sum(run_log$duration, na.rm = T)/60/60
count(ungroup(run_log), script_name, wt = duration/60/60) %>% print(n=100)# runtime by script

DBI::dbDisconnect(con)

