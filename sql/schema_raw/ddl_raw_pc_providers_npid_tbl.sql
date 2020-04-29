/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.pc_providers_npid table
IF(OBJECT_ID('raw.pc_providers_npid') IS NOT NULL)
  BEGIN
    DROP TABLE raw.pc_providers_npid;
  END
;
GO

--Create raw.pc_providers_npid table
IF(OBJECT_ID('raw.pc_providers_npid') IS NULL)
  BEGIN
    CREATE TABLE raw.pc_providers_npid (
      PCSP902_DPCID VARCHAR(20)
      ,PCSP903_PHARM VARCHAR(50)
      ,PCSP905_PHARNM VARCHAR(200)
      ,PCSP906_NPHARM VARCHAR(50)
      ,PCSP907_PHARMCITY VARCHAR(50)
      ,PCSP908_PHARMST VARCHAR(5)
      ,PCSP909_PHARMZIP VARCHAR(20)
      ,PCSP910_PHARMID VARCHAR(20)
      ,PCSP911_PHARMCOUNTRY VARCHAR(5)
    );
  END
;