/************************

Constraints

************************/



ALTER TABLE cdm_synpuf.concept ADD CONSTRAINT xpk_concept PRIMARY KEY NONCLUSTERED (concept_id);

ALTER TABLE cdm_synpuf.vocabulary ADD CONSTRAINT xpk_vocabulary PRIMARY KEY NONCLUSTERED (vocabulary_id);

ALTER TABLE cdm_synpuf.domain ADD CONSTRAINT xpk_domain PRIMARY KEY NONCLUSTERED (domain_id);

ALTER TABLE cdm_synpuf.concept_class ADD CONSTRAINT xpk_concept_class PRIMARY KEY NONCLUSTERED (concept_class_id);

ALTER TABLE cdm_synpuf.concept_relationship ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY NONCLUSTERED (concept_id_1,concept_id_2,relationship_id);

ALTER TABLE cdm_synpuf.relationship ADD CONSTRAINT xpk_relationship PRIMARY KEY NONCLUSTERED (relationship_id);

ALTER TABLE cdm_synpuf.concept_ancestor ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY NONCLUSTERED (ancestor_concept_id,descendant_concept_id);

ALTER TABLE cdm_synpuf.source_to_concept_map ADD CONSTRAINT xpk_source_to_concept_map PRIMARY KEY NONCLUSTERED (source_vocabulary_id,target_concept_id,source_code,valid_end_date);

ALTER TABLE cdm_synpuf.drug_strength ADD CONSTRAINT xpk_drug_strength PRIMARY KEY NONCLUSTERED (drug_concept_id, ingredient_concept_id);

ALTER TABLE cdm_synpuf.cohort_definition ADD CONSTRAINT xpk_cohort_definition PRIMARY KEY NONCLUSTERED (cohort_definition_id);

ALTER TABLE cdm_synpuf.attribute_definition ADD CONSTRAINT xpk_attribute_definition PRIMARY KEY NONCLUSTERED (attribute_definition_id);


/**************************
Standardized meta-data
***************************/

/************************
Standardized clinical data
************************/


/**PRIMARY KEY NONCLUSTERED constraints**/

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT xpk_person PRIMARY KEY NONCLUSTERED ( person_id ) ;

ALTER TABLE cdm_synpuf.observation_period ADD CONSTRAINT xpk_observation_period PRIMARY KEY NONCLUSTERED ( observation_period_id ) ;

ALTER TABLE cdm_synpuf.specimen ADD CONSTRAINT xpk_specimen PRIMARY KEY NONCLUSTERED ( specimen_id ) ;

ALTER TABLE cdm_synpuf.death ADD CONSTRAINT xpk_death PRIMARY KEY NONCLUSTERED ( person_id ) ;

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT xpk_visit_occurrence PRIMARY KEY NONCLUSTERED ( visit_occurrence_id ) ;

ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT xpk_procedure_occurrence PRIMARY KEY NONCLUSTERED ( procedure_occurrence_id ) ;

ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT xpk_drug_exposure PRIMARY KEY NONCLUSTERED ( drug_exposure_id ) ;

ALTER TABLE cdm_synpuf.device_exposure ADD CONSTRAINT xpk_device_exposure PRIMARY KEY NONCLUSTERED ( device_exposure_id ) ;

ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT xpk_condition_occurrence PRIMARY KEY NONCLUSTERED ( condition_occurrence_id ) ;

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT xpk_measurement PRIMARY KEY NONCLUSTERED ( measurement_id ) ;

ALTER TABLE cdm_synpuf.observation  ADD CONSTRAINT xpk_observation PRIMARY KEY NONCLUSTERED ( observation_id ) ;




/************************
Standardized health system data
************************/


ALTER TABLE cdm_synpuf.location ADD CONSTRAINT xpk_location PRIMARY KEY NONCLUSTERED ( location_id ) ;

ALTER TABLE cdm_synpuf.care_site ADD CONSTRAINT xpk_care_site PRIMARY KEY NONCLUSTERED ( care_site_id ) ;

ALTER TABLE cdm_synpuf.provider ADD CONSTRAINT xpk_provider PRIMARY KEY NONCLUSTERED ( provider_id ) ;



/************************
Standardized health economics
************************/


ALTER TABLE cdm_synpuf.payer_plan_period ADD CONSTRAINT xpk_payer_plan_period PRIMARY KEY NONCLUSTERED ( payer_plan_period_id ) ;

ALTER TABLE cdm_synpuf.cost ADD CONSTRAINT xpk_visit_cost PRIMARY KEY NONCLUSTERED ( cost_id ) ;


/************************
Standardized derived elements
************************/

ALTER TABLE cdm_synpuf.cohort ADD CONSTRAINT xpk_cohort PRIMARY KEY NONCLUSTERED ( cohort_definition_id, subject_id, cohort_start_date, cohort_end_date  ) ;

ALTER TABLE cdm_synpuf.cohort_attribute ADD CONSTRAINT xpk_cohort_attribute PRIMARY KEY NONCLUSTERED ( cohort_definition_id, subject_id, cohort_start_date, cohort_end_date, attribute_definition_id ) ;

ALTER TABLE cdm_synpuf.drug_era ADD CONSTRAINT xpk_drug_era PRIMARY KEY NONCLUSTERED ( drug_era_id ) ;

ALTER TABLE cdm_synpuf.dose_era  ADD CONSTRAINT xpk_dose_era PRIMARY KEY NONCLUSTERED ( dose_era_id ) ;

ALTER TABLE cdm_synpuf.condition_era ADD CONSTRAINT xpk_condition_era PRIMARY KEY NONCLUSTERED ( condition_era_id ) ;


/************************
Standardized vocabulary
************************/


ALTER TABLE cdm_synpuf.concept ADD CONSTRAINT fpk_concept_domain FOREIGN KEY (domain_id)  REFERENCES cdm_synpuf.domain (domain_id);

ALTER TABLE cdm_synpuf.concept ADD CONSTRAINT fpk_concept_class FOREIGN KEY (concept_class_id)  REFERENCES cdm_synpuf.concept_class (concept_class_id);

ALTER TABLE cdm_synpuf.concept ADD CONSTRAINT fpk_concept_vocabulary FOREIGN KEY (vocabulary_id)  REFERENCES cdm_synpuf.vocabulary (vocabulary_id);

ALTER TABLE cdm_synpuf.vocabulary ADD CONSTRAINT fpk_vocabulary_concept FOREIGN KEY (vocabulary_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.domain ADD CONSTRAINT fpk_domain_concept FOREIGN KEY (domain_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.concept_class ADD CONSTRAINT fpk_concept_class_concept FOREIGN KEY (concept_class_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_1 FOREIGN KEY (concept_id_1)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_2 FOREIGN KEY (concept_id_2)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.concept_relationship ADD CONSTRAINT fpk_concept_relationship_id FOREIGN KEY (relationship_id)  REFERENCES cdm_synpuf.relationship (relationship_id);

ALTER TABLE cdm_synpuf.relationship ADD CONSTRAINT fpk_relationship_concept FOREIGN KEY (relationship_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.relationship ADD CONSTRAINT fpk_relationship_reverse FOREIGN KEY (reverse_relationship_id)  REFERENCES cdm_synpuf.relationship (relationship_id);

ALTER TABLE cdm_synpuf.concept_synonym ADD CONSTRAINT fpk_concept_synonym_concept FOREIGN KEY (concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_1 FOREIGN KEY (ancestor_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_2 FOREIGN KEY (descendant_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_1 FOREIGN KEY (source_vocabulary_id)  REFERENCES cdm_synpuf.vocabulary (vocabulary_id);

ALTER TABLE cdm_synpuf.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_2 FOREIGN KEY (target_vocabulary_id)  REFERENCES cdm_synpuf.vocabulary (vocabulary_id);

ALTER TABLE cdm_synpuf.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_c_1 FOREIGN KEY (target_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_strength ADD CONSTRAINT fpk_drug_strength_concept_1 FOREIGN KEY (drug_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_strength ADD CONSTRAINT fpk_drug_strength_concept_2 FOREIGN KEY (ingredient_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_1 FOREIGN KEY (amount_unit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_2 FOREIGN KEY (numerator_unit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_3 FOREIGN KEY (denominator_unit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.cohort_definition ADD CONSTRAINT fpk_cohort_definition_concept FOREIGN KEY (definition_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


/**************************
Standardized meta-data
***************************/

/************************
Standardized clinical data
************************/

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_gender_concept FOREIGN KEY (gender_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_race_concept FOREIGN KEY (race_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_ethnicity_concept FOREIGN KEY (ethnicity_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_gender_concept_s FOREIGN KEY (gender_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_race_concept_s FOREIGN KEY (race_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_ethnicity_concept_s FOREIGN KEY (ethnicity_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_location FOREIGN KEY (location_id)  REFERENCES cdm_synpuf.location (location_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.person ADD CONSTRAINT fpk_person_care_site FOREIGN KEY (care_site_id)  REFERENCES cdm_synpuf.care_site (care_site_id);


ALTER TABLE cdm_synpuf.observation_period ADD CONSTRAINT fpk_observation_period_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.observation_period ADD CONSTRAINT fpk_observation_period_concept FOREIGN KEY (period_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.specimen ADD CONSTRAINT fpk_specimen_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.specimen ADD CONSTRAINT fpk_specimen_concept FOREIGN KEY (specimen_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.specimen ADD CONSTRAINT fpk_specimen_type_concept FOREIGN KEY (specimen_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.specimen ADD CONSTRAINT fpk_specimen_unit_concept FOREIGN KEY (unit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.specimen ADD CONSTRAINT fpk_specimen_site_concept FOREIGN KEY (anatomic_site_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.specimen ADD CONSTRAINT fpk_specimen_status_concept FOREIGN KEY (disease_status_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.death ADD CONSTRAINT fpk_death_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.death ADD CONSTRAINT fpk_death_type_concept FOREIGN KEY (death_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.death ADD CONSTRAINT fpk_death_cause_concept FOREIGN KEY (cause_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.death ADD CONSTRAINT fpk_death_cause_concept_s FOREIGN KEY (cause_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_concept FOREIGN KEY (visit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_type_concept FOREIGN KEY (visit_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_care_site FOREIGN KEY (care_site_id)  REFERENCES cdm_synpuf.care_site (care_site_id);

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_concept_s FOREIGN KEY (visit_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_admitting_s FOREIGN KEY (admitting_source_concept_id) REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.visit_occurrence ADD CONSTRAINT fpk_visit_discharge FOREIGN KEY (discharge_to_concept_id) REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT fpk_procedure_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT fpk_procedure_concept FOREIGN KEY (procedure_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT fpk_procedure_type_concept FOREIGN KEY (procedure_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT fpk_procedure_modifier FOREIGN KEY (modifier_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT fpk_procedure_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT fpk_procedure_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES cdm_synpuf.visit_occurrence (visit_occurrence_id);

ALTER TABLE cdm_synpuf.procedure_occurrence ADD CONSTRAINT fpk_procedure_concept_s FOREIGN KEY (procedure_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT fpk_drug_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT fpk_drug_concept FOREIGN KEY (drug_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT fpk_drug_type_concept FOREIGN KEY (drug_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT fpk_drug_route_concept FOREIGN KEY (route_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT fpk_drug_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT fpk_drug_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES cdm_synpuf.visit_occurrence (visit_occurrence_id);

ALTER TABLE cdm_synpuf.drug_exposure ADD CONSTRAINT fpk_drug_concept_s FOREIGN KEY (drug_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.device_exposure ADD CONSTRAINT fpk_device_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.device_exposure ADD CONSTRAINT fpk_device_concept FOREIGN KEY (device_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.device_exposure ADD CONSTRAINT fpk_device_type_concept FOREIGN KEY (device_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.device_exposure ADD CONSTRAINT fpk_device_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.device_exposure ADD CONSTRAINT fpk_device_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES cdm_synpuf.visit_occurrence (visit_occurrence_id);

ALTER TABLE cdm_synpuf.device_exposure ADD CONSTRAINT fpk_device_concept_s FOREIGN KEY (device_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT fpk_condition_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT fpk_condition_concept FOREIGN KEY (condition_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT fpk_condition_type_concept FOREIGN KEY (condition_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT fpk_condition_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT fpk_condition_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES cdm_synpuf.visit_occurrence (visit_occurrence_id);

ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT fpk_condition_concept_s FOREIGN KEY (condition_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.condition_occurrence ADD CONSTRAINT fpk_condition_status_concept FOREIGN KEY (condition_status_concept_id) REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_concept FOREIGN KEY (measurement_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_type_concept FOREIGN KEY (measurement_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_operator FOREIGN KEY (operator_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_value FOREIGN KEY (value_as_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_unit FOREIGN KEY (unit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES cdm_synpuf.visit_occurrence (visit_occurrence_id);

ALTER TABLE cdm_synpuf.measurement ADD CONSTRAINT fpk_measurement_concept_s FOREIGN KEY (measurement_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_concept FOREIGN KEY (observation_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_type_concept FOREIGN KEY (observation_type_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_value FOREIGN KEY (value_as_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_qualifier FOREIGN KEY (qualifier_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_unit FOREIGN KEY (unit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_provider FOREIGN KEY (provider_id)  REFERENCES cdm_synpuf.provider (provider_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_visit FOREIGN KEY (visit_occurrence_id)  REFERENCES cdm_synpuf.visit_occurrence (visit_occurrence_id);

ALTER TABLE cdm_synpuf.observation ADD CONSTRAINT fpk_observation_concept_s FOREIGN KEY (observation_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.fact_relationship ADD CONSTRAINT fpk_fact_domain_1 FOREIGN KEY (domain_concept_id_1)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.fact_relationship ADD CONSTRAINT fpk_fact_domain_2 FOREIGN KEY (domain_concept_id_2)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.fact_relationship ADD CONSTRAINT fpk_fact_relationship FOREIGN KEY (relationship_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);



/************************
Standardized health system data
************************/

ALTER TABLE cdm_synpuf.care_site ADD CONSTRAINT fpk_care_site_location FOREIGN KEY (location_id)  REFERENCES cdm_synpuf.location (location_id);

ALTER TABLE cdm_synpuf.care_site ADD CONSTRAINT fpk_care_site_place FOREIGN KEY (place_of_service_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.provider ADD CONSTRAINT fpk_provider_specialty FOREIGN KEY (specialty_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.provider ADD CONSTRAINT fpk_provider_care_site FOREIGN KEY (care_site_id)  REFERENCES cdm_synpuf.care_site (care_site_id);

ALTER TABLE cdm_synpuf.provider ADD CONSTRAINT fpk_provider_gender FOREIGN KEY (gender_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.provider ADD CONSTRAINT fpk_provider_specialty_s FOREIGN KEY (specialty_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.provider ADD CONSTRAINT fpk_provider_gender_s FOREIGN KEY (gender_source_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);




/************************
Standardized health economics
************************/

ALTER TABLE cdm_synpuf.payer_plan_period ADD CONSTRAINT fpk_payer_plan_period FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.cost ADD CONSTRAINT fpk_visit_cost_currency FOREIGN KEY (currency_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.cost ADD CONSTRAINT fpk_visit_cost_period FOREIGN KEY (payer_plan_period_id)  REFERENCES cdm_synpuf.payer_plan_period (payer_plan_period_id);

ALTER TABLE cdm_synpuf.cost ADD CONSTRAINT fpk_drg_concept FOREIGN KEY (drg_concept_id) REFERENCES cdm_synpuf.concept (concept_id);

/************************
Standardized derived elements
************************/


ALTER TABLE cdm_synpuf.cohort ADD CONSTRAINT fpk_cohort_definition FOREIGN KEY (cohort_definition_id)  REFERENCES cdm_synpuf.cohort_definition (cohort_definition_id);


ALTER TABLE cdm_synpuf.cohort_attribute ADD CONSTRAINT fpk_ca_cohort_definition FOREIGN KEY (cohort_definition_id)  REFERENCES cdm_synpuf.cohort_definition (cohort_definition_id);

ALTER TABLE cdm_synpuf.cohort_attribute ADD CONSTRAINT fpk_ca_attribute_definition FOREIGN KEY (attribute_definition_id)  REFERENCES cdm_synpuf.attribute_definition (attribute_definition_id);

ALTER TABLE cdm_synpuf.cohort_attribute ADD CONSTRAINT fpk_ca_value FOREIGN KEY (value_as_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.drug_era ADD CONSTRAINT fpk_drug_era_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.drug_era ADD CONSTRAINT fpk_drug_era_concept FOREIGN KEY (drug_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.dose_era ADD CONSTRAINT fpk_dose_era_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.dose_era ADD CONSTRAINT fpk_dose_era_concept FOREIGN KEY (drug_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);

ALTER TABLE cdm_synpuf.dose_era ADD CONSTRAINT fpk_dose_era_unit_concept FOREIGN KEY (unit_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);


ALTER TABLE cdm_synpuf.condition_era ADD CONSTRAINT fpk_condition_era_person FOREIGN KEY (person_id)  REFERENCES cdm_synpuf.person (person_id);

ALTER TABLE cdm_synpuf.condition_era ADD CONSTRAINT fpk_condition_era_concept FOREIGN KEY (condition_concept_id)  REFERENCES cdm_synpuf.concept (concept_id);