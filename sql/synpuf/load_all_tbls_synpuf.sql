USE omop_synpuf;
GO

IF(OBJECT_ID('cdm_synpuf.concept') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.concept;
    BULK INSERT cdm_synpuf.concept 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\concept.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\concept.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.drug_strength') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.drug_strength;
    BULK INSERT cdm_synpuf.drug_strength 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\drug_strength.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\drug_strength.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.concept_relationship') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.concept_relationship;
    BULK INSERT cdm_synpuf.concept_relationship 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\concept_relationship.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\concept_relationship.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.concept_ancestor') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.concept_ancestor;
    BULK INSERT cdm_synpuf.concept_ancestor 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\concept_ancestor.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\concept_ancestor.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.concept_synonym') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.concept_synonym;
    BULK INSERT cdm_synpuf.concept_synonym 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\concept_synonym.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\concept_synonym.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.vocabulary') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.vocabulary;
    BULK INSERT cdm_synpuf.vocabulary 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\vocabulary.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\vocabulary.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.relationship') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.relationship;
    BULK INSERT cdm_synpuf.relationship 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\relationship.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\relationship.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.concept_class') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.concept_class;
    BULK INSERT cdm_synpuf.concept_class 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\concept_class.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\concept_class.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.domain') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.domain;
    BULK INSERT cdm_synpuf.domain 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\domain.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\domain.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.cdm_source') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.cdm_source;
    BULK INSERT cdm_synpuf.cdm_source 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\cdm_source.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\cdm_source.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.person') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.person;
    BULK INSERT cdm_synpuf.person 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\person.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\person.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.observation_period') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.observation_period;
    BULK INSERT cdm_synpuf.observation_period 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\observation_period.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\observation_period.bad',
    TABLOCK
    );
END
;
GO


IF(OBJECT_ID('cdm_synpuf.visit_occurrence') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.visit_occurrence;
    BULK INSERT cdm_synpuf.visit_occurrence 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\visit_occurrence.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\visit_occurrence.bad',
    TABLOCK
    );
END
;
GO


IF(OBJECT_ID('cdm_synpuf.procedure_occurrence') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.procedure_occurrence;
    BULK INSERT cdm_synpuf.procedure_occurrence 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\procedure_occurrence.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\procedure_occurrence.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.drug_exposure') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.drug_exposure;
    BULK INSERT cdm_synpuf.drug_exposure 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\drug_exposure.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\drug_exposure.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.device_exposure') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.device_exposure;
    BULK INSERT cdm_synpuf.device_exposure 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\device_exposure.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\device_exposure.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.condition_occurrence') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.condition_occurrence;
    BULK INSERT cdm_synpuf.condition_occurrence 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\condition_occurrence.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\condition_occurrence.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.measurement') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.measurement;
    BULK INSERT cdm_synpuf.measurement 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\measurement.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\measurement.bad',
    TABLOCK
    );
END
;
GO


IF(OBJECT_ID('cdm_synpuf.observation') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.observation;
    BULK INSERT cdm_synpuf.observation 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\observation.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\observation.bad',
    TABLOCK
    );
END
;
GO


IF(OBJECT_ID('cdm_synpuf.location') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.location;
    BULK INSERT cdm_synpuf.location 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\location.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\location.bad',
    TABLOCK
    );
END
;
GO


IF(OBJECT_ID('cdm_synpuf.care_site') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.care_site;
    BULK INSERT cdm_synpuf.care_site 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\care_site.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\care_site.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.provider') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.provider;
    BULK INSERT cdm_synpuf.provider 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\provider.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\provider.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.payer_plan_period') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.payer_plan_period;
    BULK INSERT cdm_synpuf.payer_plan_period 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\payer_plan_period.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\payer_plan_period.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.cost') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.cost;
    BULK INSERT cdm_synpuf.cost 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\cost.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\cost.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.drug_era') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.drug_era;
    BULK INSERT cdm_synpuf.drug_era 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\drug_era.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\drug_era.bad',
    TABLOCK
    );
END
;
GO


IF(OBJECT_ID('cdm_synpuf.condition_era') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.condition_era;
    BULK INSERT cdm_synpuf.condition_era 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\condition_era.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\condition_era.bad',
    TABLOCK
    );
END
;
GO

IF(OBJECT_ID('cdm_synpuf.concept_hierarchy') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.concept_hierarchy;
    BULK INSERT cdm_synpuf.concept_hierarchy 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\concept_hierarchy.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\concept_hierarchy.bad',
    TABLOCK
    );
  END
;
GO

IF(OBJECT_ID('cdm_synpuf.death') IS NOT NULL)
  BEGIN
    TRUNCATE TABLE cdm_synpuf.death;
    BULK INSERT cdm_synpuf.death 
    FROM 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\death.csv' 
    WITH (
    FIRSTROW = 1,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = 'C:\Users\dldenton\Downloads\synpuf5pct_20180710\errors\death.bad',
    TABLOCK
    );
  END
;
GO