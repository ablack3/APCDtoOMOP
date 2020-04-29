--Select database
USE @database;
GO

/* CREATE FK CONSTRAINTS */

--Add FK constraint (fpk_concept_domain) to cdm.concept
IF OBJECT_ID('cdm.fpk_concept_domain', 'F') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT fpk_concept_domain FOREIGN KEY (domain_id) REFERENCES cdm.domain (domain_id);
GO

--Add FK constraint (fpk_concept_class) to cdm.concept
IF OBJECT_ID('cdm.fpk_concept_class', 'F') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT fpk_concept_class FOREIGN KEY (concept_class_id) REFERENCES cdm.concept_class (concept_class_id);
GO

--Add FK constraint (fpk_concept_vocabulary) to cdm.concept
IF OBJECT_ID('cdm.fpk_concept_vocabulary', 'F') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT fpk_concept_vocabulary FOREIGN KEY (vocabulary_id) REFERENCES cdm.vocabulary (vocabulary_id);
GO

--Add FK constraint (fpk_vocabulary_concept) to cdm.vocabulary
IF OBJECT_ID('cdm.fpk_vocabulary_concept', 'F') IS NULL
  ALTER TABLE cdm.vocabulary ADD CONSTRAINT fpk_vocabulary_concept FOREIGN KEY (vocabulary_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_domain_concept) to cdm.domain
IF OBJECT_ID('cdm.fpk_domain_concept', 'F') IS NULL
  ALTER TABLE cdm.domain ADD CONSTRAINT fpk_domain_concept FOREIGN KEY (domain_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_concept_class_concept) to cdm.concept_class
IF OBJECT_ID('cdm.fpk_concept_class_concept', 'F') IS NULL
  ALTER TABLE cdm.concept_class ADD CONSTRAINT fpk_concept_class_concept FOREIGN KEY (concept_class_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_concept_relationship_c_1) to cdm.concept_relationship
IF OBJECT_ID('cdm.fpk_concept_relationship_c_1', 'F') IS NULL
  ALTER TABLE cdm.concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_1 FOREIGN KEY (concept_id_1) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_concept_relationship_c_2) to cdm.concept_relationship
IF OBJECT_ID('cdm.fpk_concept_relationship_c_2', 'F') IS NULL
  ALTER TABLE cdm.concept_relationship ADD CONSTRAINT fpk_concept_relationship_c_2 FOREIGN KEY (concept_id_2) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_concept_relationship_id) to cdm.concept_relationship
IF OBJECT_ID('cdm.fpk_concept_relationship_id', 'F') IS NULL
  ALTER TABLE cdm.concept_relationship ADD CONSTRAINT fpk_concept_relationship_id FOREIGN KEY (relationship_id) REFERENCES cdm.relationship (relationship_id);
GO

--Add FK constraint (fpk_concept_relationship_id) to cdm.relationship
IF OBJECT_ID('cdm.fpk_relationship_concept', 'F') IS NULL
  ALTER TABLE cdm.relationship ADD CONSTRAINT fpk_relationship_concept FOREIGN KEY (relationship_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_relationship_reverse) to cdm.relationship
IF OBJECT_ID('cdm.fpk_relationship_reverse', 'F') IS NULL
  ALTER TABLE cdm.relationship ADD CONSTRAINT fpk_relationship_reverse FOREIGN KEY (reverse_relationship_id) REFERENCES cdm.relationship (relationship_id);
GO

--Add FK constraint (fpk_concept_synonym_concept01) to cdm.concept_synonym
IF OBJECT_ID('cdm.fpk_concept_synonym_concept01', 'F') IS NULL
  ALTER TABLE cdm.concept_synonym ADD CONSTRAINT fpk_concept_synonym_concept01 FOREIGN KEY (concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_concept_synonym_concept02) to cdm.concept_synonym
IF OBJECT_ID('cdm.fpk_concept_synonym_concept02', 'F') IS NULL
  ALTER TABLE cdm.concept_synonym ADD CONSTRAINT fpk_concept_synonym_concept02 FOREIGN KEY (language_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_concept_ancestor_concept_1) to cdm.concept_ancestor
IF OBJECT_ID('cdm.fpk_concept_ancestor_concept_1', 'F') IS NULL
  ALTER TABLE cdm.concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_1 FOREIGN KEY (ancestor_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_concept_ancestor_concept_2) to cdm.concept_ancestor
IF OBJECT_ID('cdm.fpk_concept_ancestor_concept_2', 'F') IS NULL
  ALTER TABLE cdm.concept_ancestor ADD CONSTRAINT fpk_concept_ancestor_concept_2 FOREIGN KEY (descendant_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_source_to_concept_map_v_1) to cdm.source_to_concept_map
IF OBJECT_ID('cdm.fpk_source_to_concept_map_v_1', 'F') IS NULL
  ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_1 FOREIGN KEY (source_vocabulary_id) REFERENCES cdm.vocabulary (vocabulary_id);
GO

--Add FK constraint (fpk_source_to_concept_map_v_2) to cdm.source_to_concept_map
IF OBJECT_ID('cdm.fpk_source_to_concept_map_v_2', 'F') IS NULL
  ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_v_2 FOREIGN KEY (target_vocabulary_id) REFERENCES cdm.vocabulary (vocabulary_id);
GO

--Add FK constraint (fpk_source_to_concept_map_c_1) to cdm.source_to_concept_map
IF OBJECT_ID('cdm.fpk_source_to_concept_map_c_1', 'F') IS NULL
  ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT fpk_source_to_concept_map_c_1 FOREIGN KEY (target_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_drug_strength_concept_1) to cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_concept_1', 'F') IS NULL
  ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_concept_1 FOREIGN KEY (drug_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_drug_strength_concept_2) to cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_concept_2', 'F') IS NULL
  ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_concept_2 FOREIGN KEY (ingredient_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_drug_strength_unit_1) to cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_unit_1', 'F') IS NULL
  ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_1 FOREIGN KEY (amount_unit_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_drug_strength_unit_2) to cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_unit_2', 'F') IS NULL
  ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_2 FOREIGN KEY (numerator_unit_concept_id) REFERENCES cdm.concept (concept_id);
GO

--Add FK constraint (fpk_drug_strength_unit_3) to cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_unit_3', 'F') IS NULL
  ALTER TABLE cdm.drug_strength ADD CONSTRAINT fpk_drug_strength_unit_3 FOREIGN KEY (denominator_unit_concept_id) REFERENCES cdm.concept (concept_id);
GO

/* CREATE UNIQUE CONSTRAINTS */

--Add unique constraint (uq_concept_synonym) to cdm.concept_synonym (concept_id, concept_synonym_name, language_concept_id)
IF OBJECT_ID('cdm.uq_concept_synonym', 'UQ') IS NULL
	ALTER TABLE cdm.concept_synonym ADD CONSTRAINT uq_concept_synonym UNIQUE (concept_id, concept_synonym_name, language_concept_id);
GO

/* CREATE CHECK CONSTRAINTS */

--Add check constraint (chk_c_concept_name) to cdm.concept
IF OBJECT_ID('cdm.chk_c_concept_name', 'C') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_concept_name CHECK (concept_name <> '');
GO

--Add check constraint (chk_c_standard_concept) to cdm.concept
IF OBJECT_ID('cdm.chk_c_standard_concept', 'C') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_standard_concept CHECK (COALESCE(standard_concept,'C') in ('C','S'));
GO

--Add check constraint (chk_c_concept_code) to cdm.concept
IF OBJECT_ID('cdm.chk_c_concept_code', 'C') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_concept_code CHECK (concept_code <> '');
GO

--Add check constraint (chk_c_invalid_reason) to cdm.concept
IF OBJECT_ID('cdm.chk_c_invalid_reason', 'C') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT chk_c_invalid_reason CHECK (COALESCE(invalid_reason,'D') in ('D','U'));
GO

--Add check constraint (chk_cr_invalid_reason) to cdm.concept_relationship
IF OBJECT_ID('cdm.chk_cr_invalid_reason', 'C') IS NULL
  ALTER TABLE cdm.concept_relationship ADD CONSTRAINT chk_cr_invalid_reason CHECK (COALESCE(invalid_reason,'D')='D');
GO

--Add check constraint (chk_csyn_concept_synonym_name) to cdm.concept_synonym
IF OBJECT_ID('cdm.chk_csyn_concept_synonym_name', 'C') IS NULL
  ALTER TABLE cdm.concept_synonym ADD CONSTRAINT chk_csyn_concept_synonym_name CHECK (concept_synonym_name <> '');

