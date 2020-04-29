/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.mc_pi_providers_master table
IF(OBJECT_ID('raw.mc_pi_providers_master') IS NOT NULL)
  BEGIN
    DROP TABLE raw.mc_pi_providers_master;
  END
;
GO

--Create raw.mc_pi_providers_master table
IF(OBJECT_ID('raw.mc_pi_providers_master') IS NULL)
  BEGIN
    CREATE TABLE raw.mc_pi_providers_master (
      MCPM001_DPCID VARCHAR(20)
      ,MCPM003_FACILITY_NAME VARCHAR(100)
      ,MCPM004_FACILITY_CODE VARCHAR(20)
      ,MCPM005_PRVFNAME VARCHAR(50)
      ,MCPM006_PRVMNAME VARCHAR (50)
      ,MCPM007_PRVLNAME VARCHAR(100)
      ,MCPM008_PRVSUFFIX VARCHAR(20)
      ,MCPM009_PRVTITLE VARCHAR(20)
      ,MCPM010_PRVST VARCHAR(5)
      ,MCPM011_TAXONOMY VARCHAR(20)
      ,MCPM013_NPI VARCHAR(40)
      ,MCPM015_PRVCOUNTRY VARCHAR(50)
    );
  END
;