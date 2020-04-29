/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.hgdx table
IF(OBJECT_ID('raw.hgdx') IS NOT NULL)
  BEGIN
    DROP TABLE raw.hgdx;
  END
;
GO

--Create raw.hgdx table
IF(OBJECT_ID('raw.hgdx') IS NULL)
  BEGIN
    CREATE TABLE raw.hgdx (
      HGDX901_CODE VARCHAR(10)
      ,HGDX902_PAYER VARCHAR(10)
      ,HGDX903_DESCRIPTION VARCHAR(100)
    );
  END
;