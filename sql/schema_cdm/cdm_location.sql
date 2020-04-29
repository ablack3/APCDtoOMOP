/*
Dependencies: The cdm.location table must exist in the database

Create the location table. The source data for this table is from the website https://simplemaps.com/data/us-zips
We just need zip, city, state, latittude, longitude
Locations will just be at the zipcode level to make things easier for now.
*/


-- TRUNCATE TABLE cdm.location;
IF(OBJECT_ID('cdm.location') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.location;
    INSERT INTO cdm.location 
    SELECT 
      TRY_CAST(NULL AS VARCHAR(50)) AS address_1
      ,TRY_CAST(NULL AS VARCHAR(50)) AS address_2
      ,TRY_CAST(city AS VARCHAR(50)) AS city 
      ,TRY_CAST(SUBSTRING(state_id, 1, 2) AS VARCHAR(2)) AS state 
      ,TRY_CAST(SUBSTRING(zip, 1, 9) AS VARCHAR(9)) AS zip 
      ,TRY_CAST(SUBSTRING(county_name, 1, 20) AS VARCHAR(20))AS county 
      ,'USA' AS country
      ,TRY_CAST(zip AS VARCHAR(50)) AS location_source_value 
      ,TRY_CAST(lat AS FLOAT) AS latitude
      ,TRY_CAST(lng AS FLOAT) AS longitude
    FROM RAW.USZIPS
  END
;
GO 

-- VERIFY THAT THERE IS ONE ROW PER ZIPCODE IN THE LOCATION TABLE
DECLARE @NUMBER FLOAT;
WITH T1 AS(
	SELECT ZIP, COUNT(*) AS N_RECORDS
	FROM CDM.LOCATION
	GROUP BY ZIP
)
,T2 AS(
	SELECT
		N_RECORDS,
		COUNT(*) AS N_ZIPS,
		COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS PCT_ZIPS
	FROM T1
	GROUP BY N_RECORDS
)
-- SELECT * FROM T2
SELECT @NUMBER = PCT_ZIPS FROM T2 WHERE N_RECORDS = 1;
IF @NUMBER != 100 THROW 50000, 'ONE ROW PER ZIPCODE VAIDATION FAILED', 1;
GO
