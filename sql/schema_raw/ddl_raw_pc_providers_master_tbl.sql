/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.pc_providers_master table
IF(OBJECT_ID('raw.pc_providers_master') IS NOT NULL)
  BEGIN
    DROP TABLE raw.pc_providers_master;
  END
;
GO

--Create raw.pc_providers_master table
IF(OBJECT_ID('raw.pc_providers_master') IS NULL)
  BEGIN
    CREATE TABLE raw.pc_providers_master (
      PCPM901_DPCID VARCHAR(20)
      ,PCPM903_PHARMNM VARCHAR(150)
      ,PCPM904_NPHARM VARCHAR(40)
      ,PCPM905_PHARMCITY VARCHAR(50)
      ,PCPM906_PHARMST VARCHAR(5)
      ,PCPM907_PHARMZIP VARCHAR(20)
      ,PCPM908_PRVCOUNTRY VARCHAR(50)
    );
  END
;