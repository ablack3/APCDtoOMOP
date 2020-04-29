/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.hgcpt table
IF(OBJECT_ID('raw.hgcpt') IS NOT NULL)
  BEGIN
    DROP TABLE raw.hgcpt;
  END
;
GO

--Create raw.hgcpt table
IF(OBJECT_ID('raw.hgcpt') IS NULL)
  BEGIN
    CREATE TABLE raw.hgcpt (
      HGCPT901_CODE VARCHAR(20)
      ,HGCPT902_PAYER VARCHAR(20)
      ,HGCPT903_DESCRIPTION VARCHAR(100)
      ,HGCPT904_EDATE VARCHAR(20)
    );
  END
;