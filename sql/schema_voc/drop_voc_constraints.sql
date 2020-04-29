--Select database
USE @database;
GO

/* DROP CHECK CONSTRAINTS */

--Drop check constraint (chk_csyn_concept_synonym_name) from cdm.concept_synonym
IF OBJECT_ID('cdm.chk_csyn_concept_synonym_name', 'C') IS NOT NULL
  ALTER TABLE cdm.concept_synonym DROP CONSTRAINT chk_csyn_concept_synonym_name;
GO

--Drop check constraint (chk_cr_invalid_reason) from cdm.concept_relationship
IF OBJECT_ID('cdm.chk_cr_invalid_reason', 'C') IS NOT NULL
  ALTER TABLE cdm.concept_relationship DROP CONSTRAINT chk_cr_invalid_reason;
GO

--Drop check constraint (chk_c_invalid_reason) from cdm.concept
IF OBJECT_ID('cdm.chk_c_invalid_reason', 'C') IS NOT NULL
  ALTER TABLE cdm.concept DROP CONSTRAINT chk_c_invalid_reason;
GO

--Drop check constraint (chk_c_concept_code) from cdm.concept
IF OBJECT_ID('cdm.chk_c_concept_code', 'C') IS NOT NULL
  ALTER TABLE cdm.concept DROP CONSTRAINT chk_c_concept_code;
GO

--Drop check constraint (chk_c_standard_concept) from cdm.concept
IF OBJECT_ID('cdm.chk_c_standard_concept', 'C') IS NOT NULL
  ALTER TABLE cdm.concept DROP CONSTRAINT chk_c_standard_concept;
GO

--Drop check constraint (chk_c_concept_name) from cdm.concept
IF OBJECT_ID('cdm.chk_c_concept_name', 'C') IS NOT NULL
  ALTER TABLE cdm.concept DROP CONSTRAINT chk_c_concept_name;
GO

/* DROP UNIQUE CONSTRAINTS */

--Drop unique constraint (uq_concept_synonym) from cdm.concept_synonym (concept_id, concept_synonym_name, language_concept_id)
IF OBJECT_ID('cdm.uq_concept_synonym', 'UQ') IS NOT NULL
	ALTER TABLE cdm.concept_synonym DROP CONSTRAINT uq_concept_synonym;
GO

/* DROP FK CONSTRAINTS */

--Drop FK constraint (fpk_drug_strength_unit_3) from cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_unit_3', 'F') IS NOT NULL
  ALTER TABLE cdm.drug_strength DROP CONSTRAINT fpk_drug_strength_unit_3;
GO

--Drop FK constraint (fpk_drug_strength_unit_2) from cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_unit_2', 'F') IS NOT NULL
  ALTER TABLE cdm.drug_strength DROP CONSTRAINT fpk_drug_strength_unit_2;
GO

--Drop FK constraint (fpk_drug_strength_unit_1) from cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_unit_1', 'F') IS NOT NULL
  ALTER TABLE cdm.drug_strength DROP CONSTRAINT fpk_drug_strength_unit_1;
GO

--Drop FK constraint (fpk_drug_strength_concept_2) from cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_concept_2', 'F') IS NOT NULL
  ALTER TABLE cdm.drug_strength DROP CONSTRAINT fpk_drug_strength_concept_2;
GO

--Drop FK constraint (fpk_drug_strength_concept_1) from cdm.drug_strength
IF OBJECT_ID('cdm.fpk_drug_strength_concept_1', 'F') IS NOT NULL
  ALTER TABLE cdm.drug_strength DROP CONSTRAINT fpk_drug_strength_concept_1;
GO

--Drop FK constraint (fpk_source_to_concept_map_c_1) from cdm.source_to_concept_map
IF OBJECT_ID('cdm.fpk_source_to_concept_map_c_1', 'F') IS NOT NULL
  ALTER TABLE cdm.source_to_concept_map DROP CONSTRAINT fpk_source_to_concept_map_c_1;
GO

--Drop FK constraint (fpk_source_to_concept_map_v_2) from cdm.source_to_concept_map
IF OBJECT_ID('cdm.fpk_source_to_concept_map_v_2', 'F') IS NOT NULL
  ALTER TABLE cdm.source_to_concept_map DROP CONSTRAINT fpk_source_to_concept_map_v_2;
GO

--Drop FK constraint (fpk_source_to_concept_map_v_1) from cdm.source_to_concept_map
IF OBJECT_ID('cdm.fpk_source_to_concept_map_v_1', 'F') IS NOT NULL
  ALTER TABLE cdm.source_to_concept_map DROP CONSTRAINT fpk_source_to_concept_map_v_1;
GO

--Drop FK constraint (fpk_concept_ancestor_concept_2) from cdm.concept_ancestor
IF OBJECT_ID('cdm.fpk_concept_ancestor_concept_2', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_ancestor DROP CONSTRAINT fpk_concept_ancestor_concept_2;
GO

--Drop FK constraint (fpk_concept_ancestor_concept_1) from cdm.concept_ancestor
IF OBJECT_ID('cdm.fpk_concept_ancestor_concept_1', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_ancestor DROP CONSTRAINT fpk_concept_ancestor_concept_1;
GO

--Drop FK constraint (fpk_concept_synonym_concept02) from cdm.concept_synonym
IF OBJECT_ID('cdm.fpk_concept_synonym_concept02', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_synonym DROP CONSTRAINT fpk_concept_synonym_concept02;
GO

--Drop FK constraint (fpk_concept_synonym_concept01) from cdm.concept_synonym
IF OBJECT_ID('cdm.fpk_concept_synonym_concept01', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_synonym DROP CONSTRAINT fpk_concept_synonym_concept01;
GO

--Drop FK constraint (fpk_relationship_reverse) from cdm.relationship
IF OBJECT_ID('cdm.fpk_relationship_reverse', 'F') IS NOT NULL
  ALTER TABLE cdm.relationship DROP CONSTRAINT fpk_relationship_reverse;
GO

--Drop FK constraint (fpk_concept_relationship_id) from cdm.relationship
IF OBJECT_ID('cdm.fpk_relationship_concept', 'F') IS NOT NULL
  ALTER TABLE cdm.relationship DROP CONSTRAINT fpk_relationship_concept;
GO

--Drop FK constraint (fpk_concept_relationship_id) from cdm.concept_relationship
IF OBJECT_ID('cdm.fpk_concept_relationship_id', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_relationship DROP CONSTRAINT fpk_concept_relationship_id;
GO

--Drop FK constraint (fpk_concept_relationship_c_2) from cdm.concept_relationship
IF OBJECT_ID('cdm.fpk_concept_relationship_c_2', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_relationship DROP CONSTRAINT fpk_concept_relationship_c_2;
GO

--Drop FK constraint (fpk_concept_relationship_c_1) from cdm.concept_relationship
IF OBJECT_ID('cdm.fpk_concept_relationship_c_1', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_relationship DROP CONSTRAINT fpk_concept_relationship_c_1;
GO

--Drop FK constraint (fpk_concept_class_concept) from cdm.concept_class
IF OBJECT_ID('cdm.fpk_concept_class_concept', 'F') IS NOT NULL
  ALTER TABLE cdm.concept_class DROP CONSTRAINT fpk_concept_class_concept;
GO

--Drop FK constraint (fpk_domain_concept) from cdm.domain
IF OBJECT_ID('cdm.fpk_domain_concept', 'F') IS NOT NULL
  ALTER TABLE cdm.domain DROP CONSTRAINT fpk_domain_concept;
GO

--Drop FK constraint (fpk_vocabulary_concept) from cdm.vocabulary
IF OBJECT_ID('cdm.fpk_vocabulary_concept', 'F') IS NOT NULL
  ALTER TABLE cdm.vocabulary DROP CONSTRAINT fpk_vocabulary_concept;
GO

--Drop FK constraint (fpk_concept_vocabulary) from cdm.concept
IF OBJECT_ID('cdm.fpk_concept_vocabulary', 'F') IS NOT NULL
  ALTER TABLE cdm.concept DROP CONSTRAINT fpk_concept_vocabulary;
GO

--Drop FK constraint (fpk_concept_class) from cdm.concept
IF OBJECT_ID('cdm.fpk_concept_class', 'F') IS NOT NULL
  ALTER TABLE cdm.concept DROP CONSTRAINT fpk_concept_class;
GO

--Drop FK constraint (fpk_concept_domain) from cdm.concept
IF OBJECT_ID('cdm.fpk_concept_domain', 'F') IS NOT NULL
  ALTER TABLE cdm.concept DROP CONSTRAINT fpk_concept_domain;
