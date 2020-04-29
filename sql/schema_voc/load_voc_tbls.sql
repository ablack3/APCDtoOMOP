--Select database
USE @database;
GO

--Load cdm.drug_strength from csv
IF(OBJECT_ID('cdm.drug_strength') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.drug_strength;
    BULK INSERT cdm.drug_strength 
    FROM '@vocab_data_pathDRUG_STRENGTH.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathDRUG_STRENGTH.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.concept from csv
IF(OBJECT_ID('cdm.concept') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.concept;
    BULK INSERT cdm.concept 
    FROM '@vocab_data_pathCONCEPT.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathCONCEPT.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.concept_relationship from csv
IF(OBJECT_ID('cdm.concept_relationship') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.concept_relationship;
    BULK INSERT cdm.concept_relationship 
    FROM '@vocab_data_pathCONCEPT_RELATIONSHIP.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathCONCEPT_RELATIONSHIP.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.concept_ancestor from csv
IF(OBJECT_ID('cdm.concept_ancestor') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.concept_ancestor;
    BULK INSERT cdm.concept_ancestor 
    FROM '@vocab_data_pathCONCEPT_ANCESTOR.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathCONCEPT_ANCESTOR.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.concept_synonym from csv
IF(OBJECT_ID('cdm.concept_synonym') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.concept_synonym;
    BULK INSERT cdm.concept_synonym 
    FROM '@vocab_data_pathCONCEPT_SYNONYM.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathCONCEPT_SYNONYM.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.vocabulary from csv
IF(OBJECT_ID('cdm.vocabulary') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.vocabulary;
    BULK INSERT cdm.vocabulary 
    FROM '@vocab_data_pathVOCABULARY.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathVOCABULARY.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.relationship from csv
IF(OBJECT_ID('cdm.relationship') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.relationship;
    BULK INSERT cdm.relationship 
    FROM '@vocab_data_pathRELATIONSHIP.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathRELATIONSHIP.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.concept_class from csv
IF(OBJECT_ID('cdm.concept_class') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.concept_class;
    BULK INSERT cdm.concept_class 
    FROM '@vocab_data_pathCONCEPT_CLASS.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathCONCEPT_CLASS.bad',
    TABLOCK
    );
  END
;
GO

--Load cdm.domain from csv
IF(OBJECT_ID('cdm.domain') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm.domain;
    BULK INSERT cdm.domain 
    FROM '@vocab_data_pathDOMAIN.csv' 
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@vocab_error_pathDOMAIN.bad',
    TABLOCK
    );
  END
;
