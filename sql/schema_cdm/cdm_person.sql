/*

-- LOAD THE CDM.PERSON TABLE

-- DEPENDENCIES:
    -- CDM.LOCATION
    -- STG.NPI
    -- STG.MC
    -- STG.ME
-- PROGAMMATICALLY ASSERT THAT THESE DEPENENCY TABLES ARE FULLY POPULATED BEFORE PROCEEDING
-- HOW DO YOU WRITE THIS KIND OF CHECK IN SQL?
-- SELECT COUNT(*) AS N FROM CDM.LOCATION;
-- SELECT COUNT(*) AS N FROM STG.NPI;
-- SELECT COUNT(*) AS N FROM CDM.MC;
-- SELECT COUNT(*) AS N FROM CDM.ME;


-- SELECT TOP 10 * FROM STG.NPI
*/


-- CREATE A TABLE OF POTENTIAL PCPS USING THE EXPANDED LIST OF TAXONOMY CODES FROM DICKSTEIN BOOK PAGE 36.
DROP TABLE IF EXISTS ##PCP;
SELECT NPI AS PCP_NPI, PRVNAME AS PCP_NAME
INTO ##PCP
FROM STG.NPI
WHERE PRIMARY_TAXONOMY_CODE IN ('207Q00000X', '207R00000X', '208D00000X', '207QG0300X', '207RG0300X', '207V00000X', '208000000X') AND
    PRVSTATE = 'ME' AND
    ENTTYPE = 'INDIVIDUAL';
GO

-- DETERMINE PRIMARY CARE PHYSICIAN FOR EACH PATIENT (IF ONE EXISTS)
DROP TABLE IF EXISTS ##PATKEY_PCP;
WITH T1 AS(
SELECT DISTINCT MHDO_CLAIM, PATKEY, FACTYPE, FDATE, SERVICING_NPI AS NPI, CPT,
    -- PHYSICAL EXAM CPT CODES
    CASE WHEN CPT IN ('99381', '99382', '99383', '99384', '99385', '99386', '99387', '99391', '99392', '99393', '99394', '99395', '99396', '99397') THEN 1 ELSE 0 END AS PHYS_EXAM,
    CASE WHEN FACTYPE = 11 THEN 1 ELSE 0 END AS OFFICE_VISIT
FROM STG.MC A
INNER JOIN ##PCP B
ON A.NPI = B.PCP_NPI
)
,T2 AS(
    SELECT PATKEY, NPI, FDATE, MAX(PHYS_EXAM) AS PHYS_EXAM, MAX(OFFICE_VISIT) AS OFFICE_VISIT
    FROM T1
    GROUP BY PATKEY, NPI, FDATE
)
,T3 AS(
    SELECT *,
        CASE WHEN PHYS_EXAM = 1 THEN FDATE ELSE NULL END AS PHYS_EXAM_DATE,
        CASE WHEN OFFICE_VISIT = 1 THEN FDATE ELSE NULL END AS OFFICE_VISIT_DATE
    FROM T2
)
,T4 AS(
    SELECT PATKEY, NPI,
        COUNT(*) AS VISIT_CNT,
        MAX(PHYS_EXAM_DATE) AS DATE_LAST_PHYSEXAM,
        MAX(OFFICE_VISIT_DATE) AS DATE_LAST_OFFICE_VISIT,
        MAX(FDATE) AS DATE_LAST_VISIT
    FROM T3
    GROUP BY PATKEY, NPI
)
,T5 AS(
SELECT PATKEY, NPI, VISIT_CNT, DATE_LAST_PHYSEXAM, DATE_LAST_OFFICE_VISIT, DATE_LAST_VISIT,
    COUNT(*) OVER (PARTITION BY PATKEY) AS N,
    ROW_NUMBER() OVER (PARTITION BY PATKEY ORDER BY PATKEY, VISIT_CNT DESC, DATE_LAST_PHYSEXAM DESC, DATE_LAST_OFFICE_VISIT DESC, DATE_LAST_VISIT DESC) AS ROW_ORDER
FROM T4
)
SELECT PATKEY, NPI AS PROVIDER_ID
INTO ##PATKEY_PCP
FROM T5
WHERE ROW_ORDER = 1;
GO



-- VERIFY WE HAVE ONE PCP VALUE PER PATKEY
SELECT N_ROWS, COUNT(*) AS N_PRIMARY_KEY_VALUES
FROM (
    SELECT PATKEY, COUNT(*) AS N_ROWS
    FROM ##PATKEY_PCP
    GROUP BY PATKEY
) A
GROUP BY N_ROWS;
-- LOG THE RESULT - EXPECTING ONE ROW
GO


-- CREATE ##TMP_PATIENT TABLE WITH DATA FROM STG.ME
-- THIS QUERY SEEMS UNREASONABLY SLOW
DROP TABLE IF EXISTS ##TMP_PATIENT;
WITH T1 AS(
    SELECT DISTINCT
        A.PATKEY
        ,A.BIRTHYEAR
        ,A.GENDER
        ,FIRST_VALUE(A.PATZIP) OVER(PARTITION BY A.PATKEY ORDER BY A.YEAR DESC, A.MONTH DESC) AS PATZIP
    FROM STG.ME A
)
,T2 AS(
    SELECT T1.*,
        B.PROVIDER_ID
    FROM T1
    LEFT JOIN ##PATKEY_PCP B
    ON T1.PATKEY = B.PATKEY
)
,T3 AS(
    SELECT T2.*,
        B.ZIP,
        B.LOCATION_ID
    FROM T2
    LEFT JOIN (
        SELECT ZIP, LOCATION_ID
        FROM CDM.LOCATION
        WHERE LOCATION_SOURCE_VALUE = 'us_zips') B
    ON T2.PATZIP = B.ZIP
)
SELECT T3.*,
    CASE WHEN GENDER = 'M' THEN 8507
        WHEN GENDER = 'F' THEN 8532
        ELSE 0
    END AS GENDER_CONCEPT_ID
INTO ##TMP_PATIENT
FROM T3;
GO

/*
-- JOIN TO LOCATION TABLE

-- SELECT TOP 100 * FROM ##TMP_PATIENT
-- SELECT TOP 100 * FROM CDM.LOCATION
*/

-- VERIFY WE HAVE ROW PER PATKEY
SELECT N_ROWS, COUNT(*) AS N_PRIMARY_KEY_VALUES
FROM (
    SELECT PATKEY, COUNT(*) AS N_ROWS
    FROM ##TMP_PATIENT
    GROUP BY PATKEY
) A
GROUP BY N_ROWS;
GO

/*
-- DOES LOCATION TABLE HAVE ONE ROW PER ZIP
-- SELECT TOP 100 * FROM CDM.LOCATION

-- SELECT N_ROWS, COUNT(*) AS N_PRIMARY_KEY_VALUES
-- FROM (
--     SELECT ZIP, COUNT(*) AS N_ROWS
--     FROM CDM.LOCATION
--     WHERE LOCATION_SOURCE_VALUE = 'us_zips'
--     GROUP BY ZIP
-- ) A
-- GROUP BY N_ROWS;
-- YES WHEN WE RESTRICT TO THE US ZIPS DATA

-- SELECT TOP 100 * FROM ##TMP_PATIENT
-- RENAME COLUMNS AND LOAD CDM TABLE
*/

-- LOAD DATA INTO CDM.PERSON
TRUNCATE TABLE CDM.PERSON;
INSERT INTO CDM.PERSON(
    PERSON_ID
    ,GENDER_CONCEPT_ID
    ,YEAR_OF_BIRTH
    ,MONTH_OF_BIRTH
    ,DAY_OF_BIRTH
    ,BIRTH_DATETIME
    ,DEATH_DATETIME
    ,RACE_CONCEPT_ID
    ,ETHNICITY_CONCEPT_ID
    ,LOCATION_ID
    ,PROVIDER_ID
    ,CARE_SITE_ID
    ,PERSON_SOURCE_VALUE
    ,GENDER_SOURCE_VALUE
    ,GENDER_SOURCE_CONCEPT_ID
    ,RACE_SOURCE_VALUE
    ,RACE_SOURCE_CONCEPT_ID
    ,ETHNICITY_SOURCE_VALUE
    ,ETHNICITY_SOURCE_CONCEPT_ID
)
SELECT TOP 1000000
    PATKEY AS PERSON_ID
    ,GENDER_CONCEPT_ID
    ,BIRTHYEAR AS YEAR_OF_BIRTH
    ,NULL AS MONTH_OF_BIRTH
    ,NULL AS DAY_OF_BIRTH
    ,NULL AS BIRTH_DATETIME
    ,NULL AS DEATH_DATETIME
    ,0 AS RACE_CONCEPT_ID
    ,0 AS ETHNICITY_CONCEPT_ID
    ,LOCATION_ID
    ,PROVIDER_ID
    ,NULL AS CARE_SITE_ID -- PERHAPS USE THIS TO TIE PATIENTS TO ORGANIZATIONS?
    ,NULL AS PERSON_SOURCE_VALUE
    ,GENDER AS GENDER_SOURCE_VALUE
    ,GENDER_CONCEPT_ID AS GENDER_SOURCE_CONCEPT_ID
    ,NULL AS RACE_SOURCE_VALUE
    ,0 AS RACE_SOURCE_CONCEPT_ID
    ,NULL AS ETHNICITY_SOURCE_VALUE
    ,0 AS ETHNICITY_SOURCE_CONCEPT_ID
FROM ##TMP_PATIENT
WHERE BIRTHYEAR IS NOT NULL;

-- SELECT TOP 10 * FROM CDM.PERSON
GO


-- DROP TEMP TABLES
DROP TABLE IF EXISTS ##TMP_PATIENT;
DROP TABLE IF EXISTS ##PATKEY_PCP;
DROP TABLE IF EXISTS ##PCP;
GO


