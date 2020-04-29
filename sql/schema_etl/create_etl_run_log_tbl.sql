--Select database
USE @database@;
GO

--Create etl.run_log table
IF(OBJECT_ID('dbo.etl_run_log') IS NULL)
  BEGIN
    CREATE TABLE dbo.etl_run_log (
      log_event_id INTEGER IDENTITY(1,1) PRIMARY KEY
      ,pid VARCHAR(255)
      ,script_name VARCHAR(255)
      ,job_name VARCHAR(255)
      ,batch_number INTEGER
      ,parameters VARCHAR(1000)
      ,start_dtm DATETIME
      ,duration NUMERIC(18, 3)
      ,exit_status SMALLINT
      ,message VARCHAR(2000)
      ,user_name VARCHAR(100)
    );
  END
;