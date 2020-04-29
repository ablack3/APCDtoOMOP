--Select database
USE @database;
GO

--Create cdm schema
IF(SCHEMA_ID('cdm') IS NULL)
  EXEC('CREATE SCHEMA cdm')
;