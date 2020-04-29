/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.counties table
IF(OBJECT_ID('raw.counties') IS NOT NULL)
  BEGIN
    DROP TABLE raw.counties;
  END
;
GO

--Create raw.counties table
IF(OBJECT_ID('raw.counties') IS NULL)
  BEGIN
    CREATE TABLE raw.counties (
      zpCountyFIPS VARCHAR(10)
      ,zpCountyName VARCHAR(50)
      ,zpStateName VARCHAR(50)
      ,zpStateAbbrev VARCHAR(5)
      ,zpStateFIPS VARCHAR(5)
    );
  END
;