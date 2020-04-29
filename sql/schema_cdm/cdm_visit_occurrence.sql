
/*
Populate the cdm.visit_occurrence table with records from the trm.visit_detail table


This is essentially a "roll up" where multiple visit detail records are collapsed into a single visit_occurrence record
When there are multiple values for a particular field (provider_id for example) a single value will be selected
 based on the total dollar amount on the claims


COLUMNS TO ROLL UP ARE
- VISIT START DATE
- VISIT END DATE
- PROVIDER_ID
- CARE_SITE_ID
- ADDMITTED_FROM AND DISCHARGED TO
- ORGANIZATION_ID

*/

-- POPULATE CDM.VISIT_OCCURRENCE BY ROLLING UP RECORDS IN TRM.VISIT_DETAIL TO THE VISIT LEVEL

TRUNCATE TABLE cdm.visit_occurrence;
WITH T1 AS(
    SELECT *
        ,MAX(CASE WHEN VISIT_DETAIL_SOURCE_VOCABULARY = 'CMS Place of Service' THEN 1 ELSE 0 END) OVER(PARTITION BY VISIT_OCCURRENCE_ID) AS PROFESSIONAL_COMPONENT_FLAG
        ,MAX(CASE WHEN VISIT_DETAIL_SOURCE_VOCABULARY = 'UB04 Typ bill' THEN 1 ELSE 0 END) OVER (PARTITION BY VISIT_OCCURRENCE_ID) AS FACILITY_COMPONENT_FLAG
    FROM TRM.VISIT_DETAIL
)
,T2 AS(
    SELECT
        VISIT_OCCURRENCE_ID
        ,PERSON_ID
        ,MIN(FDATE) OVER(PARTITION BY VISIT_OCCURRENCE_ID) AS VISIT_START_DATE
        ,MAX(LDATE) OVER(PARTITION BY VISIT_OCCURRENCE_ID) AS VISIT_END_DATE
        ,CASE
            WHEN PROFESSIONAL_COMPONENT_FLAG = 1 AND FACILITY_COMPONENT_FLAG = 1 THEN 32021 -- "VISIT DERIVED FROM MEDICAL CLAIM" WHICH WILL IMPLY THAT WE HAVE BOTH FACILITY AND PROFESSIONAL COMPONENTS
            WHEN FACILITY_COMPONENT_FLAG = 1 THEN 32023 -- "VISIT DERIVED FROM MEDICAL FACILITY CLAIM" WHICH WILL IMPLY THAT WE HAVE ONLY A FACILITY COMPONENT
            WHEN PROFESSIONAL_COMPONENT_FLAG = 1 THEN 32024 -- "VISIT DERIVED FROM MEDICAL PROFESSIONAL CLAIM" WHICH WILL IMPLY THAT WE HAVE ONLY A PROFESSIONAL COMPONENT
        END AS VISIT_TYPE_CONCEPT_ID
        ,PROVIDER_ID
        ,SUM(CASE WHEN PROVIDER_ID IS NULL THEN -100 ELSE ALLOWED_AMT END) OVER(PARTITION BY VISIT_OCCURRENCE_ID, PROVIDER_ID) AS PROVIDER_ID_WEIGHT
        ,CARE_SITE_ID
        ,SUM(CASE WHEN CARE_SITE_ID IS NULL THEN -100 ELSE ALLOWED_AMT END) OVER(PARTITION BY VISIT_OCCURRENCE_ID, CARE_SITE_ID) AS CARE_SITE_ID_WEIGHT
        ,ORGANIZATION_ID
        ,SUM(CASE WHEN ORGANIZATION_ID IS NULL THEN -100 ELSE ALLOWED_AMT END) OVER(PARTITION BY VISIT_OCCURRENCE_ID, ORGANIZATION_ID) AS ORGANIZATION_ID_WEIGHT
        -- HOW DO WE CHOOSE A SINGLE VISIT CONCEPT ID? USE SAME APPROACH?
        ,VISIT_DETAIL_CONCEPT_ID
        ,VISIT_DETAIL_SOURCE_CONCEPT_ID
        ,SUM(CASE WHEN VISIT_DETAIL_CONCEPT_ID IS NULL THEN -100 ELSE ALLOWED_AMT END) OVER(PARTITION BY VISIT_OCCURRENCE_ID, VISIT_DETAIL_CONCEPT_ID) AS VISIT_DETAIL_CONCEPT_ID_WEIGHT
        ,CONCAT(VISIT_DETAIL_SOURCE_VOCABULARY, ' | ', VISIT_DETAIL_SOURCE_VALUE) AS VISIT_DETAIL_SOURCE_VALUE
        -- CHO0SE ADMIT AND DISCHARGE CONCEPTS
        ,ADMITTED_FROM_CONCEPT_ID
        ,ADMITTED_FROM_SOURCE_VALUE
        ,DISCHARGE_TO_CONCEPT_ID
        ,DISCHARGE_TO_SOURCE_VALUE
        -- PRIORITZE ROWS WHERE WE HAVE BOTH ADMIT AND DISCHARGE POPULATED. TAKE BOTH ADMIT AND DISCHARGE FROM THE SAME ROW.
        ,SUM(
            CASE
                WHEN ADMITTED_FROM_CONCEPT_ID IS NULL AND DISCHARGE_TO_CONCEPT_ID IS NULL THEN -200
                WHEN ADMITTED_FROM_CONCEPT_ID IS NULL OR DISCHARGE_TO_CONCEPT_ID IS NULL THEN ALLOWED_AMT -100
                ELSE ALLOWED_AMT
            END
        ) OVER(PARTITION BY VISIT_OCCURRENCE_ID, ADMITTED_FROM_CONCEPT_ID) AS ADMIT_DISCHARGE_WEIGHT
    FROM T1
)
,T3 AS(
    SELECT DISTINCT
        VISIT_OCCURRENCE_ID
        ,PERSON_ID
        ,FIRST_VALUE(VISIT_DETAIL_CONCEPT_ID) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY VISIT_DETAIL_CONCEPT_ID_WEIGHT DESC) AS VISIT_CONCEPT_ID
        ,TRY_CAST(VISIT_START_DATE AS DATE) AS VISIT_START_DATE
        ,TRY_CAST(VISIT_START_DATE AS DATETIME2) AS VISIT_START_DATETIME
        ,TRY_CAST(VISIT_END_DATE AS DATE) AS VISIT_END_DATE
        ,TRY_CAST(VISIT_END_DATE AS DATETIME2) AS VISIT_END_DATETIME
        ,VISIT_TYPE_CONCEPT_ID
        ,FIRST_VALUE(PROVIDER_ID) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY PROVIDER_ID_WEIGHT DESC) AS PROVIDER_ID
        ,FIRST_VALUE(CARE_SITE_ID) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY CARE_SITE_ID_WEIGHT DESC) AS CARE_SITE_ID
        ,FIRST_VALUE(VISIT_DETAIL_SOURCE_VALUE) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY VISIT_DETAIL_CONCEPT_ID_WEIGHT DESC) AS VISIT_SOURCE_VALUE
        ,FIRST_VALUE(VISIT_DETAIL_SOURCE_CONCEPT_ID) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY VISIT_DETAIL_CONCEPT_ID_WEIGHT DESC) AS VISIT_SOURCE_CONCEPT_ID
        ,FIRST_VALUE(ADMITTED_FROM_CONCEPT_ID) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY ADMIT_DISCHARGE_WEIGHT DESC) AS ADMITTED_FROM_CONCEPT_ID
        ,FIRST_VALUE(ADMITTED_FROM_SOURCE_VALUE) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY ADMIT_DISCHARGE_WEIGHT DESC) AS ADMITTED_FROM_SOURCE_VALUE
        ,FIRST_VALUE(DISCHARGE_TO_CONCEPT_ID) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY ADMIT_DISCHARGE_WEIGHT DESC) AS DISCHARGE_TO_CONCEPT_ID
        ,FIRST_VALUE(DISCHARGE_TO_SOURCE_VALUE) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY ADMIT_DISCHARGE_WEIGHT DESC) AS DISCHARGE_TO_SOURCE_VALUE
        ,FIRST_VALUE(ORGANIZATION_ID) OVER(PARTITION BY VISIT_OCCURRENCE_ID ORDER BY ORGANIZATION_ID_WEIGHT DESC) AS ORGANIZATION_ID
    FROM T2
)
INSERT INTO cdm.visit_occurrence
SELECT
    VISIT_OCCURRENCE_ID
    ,PERSON_ID
    ,COALESCE(VISIT_CONCEPT_ID, 0) AS VISIT_CONCEPT_ID
    ,VISIT_START_DATE
    ,VISIT_START_DATETIME
    ,VISIT_END_DATE
    ,VISIT_END_DATETIME
    ,COALESCE(VISIT_TYPE_CONCEPT_ID, 0) AS VISIT_TYPE_CONCEPT_ID
    ,PROVIDER_ID
    ,CARE_SITE_ID
    ,VISIT_SOURCE_VALUE
    ,COALESCE(VISIT_SOURCE_CONCEPT_ID, 0) AS VISIT_SOURCE_CONCEPT_ID
    ,COALESCE(ADMITTED_FROM_CONCEPT_ID, 0) AS ADMITTED_FROM_CONCEPT_ID
    ,ADMITTED_FROM_SOURCE_VALUE
    ,COALESCE(DISCHARGE_TO_CONCEPT_ID, 0) AS DISCHARGE_TO_CONCEPT_ID
    ,DISCHARGE_TO_SOURCE_VALUE
    ,LAG(VISIT_OCCURRENCE_ID) OVER(PARTITION BY PERSON_ID ORDER BY VISIT_START_DATE) AS PRECEDING_VISIT_OCCURRENCE_ID
    ,ORGANIZATION_ID
FROM T3
;
GO

/*
-- CHECK THAT PRECEDING VISIT ID LOOKS CORRECT
SELECT TOP 100
    PERSON_ID
    ,visit_occurrence_id
    ,visit_start_date
    ,visit_end_date
    ,preceding_visit_occurrence_id
 FROM CDM.visit_occurrence ORDER BY PERSON_ID, visit_occurrence_id;


 SELECT TOP 100 * FROM CDM.VISIT_OCCURRENCE;

*/

-- CHECK THAT THERE IS ONLY ONE ROW PER VISIT OCCURRENCE ID
DECLARE @NUMBER FLOAT;
WITH T1 AS(
	SELECT VISIT_OCCURRENCE_ID, COUNT(*) AS N_RECORDS
	FROM CDM.visit_occurrence
	GROUP BY visit_occurrence_id
)
,T2 AS(
	SELECT
		N_RECORDS,
		COUNT(*) AS N_IDS,
		COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS PCT_IDS
	FROM T1
	GROUP BY N_RECORDS
)
SELECT @NUMBER = PCT_IDS FROM T2 WHERE N_RECORDS = 1;
IF @NUMBER != 100 THROW 50000, 'UNIQUE VISIT OCCURRENCE ID VAIDATION FAILED', 1;
GO


/*
COMPARE NUMBER OF DETAIL RECORDS TO NUMBER OF VISIT RECORDS
SELECT COUNT(*) FROM CDM.VISIT_DETAIL;
SELECT COUNT(*) FROM CDM.VISIT_OCCURRENCE;

*/


