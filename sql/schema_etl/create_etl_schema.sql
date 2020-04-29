--Select database
USE @database;
GO

--Create etl schema
IF(SCHEMA_ID('etl') IS NULL)
  EXEC('CREATE SCHEMA etl')
;