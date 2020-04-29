/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.pspec table
IF(OBJECT_ID('raw.pspec') IS NOT NULL)
  BEGIN
    DROP TABLE raw.pspec;
  END
;
GO

--Create raw.pspec table
IF(OBJECT_ID('raw.pspec') IS NULL)
  BEGIN
    CREATE TABLE raw.pspec (
      PS901_PRVSPEC VARCHAR(150)
      ,PS902_PAYER VARCHAR(20)
      ,PS903_DESCRIPTION VARCHAR(400)
    );
  END
;