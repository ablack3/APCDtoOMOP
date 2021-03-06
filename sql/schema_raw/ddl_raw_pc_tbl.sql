/***********************
params: database
***********************/

--Select database
USE @database@;
GO


--Drop raw.pc table
IF(OBJECT_ID('raw.pc') IS NOT NULL)
  BEGIN
    DROP TABLE raw.pc;
  END
;
GO

--Create raw.pc table
IF(OBJECT_ID('raw.pc') IS NULL)
  BEGIN
    CREATE TABLE raw.pc (
    	PC005_LINE VARCHAR(10)
    	,PC011_REL VARCHAR(5)
    	,PC012_GENDER VARCHAR(5)
    	,PC014_PATCITY VARCHAR(50)
    	,PC015_PATST VARCHAR(5)
    	,PC016_PATZIP VARCHAR(20)
    	,PC017_PDATE VARCHAR(10)
    	,PC025_STATUS VARCHAR(5)
    	,PC026_NDC VARCHAR(20)
    	,PC027_DRUGNM VARCHAR(100)
    	,PC028_NEWPR VARCHAR(5)
    	,PC029_GENRX VARCHAR(5)
    	,PC030_DAW VARCHAR(5)
    	,PC031_COMPOUND VARCHAR(5)
    	,PC032_FDATE VARCHAR(10)
    	,PC033_QTY VARCHAR(20)
    	,PC034_DAYS VARCHAR(5)
    	,PC036_TPAY VARCHAR(25)
    	,PC037_INGRED VARCHAR(20)
    	,PC038_POSTAGE VARCHAR(20)
    	,PC039_DISPFEE VARCHAR(20)
    	,PC040_COPAY VARCHAR(20)
    	,PC041_COINS VARCHAR(20)
    	,PC042_DED VARCHAR(20)
    	,PC043_PTNPYAMT VARCHAR(20)
    	,PC899_RECTYPE VARCHAR(5)
    	,PC901_AGE VARCHAR(5)
    	,PC902_IDN VARCHAR(25)
    	,PC905_FILEID VARCHAR(10)
    	,PC906_MHDO_CLAIM VARCHAR(300)
    	,PC907_MHDO_SUBSSN VARCHAR(300)
    	,PC908_MHDO_CONTRACT VARCHAR(300)
    	,PC909_MHDO_MEMSSN VARCHAR(300)
    	,PC910_MHDO_MEMBERID VARCHAR(300)
    	,PC911_MHDO_GENDER VARCHAR(5)
    	,PC912_MHDO_PRODUCT VARCHAR(5)
    	,PC913_PHARMID VARCHAR(30)
    	,PC914_PAID_YR VARCHAR(10)
    	,PC915_PAID_MON VARCHAR(10)
    	,PC916_INCURRED_YR VARCHAR(10)
    	,PC917_INCURRED_MON VARCHAR(10)
    	,PC918_PAID_QTR VARCHAR(5)
    	,PC919_INCURRED_QTR VARCHAR(5)
    	,PC920_DEA_PRVIDN VARCHAR(10)
    	,PC950_PRESCRIBING_NPI VARCHAR(30)
    	,PC955_COUNTY_FIPS VARCHAR(10)
    );
  END
;