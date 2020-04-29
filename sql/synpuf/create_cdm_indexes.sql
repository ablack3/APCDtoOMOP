/************************
Standardized vocabulary
************************/

CREATE UNIQUE CLUSTERED INDEX idx_concept_concept_id ON cdm_synpuf.concept (concept_id ASC);
CREATE INDEX idx_concept_code ON cdm_synpuf.concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON cdm_synpuf.concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON cdm_synpuf.concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON cdm_synpuf.concept (concept_class_id ASC);

CREATE UNIQUE CLUSTERED INDEX idx_vocabulary_vocabulary_id ON cdm_synpuf.vocabulary (vocabulary_id ASC);

CREATE UNIQUE CLUSTERED INDEX idx_domain_domain_id ON cdm_synpuf.domain (domain_id ASC);

CREATE UNIQUE CLUSTERED INDEX idx_concept_class_class_id ON cdm_synpuf.concept_class (concept_class_id ASC);

CREATE INDEX idx_concept_relationship_id_1 ON cdm_synpuf.concept_relationship (concept_id_1 ASC); 
CREATE INDEX idx_concept_relationship_id_2 ON cdm_synpuf.concept_relationship (concept_id_2 ASC); 
CREATE INDEX idx_concept_relationship_id_3 ON cdm_synpuf.concept_relationship (relationship_id ASC); 

CREATE UNIQUE CLUSTERED INDEX idx_relationship_rel_id ON cdm_synpuf.relationship (relationship_id ASC);

CREATE CLUSTERED INDEX idx_concept_synonym_id ON cdm_synpuf.concept_synonym (concept_id ASC);

CREATE CLUSTERED INDEX idx_concept_ancestor_id_1 ON cdm_synpuf.concept_ancestor (ancestor_concept_id ASC);
CREATE INDEX idx_concept_ancestor_id_2 ON cdm_synpuf.concept_ancestor (descendant_concept_id ASC);

CREATE CLUSTERED INDEX idx_source_to_concept_map_id_3 ON cdm_synpuf.source_to_concept_map (target_concept_id ASC);
CREATE INDEX idx_source_to_concept_map_id_1 ON cdm_synpuf.source_to_concept_map (source_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_id_2 ON cdm_synpuf.source_to_concept_map (target_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_code ON cdm_synpuf.source_to_concept_map (source_code ASC);

CREATE CLUSTERED INDEX idx_drug_strength_id_1 ON cdm_synpuf.drug_strength (drug_concept_id ASC);
CREATE INDEX idx_drug_strength_id_2 ON cdm_synpuf.drug_strength (ingredient_concept_id ASC);

CREATE CLUSTERED INDEX idx_cohort_definition_id ON cdm_synpuf.cohort_definition (cohort_definition_id ASC);

CREATE CLUSTERED INDEX idx_attribute_definition_id ON cdm_synpuf.attribute_definition (attribute_definition_id ASC);


/**************************
Standardized meta-data
***************************/





/************************
Standardized clinical data
************************/

CREATE UNIQUE CLUSTERED INDEX idx_person_id ON cdm_synpuf.person (person_id ASC);

CREATE CLUSTERED INDEX idx_observation_period_id ON cdm_synpuf.observation_period (person_id ASC);

CREATE CLUSTERED INDEX idx_specimen_person_id ON cdm_synpuf.specimen (person_id ASC);
CREATE INDEX idx_specimen_concept_id ON cdm_synpuf.specimen (specimen_concept_id ASC);

CREATE CLUSTERED INDEX idx_death_person_id ON cdm_synpuf.death (person_id ASC);

CREATE CLUSTERED INDEX idx_visit_person_id ON cdm_synpuf.visit_occurrence (person_id ASC);
CREATE INDEX idx_visit_concept_id ON cdm_synpuf.visit_occurrence (visit_concept_id ASC);

CREATE CLUSTERED INDEX idx_procedure_person_id ON cdm_synpuf.procedure_occurrence (person_id ASC);
CREATE INDEX idx_procedure_concept_id ON cdm_synpuf.procedure_occurrence (procedure_concept_id ASC);
CREATE INDEX idx_procedure_visit_id ON cdm_synpuf.procedure_occurrence (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_drug_person_id ON cdm_synpuf.drug_exposure (person_id ASC);
CREATE INDEX idx_drug_concept_id ON cdm_synpuf.drug_exposure (drug_concept_id ASC);
CREATE INDEX idx_drug_visit_id ON cdm_synpuf.drug_exposure (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_device_person_id ON cdm_synpuf.device_exposure (person_id ASC);
CREATE INDEX idx_device_concept_id ON cdm_synpuf.device_exposure (device_concept_id ASC);
CREATE INDEX idx_device_visit_id ON cdm_synpuf.device_exposure (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_condition_person_id ON cdm_synpuf.condition_occurrence (person_id ASC);
CREATE INDEX idx_condition_concept_id ON cdm_synpuf.condition_occurrence (condition_concept_id ASC);
CREATE INDEX idx_condition_visit_id ON cdm_synpuf.condition_occurrence (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_measurement_person_id ON cdm_synpuf.measurement (person_id ASC);
CREATE INDEX idx_measurement_concept_id ON cdm_synpuf.measurement (measurement_concept_id ASC);
CREATE INDEX idx_measurement_visit_id ON cdm_synpuf.measurement (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_observation_person_id ON cdm_synpuf.observation (person_id ASC);
CREATE INDEX idx_observation_concept_id ON cdm_synpuf.observation (observation_concept_id ASC);
CREATE INDEX idx_observation_visit_id ON cdm_synpuf.observation (visit_occurrence_id ASC);

CREATE INDEX idx_fact_relationship_id_1 ON cdm_synpuf.fact_relationship (domain_concept_id_1 ASC);
CREATE INDEX idx_fact_relationship_id_2 ON cdm_synpuf.fact_relationship (domain_concept_id_2 ASC);
CREATE INDEX idx_fact_relationship_id_3 ON cdm_synpuf.fact_relationship (relationship_concept_id ASC);



/************************
Standardized health system data
************************/

/************************
Standardized health economics
************************/

CREATE CLUSTERED INDEX idx_period_person_id ON cdm_synpuf.payer_plan_period (person_id ASC);

/************************
Standardized derived elements
************************/


CREATE INDEX idx_cohort_subject_id ON cdm_synpuf.cohort (subject_id ASC);
CREATE INDEX idx_cohort_c_definition_id ON cdm_synpuf.cohort (cohort_definition_id ASC);

CREATE INDEX idx_ca_subject_id ON cdm_synpuf.cohort_attribute (subject_id ASC);
CREATE INDEX idx_ca_definition_id ON cdm_synpuf.cohort_attribute (cohort_definition_id ASC);

CREATE CLUSTERED INDEX idx_drug_era_person_id ON cdm_synpuf.drug_era (person_id ASC);
CREATE INDEX idx_drug_era_concept_id ON cdm_synpuf.drug_era (drug_concept_id ASC);

CREATE CLUSTERED INDEX idx_dose_era_person_id ON cdm_synpuf.dose_era (person_id ASC);
CREATE INDEX idx_dose_era_concept_id ON cdm_synpuf.dose_era (drug_concept_id ASC);

CREATE CLUSTERED INDEX idx_condition_era_person_id ON cdm_synpuf.condition_era (person_id ASC);
CREATE INDEX idx_condition_era_concept_id ON cdm_synpuf.condition_era (condition_concept_id ASC);