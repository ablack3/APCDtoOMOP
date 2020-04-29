/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.mc_claim_consolidation table
IF(OBJECT_ID('raw.mc_claim_consolidation') IS NOT NULL)
  BEGIN
    DROP TABLE raw.mc_claim_consolidation;
  END
;
GO

--Create raw.mc_claim_consolidation table
IF(OBJECT_ID('raw.mc_claim_consolidation') IS NULL)
  BEGIN
    CREATE TABLE raw.mc_claim_consolidation (
      MC907_MHDO_CLAIM VARCHAR(300)
      ,MC902_IDN VARCHAR(50)
    );
  END
;