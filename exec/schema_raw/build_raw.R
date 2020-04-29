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


##### Drop and recreate raw.mc table #####

# Create raw.mc table
etl00 <- execute_sql(connection = con,
                     file_path = 'sql/schema_raw/ddl_raw_mc_tbl.sql',
                     parameters = list(
                       'database' = 'APCD'),
                     log_table = 'dbo.etl_run_log')

# List files to bulk load
mc_files <- c(
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201501.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201502.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201503.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201504.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201505.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201506.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201507.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201508.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201509.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201501.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201601.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201602.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201603.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201604.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201605.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201607.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201608.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201609.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201701.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201702.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201703.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201704.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201705.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201706.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201707.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201708.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201709.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201801.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201802.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201803.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201804.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201805.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201806.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201807.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201808.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201809.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201901.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201902.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_201903.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2015010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2015011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2015012.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2016010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2016011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2016012.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2017010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2017011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2017012.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2018010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2018011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_Medicare_NoPayerID_2018012.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201501.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201502.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201503.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201504.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201505.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201506.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201507.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201508.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201509.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201501.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201601.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201602.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201603.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201604.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201605.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201607.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201608.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201609.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201701.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201702.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201703.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201704.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201705.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201706.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201707.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201708.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201709.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201801.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201802.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201803.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201804.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201805.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201806.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201807.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201808.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201809.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201901.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201902.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_201903.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2015010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2015011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2015012.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2016010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2016011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2016012.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2017010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2017011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2017012.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2018010.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2018011.txt',
  'MC_Level2_PI_CityZIP_NoDOB_NoPayerID_2018012.txt'
)

# Bulk load flat files to raw.mc
for (i in 1:length(mc_files)) {

  execute_sql(connection = con,
              file_path = 'sql/schema_raw/bulk_load_tbl.sql',
              parameters = list(
                'database' = 'APCD',
                'table_name' = 'raw.mc',
                'data_path' = paste0('\\', mc_files[i]),
                'error_path' = paste0('\\mc_error', i),
                'delimiter' = '*'),
              log_table = 'dbo.etl_run_log')
}

# Convert raw.mc table to clustered columnstore
etl300 <- execute_sql(connection = con,
                     file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                     parameters = list(
                       'database' = 'APCD',
                       'table_name' = 'raw.mc',
                       'index_name' = 'mc_cci'),
                     log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.me table #####

# Create raw.me table
et301 <- execute_sql(connection = con,
                     file_path = 'sql/schema_raw/ddl_raw_me_tbl.sql',
                     parameters = list(
                       'database' = 'APCD'),
                     log_table = 'dbo.etl_run_log')

# List files to bulk load
me_files <- c(
  "ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201501.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2015010.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2015011.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2015012.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201502.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201503.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201504.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201505.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201506.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201507.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201508.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201509.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201601.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2016010.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2016011.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2016012.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201602.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201603.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201604.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201605.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201606.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201607.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201608.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201609.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201701.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2017010.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2017011.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2017012.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201702.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201703.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201704.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201705.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201706.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201707.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201708.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201709.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201801.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2018010.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2018011.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_2018012.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201802.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201803.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201804.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201805.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201806.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201807.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201808.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201809.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201901.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201902.txt"
  ,"ME_Level2_CityZIP_NoDOB_Medicare_NoPayerID_201903.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201501.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2015010.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2015011.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2015012.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201502.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201503.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201504.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201505.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201506.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201507.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201508.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201509.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201601.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2016010.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2016011.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2016012.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201602.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201603.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201604.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201605.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201606.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201607.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201608.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201609.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201701.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2017010.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2017011.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2017012.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201702.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201703.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201704.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201705.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201706.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201707.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201708.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201709.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201801.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2018010.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2018011.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_2018012.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201802.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201803.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201804.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201805.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201806.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201807.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201808.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201809.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201901.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201902.txt"
  ,"ME_Level2_CityZIP_NoDOB_NoPayerID_201903.txt"
)

# Bulk load files to raw.me
for (i in 1:length(me_files)) {

  execute_sql(connection = con,
              file_path = 'sql/schema_raw/bulk_load_tbl.sql',
              parameters = list(
                'database' = 'APCD',
                'table_name' = 'raw.me',
                'data_path' = paste0('\\', me_files[i]),
                'error_path' = paste0('\\me_error', i),
                'delimiter' = '*'),
              log_table = 'dbo.etl_run_log')
}

# Convert raw.me table to clustered columnstore
etl300 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.me',
                        'index_name' = 'me_cci'),
                      log_table = 'dbo.etl_run_log')

##### Drop and recreate raw.pc table #####

# Create raw.pc table
et501 <- execute_sql(connection = con,
                     file_path = 'sql/schema_raw/ddl_raw_pc_tbl.sql',
                     parameters = list(
                       'database' = 'APCD'),
                     log_table = 'dbo.etl_run_log')

# List files to bulk load
pc_files <- c(
  "PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201501.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2015010.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2015011.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2015012.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201502.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201503.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201504.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201505.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201506.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201507.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201508.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201509.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201601.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2016010.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2016011.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2016012.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201602.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201603.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201604.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201605.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201606.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201607.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201608.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201609.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201701.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2017010.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2017011.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2017012.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201702.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201703.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201704.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201705.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201706.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201707.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201708.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201709.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201801.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2018010.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2018011.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_2018012.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201802.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201803.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201804.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201805.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201806.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201807.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201808.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201809.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201901.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201902.txt"
  ,"PC_Level2_PI_CityZIP_NoDOB_NoPayerID_201903.txt"
)

# Bulk load flat files to raw.pc
for (i in 1:length(pc_files)) {

  execute_sql(connection = con,
              file_path = 'sql/schema_raw/bulk_load_tbl.sql',
              parameters = list(
                'database' = 'APCD',
                'table_name' = 'raw.pc',
                'data_path' = paste0('\\', pc_files[i]),
                'error_path' = paste0('\\mc_error', i),
                'delimiter' = '*'),
              log_table = 'dbo.etl_run_log')
}

# Convert raw.pc table to clustered columnstore
etl502 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.pc',
                        'index_name' = 'pc_cci'),
                      log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.pe table #####

# Create raw.pe table
etl601 <- execute_sql(connection = con,
                     file_path = 'sql/schema_raw/ddl_raw_pe_tbl.sql',
                     parameters = list(
                       'database' = 'APCD'),
                     log_table = 'dbo.etl_run_log')

# List files to bulk load
pe_files <- c(
  "PE_Level2_CityZIP_NoDOB_NoPayerID_201501.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2015010.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2015011.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2015012.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201502.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201503.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201504.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201505.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201506.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201507.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201508.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201509.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201601.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2016010.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2016011.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2016012.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201602.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201603.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201604.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201605.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201606.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201607.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201608.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201609.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201701.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2017010.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2017011.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2017012.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201702.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201703.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201704.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201705.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201706.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201707.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201708.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201709.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201801.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2018010.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2018011.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_2018012.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201802.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201803.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201804.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201805.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201806.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201807.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201808.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201809.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201901.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201902.txt"
  ,"PE_Level2_CityZIP_NoDOB_NoPayerID_201903.txt"
)

# Bulk load flat files to raw.pe
for (i in 1:length(pe_files)) {

  execute_sql(connection = con,
              file_path = 'sql/schema_raw/bulk_load_tbl.sql',
              parameters = list(
                'database' = 'APCD',
                'table_name' = 'raw.pe',
                'data_path' = paste0('\\', pe_files[i]),
                'error_path' = paste0('\\errors\\mc_error', i),
                'delimiter' = '*'),
              log_table = 'dbo.etl_run_log')
}

# Convert raw.pe table to clustered columnstore
etl602 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.pe',
                        'index_name' = 'pe_cci'),
                      log_table = 'dbo.etl_run_log')

##### Drop and recreate raw.counties table #####

# Create raw.counties table
etl701 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/ddl_raw_counties_tbl.sql',
                      parameters = list(
                        'database' = 'APCD'),
                      log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.counties
etl702 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.counties',
                        'data_path' = '\\Counties.txt',
                        'error_path' = '\\errors\\counties',
                        'delimiter' = '*'),
                      log_table = 'dbo.etl_run_log')

# Convert raw.counties to clustered columnstore
etl703 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.counties',
                        'index_name' = 'counties_cci'),
                      log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.hgcpt table #####

# Create raw.hgcpt table
etl801 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/ddl_raw_hgcpt_tbl.sql',
                      parameters = list(
                        'database' = 'APCD'),
                      log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.hgcpt
etl802 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.hgcpt',
                        'data_path' = '\\HGCPT.txt',
                        'error_path' = '\\errors\\HGCPT',
                        'delimiter' = '*'),
                      log_table = 'dbo.etl_run_log')

# Convert raw.hgcpt to clustered columnstore
etl803 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.hgcpt',
                        'index_name' = 'hgcpt_cci'),
                      log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.mc_claim_consolidation table #####

# Create raw.mc_claim_consolidation table
etl901 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/ddl_raw_mc_claim_consolidation_tbl.sql',
                      parameters = list(
                        'database' = 'APCD'),
                      log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.mc_claim_consolidation
etl902 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.mc_claim_consolidation',
                        'data_path' = '\\MC_Claim_Consolidation_Include_2015_2019Q1.txt',
                        'error_path' = '\\errors\\MCCC',
                        'delimiter' = '*'),
                      log_table = 'dbo.etl_run_log')

# Convert raw.mc_claim_consolidation to clustered columnstore
etl903 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.mc_claim_consolidation',
                        'index_name' = 'mccc_cci'),
                      log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.mc_pi_providers_npid table #####

# Create raw.mc_pi_providers_npid table
etl1001 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/ddl_raw_mc_pi_providers_npid_tbl.sql',
                      parameters = list(
                        'database' = 'APCD'),
                      log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.mc_pi_providers_npid
etl1002 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.mc_pi_providers_npid',
                        'data_path' = '\\MC_PI_Providers_NoPayerID.txt',
                        'error_path' = '\\errors\\MCPIPNPID',
                        'delimiter' = '*'),
                      log_table = 'dbo.etl_run_log')

# Convert raw.mc_pi_providers_npid to clustered columnstore
etl1003 <- execute_sql(connection = con,
                      file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                      parameters = list(
                        'database' = 'APCD',
                        'table_name' = 'raw.mc_pi_providers_npid',
                        'index_name' = 'mcpipnpid_cci'),
                      log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.mc_pi_providers_master table #####

# Create raw.mc_pi_providers_master table
etl1101 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/ddl_raw_mc_pi_providers_master_tbl.sql',
                       parameters = list(
                         'database' = 'APCD'),
                       log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.mc_pi_providers_master
etl1102 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.mc_pi_providers_master',
                         'data_path' = '\\MC_PI_ProvidersMaster.txt',
                         'error_path' = '\\errors\\MCPIPMASTER',
                         'delimiter' = '*'),
                       log_table = 'dbo.etl_run_log')

# Convert raw.mc_pi_providers_master to clustered columnstore
etl1103 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.mc_pi_providers_master',
                         'index_name' = 'mcpipmaster_cci'),
                       log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.pc_providers_npid table #####

# Create raw.pc_providers_npid table
etl1201 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/ddl_raw_pc_providers_npid_tbl.sql',
                       parameters = list(
                         'database' = 'APCD'),
                       log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.pc_providers_npid
etl1202 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.pc_providers_npid',
                         'data_path' = '\\PC_Providers_NoPayerID.txt',
                         'error_path' = '\\errors\\PCPROVNPID',
                         'delimiter' = '*'),
                       log_table = 'dbo.etl_run_log')

# Convert raw.pc_providers_npid to clustered columnstore
etl1203 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.pc_providers_npid',
                         'index_name' = 'pcpnpid_cci'),
                       log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.pc_providers_master table #####

# Create raw.pc_providers_master table
etl1301 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/ddl_raw_pc_providers_master_tbl.sql',
                       parameters = list(
                         'database' = 'APCD'),
                       log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.pc_providers_master
etl1302 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.pc_providers_master',
                         'data_path' = '\\PC_ProvidersMaster.txt',
                         'error_path' = '\\errors\\PCPROVMASTER',
                         'delimiter' = '*'),
                       log_table = 'dbo.etl_run_log')

# Convert raw.pc_providers_master to clustered columnstore
etl1303 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.pc_providers_master',
                         'index_name' = 'pcpmaster_cci'),
                       log_table = 'dbo.etl_run_log')


##### Drop and recreate raw.pspec table #####

# Create raw.pspec table
etl1301 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/ddl_raw_pspec_tbl.sql',
                       parameters = list(
                         'database' = 'APCD'),
                       log_table = 'dbo.etl_run_log')

# Bulk load flat file to raw.pspec
etl1302 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/bulk_load_tbl.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.pspec',
                         'data_path' = '\\PSPEC.txt',
                         'error_path' = '\\errors\\PSPEC',
                         'delimiter' = '*'),
                       log_table = 'dbo.etl_run_log')

# Convert raw.pspec to clustered columnstore
etl1303 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/create_clustered_columnstore.sql',
                       parameters = list(
                         'database' = 'APCD',
                         'table_name' = 'raw.pspec',
                         'index_name' = 'pspec_cci'),
                       log_table = 'dbo.etl_run_log')



##### Create and load the fileid_payertype lookup tables #####

# Create the fileid_payertype lookup tables
etl1401 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/ddl_raw_fileid_payertype.sql',
                       parameters = list(
                         'database' = 'APCD'),
                       log_table = 'dbo.etl_run_log')


payertype_params <- tibble::tribble(
  ~table, ~file,
  "raw.MC_FILEID_PAYERTYPE", "DR_2018062601_MC_FileID_Payer_Type.txt",
  "raw.ME_FILEID_PAYERTYPE", "DR_2018062601_ME_FileID_Payer_Type.txt",
  "raw.PC_FILEID_PAYERTYPE", "DR_2018062601_PC_FileID_Payer_Type.txt",
  "raw.PE_FILEID_PAYERTYPE", "DR_2018062601_PE_FileID_Payer_Type.txt"
)

# Bulk load flat files
for (i in 1:nrow(payertype_params)) {

  execute_sql(connection = con,
              file_path = 'sql/schema_raw/bulk_load_tbl.sql',
              parameters = list(
                'database' = 'APCD',
                'table_name' = payertype_params$table[i],
                'data_path' = paste0('\\', payertype_params$file[i]),
                'error_path' = paste0('\\errors\\mc_error', i),
                'delimiter' = '*'),
              log_table = 'dbo.etl_run_log')
}


# Remove duplicate rows from these tables
etl1402 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/fix_fileid_payertype_tables.sql',
                       parameters = list(
                         'database' = 'APCD'),
                       log_table = 'dbo.etl_run_log')

####### Load the NPPES NPI tables #######

# Create the NPI table
etl1501 <- execute_sql(connection = con,
                       file_path = 'sql/schema_raw/ddl_raw_nppes_npi.sql',
                       parameters = list(
                         'database' = 'APCD'),
                       log_table = 'dbo.etl_run_log')

execute_sql(connection = con,
            file_path = 'sql/schema_raw/bulk_load_tbl.sql',
            parameters = list(
              'database' = 'APCD',
              'table_name' = 'raw.nppes_npi',
              'data_path' = '\\NPPES_Data_Dissemination_September_2019\\\\npidata_pfile_20050523-20190908.csv',
              'error_path' = '\\NPPES_Data_Dissemination_September_2019\\\\errors\\\\nppes_npi_error',
              'delimiter' = ','),
            log_table = 'dbo.etl_run_log')



##### Bind all log objects into a single dataframe #####

log_objs <- ls() %>%
  enframe(name = NULL) %>%
  filter(str_detect(value, pattern = 'etl'))

run_log <- map_dfr(log_objs$value, get)

rm(list = ls(pattern = '^etl[0-9]*$'))

##### Disconnect #####
dbDisconnect(con)




