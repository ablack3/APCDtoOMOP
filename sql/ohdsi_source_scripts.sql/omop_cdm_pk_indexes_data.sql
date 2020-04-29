/*********************************************************************************
# Copyright 2014 Observational Health Data Sciences and Informatics
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
********************************************************************************/

/************************

 ####### #     # ####### ######      #####  ######  #     #            #####        ###      ######  #    #      ##       ###
 #     # ##   ## #     # #     #    #     # #     # ##   ##    #    # #     #      #   #     #     # #   #      #  #       #  #    # #####  #  ####  ######  ####
 #     # # # # # #     # #     #    #       #     # # # # #    #    # #           #     #    #     # #  #        ##        #  ##   # #    # # #    # #      #
 #     # #  #  # #     # ######     #       #     # #  #  #    #    # ######      #     #    ######  ###        ###        #  # #  # #    # # #      #####   ####
 #     # #     # #     # #          #       #     # #     #    #    # #     # ### #     #    #       #  #      #   # #     #  #  # # #    # # #      #           #
 #     # #     # #     # #          #     # #     # #     #     #  #  #     # ###  #   #     #       #   #     #    #      #  #   ## #    # # #    # #      #    #
 ####### #     # ####### #           #####  ######  #     #      ##    #####  ###   ###      #       #    #     ###  #    ### #    # #####  #  ####  ######  ####


sql server script to create the required primary keys and indices within the OMOP common data model, version 6.0

last revised: 30-Aug-2017

author:  Patrick Ryan, Clair Blacketer

description:  These primary keys and indices are considered a minimal requirement to ensure adequate performance of analyses.

*************************/


/************************
*************************
*************************
*************************

Primary key constraints

*************************
*************************
*************************
************************/

USE APCD;
GO


/**************************

Standardized meta-data

***************************/



/************************

Standardized clinical data

************************/


/**PRIMARY KEY NONCLUSTERED constraints**/

ALTER TABLE cdm.person ADD CONSTRAINT xpk_person PRIMARY KEY NONCLUSTERED ( person_id ) ;

ALTER TABLE cdm.observation_period ADD CONSTRAINT xpk_observation_period PRIMARY KEY NONCLUSTERED ( observation_period_id ) ;

ALTER TABLE cdm.specimen ADD CONSTRAINT xpk_specimen PRIMARY KEY NONCLUSTERED ( specimen_id ) ;

ALTER TABLE cdm.death ADD CONSTRAINT xpk_death PRIMARY KEY NONCLUSTERED ( person_id ) ;

ALTER TABLE cdm.visit_occurrence ADD CONSTRAINT xpk_visit_occurrence PRIMARY KEY NONCLUSTERED ( visit_occurrence_id ) ;

ALTER TABLE cdm.visit_detail ADD CONSTRAINT xpk_visit_detail PRIMARY KEY NONCLUSTERED ( visit_detail_id ) ;

ALTER TABLE cdm.procedure_occurrence ADD CONSTRAINT xpk_procedure_occurrence PRIMARY KEY NONCLUSTERED ( procedure_occurrence_id ) ;

ALTER TABLE cdm.drug_exposure ADD CONSTRAINT xpk_drug_exposure PRIMARY KEY NONCLUSTERED ( drug_exposure_id ) ;

ALTER TABLE cdm.device_exposure ADD CONSTRAINT xpk_device_exposure PRIMARY KEY NONCLUSTERED ( device_exposure_id ) ;

ALTER TABLE cdm.condition_occurrence ADD CONSTRAINT xpk_condition_occurrence PRIMARY KEY NONCLUSTERED ( condition_occurrence_id ) ;

ALTER TABLE cdm.measurement ADD CONSTRAINT xpk_measurement PRIMARY KEY NONCLUSTERED ( measurement_id ) ;

ALTER TABLE cdm.note ADD CONSTRAINT xpk_note PRIMARY KEY NONCLUSTERED ( note_id ) ;

ALTER TABLE cdm.note_nlp ADD CONSTRAINT xpk_note_nlp PRIMARY KEY NONCLUSTERED ( note_nlp_id ) ;

ALTER TABLE cdm.observation  ADD CONSTRAINT xpk_observation PRIMARY KEY NONCLUSTERED ( observation_id ) ;

ALTER TABLE cdm.survey_conduct ADD CONSTRAINT xpk_survey PRIMARY KEY NONCLUSTERED ( survey_conduct_id ) ;


/************************

Standardized health system data

************************/


ALTER TABLE cdm.location ADD CONSTRAINT xpk_location PRIMARY KEY NONCLUSTERED ( location_id ) ;

ALTER TABLE cdm.location_history ADD CONSTRAINT xpk_location_history PRIMARY KEY NONCLUSTERED ( location_history_id ) ; 

ALTER TABLE cdm.care_site ADD CONSTRAINT xpk_care_site PRIMARY KEY NONCLUSTERED ( care_site_id ) ;

ALTER TABLE cdm.provider ADD CONSTRAINT xpk_provider PRIMARY KEY NONCLUSTERED ( provider_id ) ;



/************************

Standardized health economics

************************/


ALTER TABLE cdm.payer_plan_period ADD CONSTRAINT xpk_payer_plan_period PRIMARY KEY NONCLUSTERED ( payer_plan_period_id ) ;

ALTER TABLE cdm.cost ADD CONSTRAINT xpk_visit_cost PRIMARY KEY NONCLUSTERED ( cost_id ) ;


/************************

Standardized derived elements

************************/

ALTER TABLE cdm.drug_era ADD CONSTRAINT xpk_drug_era PRIMARY KEY NONCLUSTERED ( drug_era_id ) ;

ALTER TABLE cdm.dose_era  ADD CONSTRAINT xpk_dose_era PRIMARY KEY NONCLUSTERED ( dose_era_id ) ;

ALTER TABLE cdm.condition_era ADD CONSTRAINT xpk_condition_era PRIMARY KEY NONCLUSTERED ( condition_era_id ) ;


/************************
*************************
*************************
*************************

Indices

*************************
*************************
*************************
************************/



/**************************

Standardized meta-data

***************************/





/************************

Standardized clinical data

************************/

CREATE UNIQUE CLUSTERED INDEX idx_person_id ON cdm.person (person_id ASC);

CREATE CLUSTERED INDEX idx_observation_period_id ON cdm.observation_period (person_id ASC);

CREATE CLUSTERED INDEX idx_specimen_person_id ON cdm.specimen (person_id ASC);
CREATE INDEX idx_specimen_concept_id ON cdm.specimen (specimen_concept_id ASC);

CREATE CLUSTERED INDEX idx_death_person_id ON cdm.death (person_id ASC);

CREATE CLUSTERED INDEX idx_visit_person_id ON cdm.visit_occurrence (person_id ASC);
CREATE INDEX idx_visit_concept_id ON cdm.visit_occurrence (visit_concept_id ASC);

CREATE CLUSTERED INDEX idx_visit_detail_person_id ON cdm.visit_detail (person_id ASC);
CREATE INDEX idx_visit_detail_concept_id ON cdm.visit_detail (visit_detail_concept_id ASC);

CREATE CLUSTERED INDEX idx_procedure_person_id ON cdm.procedure_occurrence (person_id ASC);
CREATE INDEX idx_procedure_concept_id ON cdm.procedure_occurrence (procedure_concept_id ASC);
CREATE INDEX idx_procedure_visit_id ON cdm.procedure_occurrence (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_drug_person_id ON cdm.drug_exposure (person_id ASC);
CREATE INDEX idx_drug_concept_id ON cdm.drug_exposure (drug_concept_id ASC);
CREATE INDEX idx_drug_visit_id ON cdm.drug_exposure (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_device_person_id ON cdm.device_exposure (person_id ASC);
CREATE INDEX idx_device_concept_id ON cdm.device_exposure (device_concept_id ASC);
CREATE INDEX idx_device_visit_id ON cdm.device_exposure (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_condition_person_id ON cdm.condition_occurrence (person_id ASC);
CREATE INDEX idx_condition_concept_id ON cdm.condition_occurrence (condition_concept_id ASC);
CREATE INDEX idx_condition_visit_id ON cdm.condition_occurrence (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_measurement_person_id ON cdm.measurement (person_id ASC);
CREATE INDEX idx_measurement_concept_id ON cdm.measurement (measurement_concept_id ASC);
CREATE INDEX idx_measurement_visit_id ON cdm.measurement (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_note_person_id ON cdm.note (person_id ASC);
CREATE INDEX idx_note_concept_id ON cdm.note (note_type_concept_id ASC);
CREATE INDEX idx_note_visit_id ON cdm.note (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_note_nlp_note_id ON cdm.note_nlp (note_id ASC);
CREATE INDEX idx_note_nlp_concept_id ON cdm.note_nlp (note_nlp_concept_id ASC);

CREATE CLUSTERED INDEX idx_observation_person_id ON cdm.observation (person_id ASC);
CREATE INDEX idx_observation_concept_id ON cdm.observation (observation_concept_id ASC);
CREATE INDEX idx_observation_visit_id ON cdm.observation (visit_occurrence_id ASC);

CREATE CLUSTERED INDEX idx_survey_person_id ON cdm.survey_conduct (person_id ASC);

CREATE INDEX idx_fact_relationship_id_1 ON cdm.fact_relationship (domain_concept_id_1 ASC);
CREATE INDEX idx_fact_relationship_id_2 ON cdm.fact_relationship (domain_concept_id_2 ASC);
CREATE INDEX idx_fact_relationship_id_3 ON cdm.fact_relationship (relationship_concept_id ASC);



/************************

Standardized health system data

************************/





/************************

Standardized health economics

************************/

CREATE CLUSTERED INDEX idx_period_person_id ON cdm.payer_plan_period (person_id ASC);

CREATE CLUSTERED INDEX idx_cost_person_id ON cdm.cost (person_id ASC);


/************************

Standardized derived elements

************************/


CREATE CLUSTERED INDEX idx_drug_era_person_id ON cdm.drug_era (person_id ASC);
CREATE INDEX idx_drug_era_concept_id ON cdm.drug_era (drug_concept_id ASC);

CREATE CLUSTERED INDEX idx_dose_era_person_id ON cdm.dose_era (person_id ASC);
CREATE INDEX idx_dose_era_concept_id ON cdm.dose_era (drug_concept_id ASC);

CREATE CLUSTERED INDEX idx_condition_era_person_id ON cdm.condition_era (person_id ASC);
CREATE INDEX idx_condition_era_concept_id ON cdm.condition_era (condition_concept_id ASC);

