
-- CREATE STG.NPI TABLE
DROP TABLE IF EXISTS STG.NPI;
WITH T1 AS(
    SELECT
        --TOP 10
        CAST(TRIM(NPI) AS VARCHAR(10)) AS NPI
        ,CASE 
            WHEN ENTITY_TYPE_CODE = '1' THEN 'INDIVIDUAL'
            WHEN ENTITY_TYPE_CODE = '2' THEN 'ORGANIZATION'
            ELSE NULL 
        END AS ENTTYPE
        ,PROVIDER_ORGANIZATION_NAME AS ORGNAME
        ,PROVIDER_OTHER_ORGANIZATION_NAME AS ORGNAME2
        ,CASE WHEN PROVIDER_FIRST_NAME IS NULL THEN '' ELSE PROVIDER_FIRST_NAME END AS PROVIDER_FIRST_NAME
        ,CASE WHEN PROVIDER_MIDDLE_NAME IS NULL THEN '' ELSE ' ' + PROVIDER_MIDDLE_NAME END AS PROVIDER_MIDDLE_NAME
        ,CASE WHEN PROVIDER_LAST_NAME IS NULL THEN '' ELSE ' ' + PROVIDER_LAST_NAME END AS PROVIDER_LAST_NAME
        ,PROVIDER_FIRST_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS as PRVADDRESS 
        ,PROVIDER_SECOND_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS AS PRVADDRESS2 
        ,PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_CITY_NAME AS PRVCITY 
        ,PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_STATE_NAME AS PRVSTATE 
        ,PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_POSTAL_CODE AS PRVZIP
        ,CAST(LAST_UPDATE_DATE AS DATE) AS LAST_UPDATE_DATE
        ,CASE 
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_1 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_1
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_2 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_2
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_3 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_3
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_4 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_4
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_5 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_5
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_6 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_6
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_7 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_7
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_8 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_8
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_9 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_9
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_10 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_10
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_11 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_11
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_12 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_12
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_13 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_13
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_14 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_14
            WHEN HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_15 = 'Y' THEN HEALTHCARE_PROVIDER_TAXONOMY_CODE_15
            ELSE NULL 
        END AS PRIMARY_TAXONOMY_CODE
    FROM RAW.NPPES_NPI
)
,T2 AS(
    SELECT 
        NPI 
        ,ENTTYPE 
        ,ORGNAME 
        ,ORGNAME2 
        -- ,CAST(NPI AS BIGINT) AS NPI_INT
        ,CASE WHEN PROVIDER_FIRST_NAME <> '' OR PROVIDER_MIDDLE_NAME <> '' OR PROVIDER_LAST_NAME <> '' 
            THEN PROVIDER_FIRST_NAME + PROVIDER_MIDDLE_NAME + PROVIDER_LAST_NAME 
            ELSE NULL 
        END AS PRVNAME
        ,PRVADDRESS 
        ,PRVADDRESS2 
        ,PRVCITY 
        ,PRVSTATE
        ,PRVZIP 
        ,PRIMARY_TAXONOMY_CODE
        ,CONCEPT.CONCEPT_NAME AS PRIMARY_TAXONOMY_DESCRIPTION
        ,LAST_UPDATE_DATE
    FROM T1 LEFT JOIN (SELECT * FROM CDM.CONCEPT WHERE VOCABULARY_ID = 'NUCC') CONCEPT
    ON T1.PRIMARY_TAXONOMY_CODE = CONCEPT.CONCEPT_CODE
)
SELECT * INTO STG.NPI FROM T2
GO

-- ADD INDEX TO NPI BASED ON NPI 
CREATE CLUSTERED INDEX NPI_IDX_NPI  
    ON STG.NPI (NPI);   
GO  
