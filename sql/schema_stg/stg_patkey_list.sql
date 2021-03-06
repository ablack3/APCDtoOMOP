/*
CREATE A TABLE WITH JUST THE PATIENT KEYS THAT WILL BE INCLUDED IN THE ETL

PARAMETER: NUM_PATIENTS - THE MAX NUMBER OF PATIENTS TO INCLUDE IN THE ETL

DEPENDENCIES:
    RAW.ME

*/

-- CREATE A LIST OF PATIENTS THAT WILL BE INCLUDED IN THE ETL
DROP TABLE IF EXISTS STG.PATKEY_LIST;
CREATE TABLE STG.PATKEY_LIST (
    PATKEY_CHR VARCHAR(30) NOT NULL
    ,PATKEY_INT INT NOT NULL
    );

WITH T1 AS(
    SELECT DISTINCT
        CAST(ME910_MHDO_MEMBERID AS VARCHAR(30)) AS PATKEY_CHR
        ,CAST(ME910_MHDO_MEMBERID AS INT) AS PATKEY_INT
    FROM RAW.ME
    WHERE ME910_MHDO_MEMBERID IS NOT NULL
)
,T2 AS(
    SELECT
        PATKEY_CHR
        ,PATKEY_INT
        ,DENSE_RANK() OVER(ORDER BY PATKEY_INT) AS RNK
    FROM T1
)
INSERT INTO STG.PATKEY_LIST (PATKEY_CHR, PATKEY_INT)
SELECT PATKEY_CHR, PATKEY_INT
FROM T2
WHERE RNK <= @NUM_PATIENTS@;

-- SELECT * FROM STG.PATKEY_LIST;
GO
