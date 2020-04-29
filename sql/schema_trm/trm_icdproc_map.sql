/*
THIS SCRIPT CREATES THE TRM.ICDPROC_MAP TABLE WHICH IS A
CROSSWALK BETWEEN ICD CODES AND THIER STANDARD CONCEPTS

IT POPULATES EACH OF THE TRM EVENT TABLES WITH DATA FROM THE STG.ICDPROC TABLE (ICD PROCEDURE CODES)


ICD procedure codes map to the following domains
-- condition
-- Observation,
-- procedure

WE WILL TREAT ICD PROCEDURES AS CLAIM HEADER LEVEL INFORMATION (IS THIS TRUE?)
THUS WE WILL USE ALL INFORMATION ON THE CLAIM TO IDENTIFY DATES AND PROVIDER FOR ICD PROCEDURE CODES
COSTS WILL NOT BE LINKED DIRECTLY FOR ICD PROCEDURE CODES
*/



-- CREATE ##ICD_PROC_MAP CROSSWALK SOURCE TO STANDARD TABLE
DROP TABLE IF EXISTS  ##ICD_PROC_MAP;
-- Get ICD codes
WITH T1 AS(
SELECT 
    VOCABULARY_ID AS SOURCE_VOCABULARY_ID,
    REPLACE(CONCEPT_CODE, '.', '') AS SOURCE_CONCEPT_CODE,
    CONCEPT_ID AS SOURCE_CONCEPT_ID
FROM CDM.CONCEPT
WHERE VOCABULARY_ID IN ('ICD9Proc', 'ICD10PCS')
),
-- Get the standard condtion concepts
T2 AS(
    SELECT T1.*,
        RELATIONSHIP_ID,
        CR.CONCEPT_ID_2 AS TARGET_CONCEPT_ID
    FROM T1
    INNER JOIN CDM.CONCEPT_RELATIONSHIP CR
    ON T1.SOURCE_CONCEPT_ID = CR.CONCEPT_ID_1
    WHERE RELATIONSHIP_ID = 'Maps to' -- DO WE NEED TO INCLUDE 'MAPS TO VALUE'?
),
-- Get the concept info for the standard concepts
T3 AS(
SELECT *
FROM T2
INNER JOIN CDM.CONCEPT C
    ON T2.TARGET_CONCEPT_ID = C.CONCEPT_ID
),
SOURCE_ICD_PROC AS(
    SELECT VOCABULARY, ICD_PROC, COUNT(*) AS N_RECORDS
    FROM STG.ICD_PROC
    GROUP BY VOCABULARY, ICD_PROC
)
SELECT
    VOCABULARY,
    ICD_PROC,
    N_RECORDS,
    COALESCE(CONCEPT_ID, 0) AS PROCEDURE_CONCEPT_ID,
    -- DEFAULT DOMAIN FOR ICD PROCEDURE CODES IS PROCEDURE DOMAIN
    COALESCE(DOMAIN_ID, 'Procedure') AS DOMAIN_ID,
    ICD_PROC AS PROCEDURE_SOURCE_VALUE,
    COALESCE(SOURCE_CONCEPT_ID, 0) AS PROCEDURE_SOURCE_CONCEPT_ID
INTO ##ICD_PROC_MAP
FROM SOURCE_ICD_PROC
LEFT JOIN T3
ON SOURCE_ICD_PROC.VOCABULARY = T3.SOURCE_VOCABULARY_ID AND SOURCE_ICD_PROC.ICD_PROC = T3.SOURCE_CONCEPT_CODE;

GO

/*
SELECT COUNT(*) FROM ##ICD_PROC_MAP
SELECT COUNT(DISTINCT ICD_PROC) FROM STG.ICD_PROC
SELECT COUNT(*) FROM STG.ICD_PROC

SELECT COUNT(DISTINCT MHDO_CLAIM) FROM STG.ICD_PROC
SELECT DISTINCT DOMAIN_ID FROM ##ICD_PROC_MAP

*/

-- CREATE CLAIM HEADER LEVEL DATA WITH DATES, PROVIDER AND VISIT ID
DROP TABLE IF EXISTS ##CLAIM_LEVEL_DATA;
WITH T0 AS(
    -- SUBSET ONLY CLAIM RECORDS THAT HAVE ICD PROCEDURE CODES ON THEM
    SELECT A.* 
    FROM STG.MC A
    INNER JOIN STG.ICD_PROC B
    ON A.MHDO_CLAIM = B.MHDO_CLAIM
)
,T1 AS(
    -- ROLL UP TO CLAIM LEVEL
    SELECT DISTINCT
        MHDO_CLAIM
        ,MIN(FDATE) OVER(PARTITION BY MHDO_CLAIM) AS MIN_FDATE
        ,MAX(LDATE) OVER(PARTITION BY MHDO_CLAIM) AS MAX_LDATE
        -- MAX(BILLTYPE) OVER(PARTITION BY MHDO_CLAIM) AS BILLTYPE,
        -- MAX(FACTYPE) OVER(PARTITION BY MHDO_CLAIM) AS FACTYPE,
        -- TAKE THE NPI WITH THE LARGEST TPAY AMT UNLESS IT IS NULL
        ,FIRST_VALUE(NPI) OVER(PARTITION BY MHDO_CLAIM ORDER BY IIF(NPI IS NULL, -1000000, TPAY) DESC) AS NPI
        ,FIRST_VALUE(SERVICING_NPI) OVER(PARTITION BY MHDO_CLAIM ORDER BY IIF(SERVICING_NPI IS NULL, -1000000, TPAY) DESC) AS SERVICING_NPI
        ,FIRST_VALUE(ATT_NPI) OVER(PARTITION BY MHDO_CLAIM ORDER BY IIF(ATT_NPI IS NULL, -1000000, TPAY) DESC) AS ATT_NPI
        ,FIRST_VALUE(OP_NPI) OVER(PARTITION BY MHDO_CLAIM ORDER BY IIF(OP_NPI IS NULL, -1000000, TPAY) DESC) AS OP_NPI
    FROM T0
)
,T2 AS(
    --PULL OUT INDIVIDUAL PROVIDER
    SELECT
        MHDO_CLAIM
        ,MIN_FDATE
        ,MAX_LDATE
        ,COALESCE(
            CASE WHEN OP_NPI IN(SELECT NPI FROM CDM.PROVIDER) THEN OP_NPI ELSE NULL END
            ,CASE WHEN ATT_NPI IN(SELECT NPI FROM CDM.PROVIDER) THEN ATT_NPI ELSE NULL END
            ,CASE WHEN SERVICING_NPI IN(SELECT NPI FROM CDM.PROVIDER) THEN SERVICING_NPI ELSE NULL END
            ,CASE WHEN NPI IN(SELECT NPI FROM CDM.PROVIDER) THEN NPI ELSE NULL END
        ) AS PROVIDER_ID
      FROM T1
)
,VISIT AS(
    -- GET CLAIM NUMBER TO VISIT CROSSWALK
    -- WE HAVE A RULE THAT CLAIMS MUST CLEANLY ROLL UP INTO VISITS TO AVOID CONFUSION (CLAIMS NEST WITHIN VISITS)
    SELECT DISTINCT
        B.MHDO_CLAIM
        ,A.VISIT_OCCURRENCE_ID
        ,A.PROVIDER_ID
    FROM CDM.visit_occurrence A
    JOIN (SELECT DISTINCT MHDO_CLAIM, VISIT_OCCURRENCE_ID FROM TRM.VISIT_DETAIL) B
    ON A.VISIT_OCCURRENCE_ID = B.VISIT_OCCURRENCE_ID
)
SELECT
    T2.MHDO_CLAIM
    ,T2.MIN_FDATE
    ,T2.MAX_LDATE
    -- USE PROVIDER ON VISIT IF WE DONT HAVE ONE ON CLAIM
    ,COALESCE(T2.PROVIDER_ID, VISIT.PROVIDER_ID) AS PROVIDER_ID
    ,VISIT.VISIT_OCCURRENCE_ID
INTO ##CLAIM_LEVEL_DATA
FROM T2
JOIN  VISIT
ON T2.MHDO_CLAIM = VISIT.MHDO_CLAIM
-- ORDER BY MHDO_CLAIM
;
GO

/*

SELECT DOMAIN_ID, COUNT(*)
FROM STG.ICD_PROC PR
INNER JOIN ##ICD_PROC_MAP MAP
ON PR.ICD_PROC = MAP.ICD_PROC AND PR.VOCABULARY = MAP.VOCABULARY
GROUP BY DOMAIN_ID
*/

-- INSERT ICD/DX RECORDS INTO THE STG.CONDITION_OCCURRENCE TABLE
DELETE FROM TRM.CONDITION_OCCURRENCE WHERE SOURCE = 'STG.ICD_PROC';
INSERT INTO TRM.CONDITION_OCCURRENCE
SELECT
    PR.PATKEY AS PERSON_ID
    ,MAP.PROCEDURE_CONCEPT_ID
    ,CLM.MIN_FDATE AS CONDITION_START_DATE
    ,TRY_CAST(CLM.MIN_FDATE AS DATETIME) AS CONDITION_START_DATETIME
    ,CLM.MAX_LDATE AS CONDITION_END_DATE
    ,TRY_CAST(CLM.MAX_LDATE AS DATETIME) AS CONDITION_END_DATETIME
    ,CASE WHEN PR.PRIMARY_FLAG = 1 THEN 44786627 ELSE 0 END AS CONDITION_TYPE_CONCEPT_ID
    ,0 AS CONDITION_STATUS_CONCEPT_ID
    ,NULL AS STOP_REASON
    ,CLM.PROVIDER_ID
    ,CLM.VISIT_OCCURRENCE_ID
    ,NULL AS VISIT_DETAIL_ID
    ,MAP.PROCEDURE_SOURCE_VALUE
    ,MAP.PROCEDURE_SOURCE_CONCEPT_ID
    ,TRY_CAST(PR.PRIMARY_FLAG AS VARCHAR(5)) AS CONDITION_STATUS_SOURCE_VALUE
    ,CAST('STG.ICD_PROC' AS VARCHAR(20)) AS SOURCE
FROM STG.ICD_PROC PR
INNER JOIN ##ICD_PROC_MAP MAP
ON PR.ICD_PROC = MAP.ICD_PROC AND PR.VOCABULARY = MAP.VOCABULARY
INNER JOIN ##CLAIM_LEVEL_DATA CLM
ON PR.MHDO_CLAIM = CLM.MHDO_CLAIM
WHERE MAP.DOMAIN_ID = 'Condition'; -- OR DOMAIN_ID IS NULL?
GO

-- INSERT ICD PROCDEURE CODE RECORDS INTO STG.PROCEDURE_OCCURRENCE
DELETE FROM TRM.PROCEDURE_OCCURRENCE WHERE SOURCE = 'STG.ICD_PROC';
INSERT INTO TRM.PROCEDURE_OCCURRENCE
SELECT
    PR.PATKEY AS PERSON_ID
    ,MAP.PROCEDURE_CONCEPT_ID
    ,CLM.MIN_FDATE AS PROCEDURE_DATE
    ,TRY_CAST(CLM.MIN_FDATE AS DATETIME) AS PROCEDURE_DATETIME
    ,32468 AS PROCEDURE_TYPE_CONCEPT_ID -- 32468 = INFERRED FROM CLAIM
    ,0 AS MODIFIER_CONCEPT_ID
    ,NULL AS QUANTITY
    ,CLM.PROVIDER_ID
    ,CLM.VISIT_OCCURRENCE_ID
    ,NULL AS VISIT_DETAIL_ID
    ,MAP.PROCEDURE_SOURCE_VALUE
    ,MAP.PROCEDURE_SOURCE_CONCEPT_ID
    ,NULL AS MODIFIER_SOURCE_VALUE
    ,'STG.ICD_PROC' AS SOURCE
FROM STG.ICD_PROC PR
INNER JOIN ##ICD_PROC_MAP MAP
ON PR.ICD_PROC = MAP.ICD_PROC AND PR.VOCABULARY = MAP.VOCABULARY
INNER JOIN ##CLAIM_LEVEL_DATA CLM
ON PR.MHDO_CLAIM = CLM.MHDO_CLAIM
WHERE MAP.DOMAIN_ID = 'Procedure';
GO

-- INSERT ICD/DX RECORDS INTO STG.OBSERVATION TABLE
DELETE FROM TRM.OBSERVATION WHERE SOURCE = 'STG.ICD_PROC';
INSERT INTO TRM.OBSERVATION
SELECT
    PR.PATKEY AS PERSON_ID
    ,MAP.PROCEDURE_CONCEPT_ID AS OBSERVATION_CONCEPT_ID
    ,CLM.MIN_FDATE AS OBSERVATION_DATE
    ,TRY_CAST(CLM.MIN_FDATE AS DATETIME) AS OBSERVATION_DATETIME
    ,CAST(32467 AS INTEGER) AS OBSERVATION_TYPE_CONCEPT_ID -- 32467 = INFERRED FROM CLAIM
    ,NULL AS VALUE_AS_NUMBER
    ,NULL AS VALUE_AS_STRING
    ,NULL AS VALUE_AS_CONCEPT_ID
    ,NULL AS QUALIFIER_CONCEPT_ID
    ,NULL AS UNIT_CONCEPT_ID
    ,CLM.PROVIDER_ID
    ,CLM.VISIT_OCCURRENCE_ID
    ,NULL AS VISIT_DETAIL_ID
    ,MAP.PROCEDURE_SOURCE_VALUE AS OBSERVATION_SOURCE_VALUE
    ,MAP.PROCEDURE_SOURCE_CONCEPT_ID AS OBSERVATION_SOURCE_CONCEPT_ID
    ,NULL AS UNIT_SOURCE_VALUE
    ,NULL AS QUALIFIER_SOURCE_VALUE
    ,NULL AS OBSERVATION_EVENT_ID
    ,0 AS OBS_EVENT_FIELD_CONCEPT_ID
    ,NULL AS VALUE_AS_DATETEIME
    ,'STG.ICD_PROC' AS SOURCE
FROM STG.ICD_PROC PR
INNER JOIN ##ICD_PROC_MAP MAP
ON PR.ICD_PROC = MAP.ICD_PROC AND PR.VOCABULARY = MAP.VOCABULARY
INNER JOIN ##CLAIM_LEVEL_DATA CLM
ON PR.MHDO_CLAIM = CLM.MHDO_CLAIM
WHERE MAP.DOMAIN_ID = 'Observation';
GO

/*
NEED TO KEEP TRACK OF HOW MANY RECORDS ARE BEING DROPPED AT EACH STAGE
*/

