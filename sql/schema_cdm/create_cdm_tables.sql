--Select database
USE @database@;
GO

/*CREATE STANDARDIZED METADATA TABLES*/
--Create cdm.cdm_source table
IF(OBJECT_ID('cdm.cdm_source') IS NULL)
  BEGIN
    CREATE TABLE cdm.cdm_source (
      cdm_source_name VARCHAR(255) NOT NULL
      ,cdm_source_abbreviation VARCHAR(25) NULL
      ,cdm_holder VARCHAR(255) NULL
      ,source_description VARCHAR(MAX) NULL
      ,source_documentation_reference VARCHAR(255) NULL
      ,cdm_etl_reference VARCHAR(255) NULL
      ,source_release_date DATE NULL
      ,cdm_release_date DATE NULL
      ,cdm_version VARCHAR(10) NULL
      ,vocabulary_version VARCHAR(20) NULL
    );
  END
;

GO

--Create cdm.metadata table
IF(OBJECT_ID('cdm.metadata') IS NULL)
  BEGIN
    CREATE TABLE cdm.metadata (
      metadata_concept_id INTEGER NOT NULL
      ,metadata_type_concept_id INTEGER NOT NULL
      ,name VARCHAR(250) NOT NULL
      ,value_as_string VARCHAR(MAX) NULL
      ,value_as_concept_id INTEGER NULL
      ,metadata_date DATE NULL
      ,metadata_datetime DATETIME2 NULL
    );
  END
;

GO

--Update cdm.metadata with CDM version
INSERT INTO cdm.metadata (metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, metadata_date, metadata_datetime) --Added cdm version record
VALUES (0, 0, 'CDM Version', '6.0', 0, NULL, NULL)
;

GO

/*CREATE STANDARDIZED CLINICAL DATA TABLES*/
--Create cdm.person table
IF(OBJECT_ID('cdm.person') IS NULL)
  BEGIN
    CREATE TABLE cdm.person (
      person_id BIGINT NOT NULL
      ,gender_concept_id INTEGER NOT NULL
      ,year_of_birth INTEGER NOT NULL
      ,month_of_birth INTEGER NULL
      ,day_of_birth INTEGER NULL
      ,birth_datetime DATETIME2 NULL
      ,death_datetime DATETIME2 NULL
      ,race_concept_id INTEGER NOT NULL
      ,ethnicity_concept_id INTEGER NOT NULL
      ,location_id BIGINT NULL
      ,provider_id BIGINT NULL
      ,care_site_id BIGINT NULL
      ,person_source_value VARCHAR(50) NULL
      ,gender_source_value VARCHAR(50) NULL
      ,gender_source_concept_id INTEGER NOT NULL
      ,race_source_value VARCHAR(50) NULL
      ,race_source_concept_id INTEGER NOT NULL
      ,ethnicity_source_value VARCHAR(50) NULL
      ,ethnicity_source_concept_id INTEGER NOT NULL
    );
  END
;

GO

--Create cdm.observation_period table
IF(OBJECT_ID('cdm.observation_period') IS NULL)
  BEGIN
    CREATE TABLE cdm.observation_period (
      observation_period_id BIGINT IDENTITY NOT NULL
      ,person_id BIGINT NOT NULL
      ,observation_period_start_date DATE NOT NULL
      ,observation_period_end_date DATE NOT NULL
      ,period_type_concept_id INTEGER NOT NULL
    );
  END
;

GO

--Create cdm.specimen table
IF(OBJECT_ID('cdm.specimen') IS NULL)
  BEGIN
    CREATE TABLE cdm.specimen (
      specimen_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,specimen_concept_id INTEGER NOT NULL
      ,specimen_type_concept_id INTEGER NOT NULL
      ,specimen_date DATE NULL
      ,specimen_datetime DATETIME2 NOT NULL
      ,quantity FLOAT NULL
      ,unit_concept_id INTEGER NULL
      ,anatomic_site_concept_id INTEGER NOT NULL
      ,disease_status_concept_id INTEGER NOT NULL
      ,specimen_source_id VARCHAR(50) NULL
      ,specimen_source_value VARCHAR(50) NULL
      ,unit_source_value VARCHAR(50) NULL
      ,anatomic_site_source_value VARCHAR(50) NULL
      ,disease_status_source_value VARCHAR(50) NULL
    );
  END
;

GO

--Create cdm.visit_occurrence table
DROP TABLE IF EXISTS cdm.visit_occurrence;
IF(OBJECT_ID('cdm.visit_occurrence') IS NULL)
  BEGIN
    CREATE TABLE cdm.visit_occurrence (
      visit_occurrence_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,visit_concept_id INTEGER NOT NULL
      ,visit_start_date DATE NULL
      ,visit_start_datetime DATETIME2 NOT NULL
      ,visit_end_date DATE NULL
      ,visit_end_datetime DATETIME2 NOT NULL
      ,visit_type_concept_id INTEGER NOT NULL
      ,provider_id BIGINT NULL
      ,care_site_id BIGINT NULL
      ,visit_source_value VARCHAR(50) NULL
      ,visit_source_concept_id INTEGER NOT NULL
      ,admitted_from_concept_id INTEGER NOT NULL
      ,admitted_from_source_value VARCHAR(50) NULL
      ,discharge_to_concept_id INTEGER NOT NULL
      ,discharge_to_source_value VARCHAR(50) NULL
      ,preceding_visit_occurrence_id BIGINT NULL
      ,organization_id BIGINT NULL
    );
  END
;

GO

--Create cdm.visit_detail table
IF(OBJECT_ID('cdm.visit_detail') IS NULL)
  BEGIN
    CREATE TABLE cdm.visit_detail (
      visit_detail_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,visit_detail_concept_id INTEGER NOT NULL
      ,visit_detail_start_date DATE NULL
      ,visit_detail_start_datetime DATETIME2 NOT NULL
      ,visit_detail_end_date DATE NULL
      ,visit_detail_end_datetime DATETIME2 NOT NULL
      ,visit_detail_type_concept_id INTEGER NOT NULL
      ,provider_id BIGINT NULL
      ,care_site_id BIGINT NULL
      ,visit_detail_source_value VARCHAR(50) NULL
      ,visit_detail_source_concept_id INTEGER NOT NULL
      ,admitted_from_source_value VARCHAR(50) NULL
      ,admitted_from_concept_id INTEGER NOT NULL
      ,discharge_to_source_value VARCHAR(50) NULL
      ,discharge_to_concept_id INTEGER NOT NULL
      ,preceding_visit_detail_id BIGINT NULL
      ,visit_detail_parent_id BIGINT NULL
      ,visit_occurrence_id BIGINT NOT NULL
      ,organization_id BIGINT NULL
    );
  END
;

GO

--Create cdm.procedure_occurrence table
IF(OBJECT_ID('cdm.procedure_occurrence') IS NULL)
  BEGIN
    CREATE TABLE cdm.procedure_occurrence (
      procedure_occurrence_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,procedure_concept_id INTEGER NOT NULL
      ,procedure_date DATE NULL
      ,procedure_datetime DATETIME2 NOT NULL
      ,procedure_type_concept_id INTEGER NOT NULL
      ,modifier_concept_id INTEGER NOT NULL
      ,quantity INTEGER NULL
      ,provider_id BIGINT NULL
      ,visit_occurrence_id BIGINT NULL
      ,visit_detail_id BIGINT NULL
      ,procedure_source_value VARCHAR(50) NULL
      ,procedure_source_concept_id INTEGER NOT NULL
      ,modifier_source_value VARCHAR(50) NULL
    );
  END
;

GO

--Create cdm.drug_exposure table
IF(OBJECT_ID('cdm.drug_exposure') IS NULL)
  BEGIN
    CREATE TABLE cdm.drug_exposure (
      drug_exposure_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,drug_concept_id INTEGER NOT NULL
      ,drug_exposure_start_date DATE NULL
      ,drug_exposure_start_datetime DATETIME2 NOT NULL
      ,drug_exposure_end_date DATE NULL
      ,drug_exposure_end_datetime DATETIME2 NOT NULL
      ,verbatim_end_date DATE NULL
      ,drug_type_concept_id INTEGER NOT NULL
      ,stop_reason VARCHAR(20) NULL
      ,refills INTEGER NULL
      ,quantity FLOAT NULL
      ,days_supply INTEGER NULL
      ,sig VARCHAR(MAX) NULL
      ,route_concept_id INTEGER NOT NULL
      ,lot_number VARCHAR(50) NULL
      ,provider_id BIGINT NULL
      ,visit_occurrence_id BIGINT NULL
      ,visit_detail_id BIGINT NULL
      ,drug_source_value VARCHAR(50) NULL
      ,drug_source_concept_id INTEGER NOT NULL
      ,route_source_value VARCHAR(50) NULL
      ,dose_unit_source_value VARCHAR(50) NULL
    );
  END
;

GO

--Create cdm.device_exposure table
IF(OBJECT_ID('cdm.device_exposure') IS NULL)
  BEGIN
    CREATE TABLE cdm.device_exposure (
     device_exposure_id BIGINT NOT NULL
     ,person_id BIGINT NOT NULL
     ,device_concept_id INTEGER NOT NULL
     ,device_exposure_start_date DATE NULL
     ,device_exposure_start_datetime DATETIME2 NOT NULL
     ,device_exposure_end_date DATE NULL
     ,device_exposure_end_datetime DATETIME2 NULL
     ,device_type_concept_id INTEGER NOT NULL
     ,unique_device_id VARCHAR(50) NULL
     ,quantity INTEGER NULL
     ,provider_id BIGINT NULL
     ,visit_occurrence_id BIGINT NULL
     ,visit_detail_id BIGINT NULL
     ,device_source_value VARCHAR(100) NULL
     ,device_source_concept_id INTEGER NOT NULL
    );
  END
;

GO

--Create cdm.condition_occurrence table
IF(OBJECT_ID('cdm.condition_occurrence') IS NULL)
  BEGIN
    CREATE TABLE cdm.condition_occurrence (
      condition_occurrence_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,condition_concept_id INTEGER NOT NULL
      ,condition_start_date DATE NULL
      ,condition_start_datetime DATETIME2 NOT NULL
      ,condition_end_date DATE NULL
      ,condition_end_datetime DATETIME2 NULL
      ,condition_type_concept_id INTEGER NOT NULL
      ,condition_status_concept_id INTEGER NOT NULL
      ,stop_reason VARCHAR(20) NULL
      ,provider_id BIGINT NULL
      ,visit_occurrence_id BIGINT NULL
      ,visit_detail_id BIGINT NULL
      ,condition_source_value VARCHAR(50) NULL
      ,condition_source_concept_id INTEGER NOT NULL
      ,condition_status_source_value VARCHAR(50) NULL
    );
  END
;

GO

--Create cdm.measurement table
IF(OBJECT_ID('cdm.measurement') IS NULL)
  BEGIN
    CREATE TABLE cdm.measurement (
      measurement_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,measurement_concept_id INTEGER NOT NULL
      ,measurement_date DATE NULL
      ,measurement_datetime DATETIME2 NOT NULL
      ,measurement_time VARCHAR(10) NULL
      ,measurement_type_concept_id INTEGER NOT NULL
      ,operator_concept_id INTEGER NULL
      ,value_as_number FLOAT NULL
      ,value_as_concept_id INTEGER NULL
      ,unit_concept_id INTEGER NULL
      ,range_low FLOAT NULL
      ,range_high FLOAT NULL
      ,provider_id BIGINT NULL
      ,visit_occurrence_id BIGINT NULL
      ,visit_detail_id BIGINT NULL
      ,measurement_source_value VARCHAR(50) NULL
      ,measurement_source_concept_id INTEGER NOT NULL
      ,unit_source_value VARCHAR(50) NULL
      ,value_source_value VARCHAR(50) NULL
    );
  END
;

GO

--Create cdm.note table
IF(OBJECT_ID('cdm.note') IS NULL)
  BEGIN
    CREATE TABLE cdm.note (
      note_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,note_event_id BIGINT NULL 
      ,note_event_field_concept_id INTEGER NOT NULL 
      ,note_date DATE NULL
      ,note_datetime DATETIME2 NOT NULL
      ,note_type_concept_id INTEGER NOT NULL
      ,note_class_concept_id INTEGER NOT NULL
      ,note_title VARCHAR(250) NULL
      ,note_text VARCHAR(MAX) NULL
      ,encoding_concept_id INTEGER NOT NULL
      ,language_concept_id INTEGER NOT NULL
      ,provider_id BIGINT NULL
      ,visit_occurrence_id BIGINT NULL
      ,visit_detail_id BIGINT NULL
      ,note_source_value VARCHAR(50) NULL
    );
  END
;

GO

--Create cdm.note_nlp table
IF(OBJECT_ID('cdm.note_nlp') IS NULL)
  BEGIN
    CREATE TABLE cdm.note_nlp (
      note_nlp_id BIGINT NOT NULL
      ,note_id BIGINT NOT NULL
      ,section_concept_id INTEGER NOT NULL
      ,snippet VARCHAR(250) NULL
      ,"offset" VARCHAR(250) NULL
      ,lexical_variant VARCHAR(250) NOT NULL
      ,note_nlp_concept_id INTEGER NOT NULL
      ,nlp_system VARCHAR(250) NULL
      ,nlp_date DATE NOT NULL
      ,nlp_datetime DATETIME2 NULL
      ,term_exists VARCHAR(1) NULL
      ,term_temporal VARCHAR(50) NULL
      ,term_modifiers VARCHAR(2000) NULL
      ,note_nlp_source_concept_id INTEGER NOT NULL
    );
  END
;

GO

--Create cdm.observation table
IF(OBJECT_ID('cdm.observation') IS NULL)
  BEGIN
    CREATE TABLE cdm.observation (
      observation_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,observation_concept_id INTEGER NOT NULL
      ,observation_date DATE NULL
      ,observation_datetime DATETIME2 NOT NULL
      ,observation_type_concept_id INTEGER NOT NULL
      ,value_as_number FLOAT NULL
      ,value_as_string VARCHAR(60) NULL
      ,value_as_concept_id INTEGER NULL
      ,qualifier_concept_id INTEGER NULL
      ,unit_concept_id INTEGER NULL
      ,provider_id INTEGER NULL
      ,visit_occurrence_id BIGINT NULL
      ,visit_detail_id BIGINT NULL
      ,observation_source_value VARCHAR(50) NULL
      ,observation_source_concept_id INTEGER NOT NULL
      ,unit_source_value VARCHAR(50) NULL
      ,qualifier_source_value VARCHAR(50) NULL
      ,observation_event_id BIGINT NULL 
      ,obs_event_field_concept_id INTEGER NOT NULL
      ,value_as_datetime DATETIME2 NULL
    );
  END
;

GO

--Create cdm.survey_conduct table
IF(OBJECT_ID('cdm.survey_conduct') IS NULL)
  BEGIN
    CREATE TABLE cdm.survey_conduct (
      survey_conduct_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,survey_concept_id INTEGER NOT NULL
      ,survey_start_date DATE NULL
      ,survey_start_datetime DATETIME2 NULL
      ,survey_end_date DATE NULL
      ,survey_end_datetime DATETIME2 NOT NULL
      ,provider_id BIGINT NULL
      ,assisted_concept_id INTEGER NOT NULL
      ,respondent_type_concept_id INTEGER NOT NULL
      ,timing_concept_id INTEGER NOT NULL
      ,collection_method_concept_id INTEGER NOT NULL
      ,assisted_source_value VARCHAR(50) NULL
      ,respondent_type_source_value VARCHAR(100) NULL
      ,timing_source_value VARCHAR(100) NULL
      ,collection_method_source_value VARCHAR(100) NULL
      ,survey_source_value VARCHAR(100) NULL
      ,survey_source_concept_id INTEGER NOT NULL
      ,survey_source_identifier VARCHAR(100) NULL
      ,validated_survey_concept_id INTEGER NOT NULL
      ,validated_survey_source_value VARCHAR(100) NULL
      ,survey_version_number VARCHAR(20) NULL
      ,visit_occurrence_id BIGINT NULL
      ,visit_detail_id BIGINT NULL
      ,response_visit_occurrence_id BIGINT NULL
    );
  END
;

GO

--Create cdm.fact_relationship table
IF(OBJECT_ID('cdm.fact_relationship') IS NULL)
  BEGIN
    CREATE TABLE cdm.fact_relationship (
      domain_concept_id_1 INTEGER NOT NULL
      ,fact_id_1 BIGINT NOT NULL
      ,domain_concept_id_2 INTEGER NOT NULL
      ,fact_id_2 BIGINT NOT NULL
      ,relationship_concept_id INTEGER NOT NULL
    );
  END
;

GO

/*CREATE STANDARDIZED HEALTH SYSTEM DATA TABLES*/
--Create cdm.location table
DROP TABLE IF EXISTS cdm.location;
IF(OBJECT_ID('cdm.location') IS NULL)
  BEGIN
    CREATE TABLE cdm.location (
      location_id BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY
      ,address_1 VARCHAR(50) NULL
      ,address_2 VARCHAR(50) NULL
      ,city VARCHAR(50) NULL
      ,state VARCHAR(2) NULL
      ,zip VARCHAR(9) NULL
      ,county VARCHAR(20) NULL
      ,country VARCHAR(100) NULL
      ,location_source_value VARCHAR(50) NULL
      ,latitude FLOAT NULL
      ,longitude FLOAT NULL
    );
  END
;

GO

--Create cdm.location_history table
IF(OBJECT_ID('cdm.location_history') IS NULL)
  BEGIN
    CREATE TABLE cdm.location_history (
      location_history_id BIGINT NOT NULL
      ,location_id BIGINT NOT NULL
      ,relationship_type_concept_id INTEGER NOT NULL
      ,domain_id VARCHAR(50) NOT NULL
      ,entity_id BIGINT NOT NULL
      ,start_date DATE NOT NULL
      ,end_date DATE NULL
    );
  END
;

GO

--Create cdm.care_site table
IF(OBJECT_ID('cdm.care_site') IS NULL)
  BEGIN
    CREATE TABLE cdm.care_site (
      care_site_id BIGINT NOT NULL
      ,care_site_name VARCHAR(255) NULL
      ,place_of_service_concept_id INTEGER NOT NULL
      ,location_id BIGINT NULL
      ,care_site_source_value VARCHAR(50) NULL
      ,place_of_service_source_value VARCHAR(50) NULL
    );
  END
;

GO

--Create cdm.provider table
IF(OBJECT_ID('cdm.provider') IS NULL)
  BEGIN
    CREATE TABLE cdm.provider (
      provider_id BIGINT NOT NULL
      ,provider_name VARCHAR(255) NULL
      ,npi VARCHAR(20) NULL
      ,dea VARCHAR(20) NULL
      ,specialty_concept_id INTEGER NOT NULL
      ,care_site_id BIGINT NULL
      ,year_of_birth INTEGER NULL
      ,gender_concept_id INTEGER NOT NULL
      ,provider_source_value VARCHAR(50) NULL
      ,specialty_source_value VARCHAR(50) NULL
      ,specialty_source_concept_id INTEGER NOT NULL
      ,gender_source_value VARCHAR(50) NULL
      ,gender_source_concept_id INTEGER NOT NULL
      ,organization_id BIGINT NULL
    );
  END
;

GO

/*CREATE STANDARDIZED HEALTH ECONOMICS TABLES*/
--Create cdm.payer_plan_period table
IF(OBJECT_ID('cdm.payer_plan_period') IS NULL)
  BEGIN
    CREATE TABLE cdm.payer_plan_period (
      payer_plan_period_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,contract_person_id BIGINT NULL
      ,payer_plan_period_start_date DATE NOT NULL
      ,payer_plan_period_end_date DATE NOT NULL
      ,payer_concept_id INTEGER NOT NULL
      ,plan_concept_id INTEGER NOT NULL
      ,contract_concept_id INTEGER NOT NULL
      ,sponsor_concept_id INTEGER NOT NULL
      ,stop_reason_concept_id INTEGER NOT NULL
      ,payer_source_value VARCHAR(50) NULL
      ,payer_source_concept_id INTEGER NOT NULL
      ,plan_source_value VARCHAR(50) NULL
      ,plan_source_concept_id INTEGER NOT NULL
      ,contract_source_value VARCHAR(50) NULL
      ,contract_source_concept_id INTEGER NOT NULL
      ,sponsor_source_value VARCHAR(50) NULL
      ,sponsor_source_concept_id INTEGER NOT NULL
      ,family_source_value VARCHAR(50) NULL
      ,stop_reason_source_value VARCHAR(50) NULL
      ,stop_reason_source_concept_id INTEGER NOT NULL
    );
  END
;

GO

--Create cdm.cost table
IF(OBJECT_ID('cdm.cost') IS NULL)
  BEGIN
    CREATE TABLE cdm.cost (
      cost_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,cost_event_id BIGINT NOT NULL
      ,cost_event_field_concept_id INTEGER NOT NULL 
      ,cost_concept_id INTEGER NOT NULL
      ,cost_type_concept_id INTEGER NOT NULL
      ,currency_concept_id INTEGER NOT NULL
      ,cost FLOAT NULL
      ,incurred_date DATE NOT NULL
      ,billed_date DATE NULL
      ,paid_date DATE NULL
      ,revenue_code_concept_id INTEGER NOT NULL
      ,drg_concept_id INTEGER NOT NULL
      ,cost_source_value VARCHAR(50) NULL
      ,cost_source_concept_id INTEGER NOT NULL
      ,revenue_code_source_value VARCHAR(50) NULL
      ,drg_source_value VARCHAR(3) NULL
      ,payer_plan_period_id BIGINT NULL
    );
  END
;

GO

/*CREATE STANDARDIZED DERIVED TABLES*/
--Create cdm.drug_era table
IF(OBJECT_ID('cdm.drug_era') IS NULL)
  BEGIN
    CREATE TABLE cdm.drug_era (
      drug_era_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,drug_concept_id INTEGER NOT NULL
      ,drug_era_start_datetime DATETIME2 NOT NULL
      ,drug_era_end_datetime DATETIME2 NOT NULL
      ,drug_exposure_count INTEGER NULL
      ,gap_days INTEGER NULL
    );
  END
;

GO

--Create cdm.dose_era table
IF(OBJECT_ID('cdm.dose_era') IS NULL)
  BEGIN
    CREATE TABLE cdm.dose_era (
      dose_era_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,drug_concept_id INTEGER NOT NULL
      ,unit_concept_id INTEGER NOT NULL
      ,dose_value FLOAT NOT NULL
      ,dose_era_start_datetime DATETIME2 NOT NULL
      ,dose_era_end_datetime DATETIME2 NOT NULL
    );
  END
;

GO

--Create cdm.condition_era table
IF(OBJECT_ID('cdm.condition_era') IS NULL)
  BEGIN
    CREATE TABLE cdm.condition_era (
      condition_era_id BIGINT NOT NULL
      ,person_id BIGINT NOT NULL
      ,condition_concept_id INTEGER NOT NULL
      ,condition_era_start_datetime DATETIME2 NOT NULL
      ,condition_era_end_datetime DATETIME2 NOT NULL
      ,condition_occurrence_count INTEGER NULL
    );
  END
;