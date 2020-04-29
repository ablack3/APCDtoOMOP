--Select database
USE @database;
GO

/*ADD PRIMARY KEY CONSTRAINTS TO VOCAB TABLES*/
--Add PK to cdm.concept
IF OBJECT_ID('cdm.xpk_concept', 'PK') IS NULL
  ALTER TABLE cdm.concept ADD CONSTRAINT xpk_concept PRIMARY KEY NONCLUSTERED (concept_id);
GO

--Add PK to cdm.vocabulary
IF OBJECT_ID('cdm.xpk_vocabulary', 'PK') IS NULL
  ALTER TABLE cdm.vocabulary ADD CONSTRAINT xpk_vocabulary PRIMARY KEY NONCLUSTERED (vocabulary_id);
GO

--Add PK to cdm.domain
IF OBJECT_ID('cdm.xpk_domain', 'PK') IS NULL
  ALTER TABLE cdm.domain ADD CONSTRAINT xpk_domain PRIMARY KEY NONCLUSTERED (domain_id);
GO

--Add PK to cdm.concept_class
IF OBJECT_ID('cdm.xpk_concept_class', 'PK') IS NULL
  ALTER TABLE cdm.concept_class ADD CONSTRAINT xpk_concept_class PRIMARY KEY NONCLUSTERED (concept_class_id);
GO

--Add PK to cdm.concept_relationship
IF OBJECT_ID('cdm.xpk_concept_relationship', 'PK') IS NULL
  ALTER TABLE cdm.concept_relationship ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY NONCLUSTERED (concept_id_1,concept_id_2,relationship_id);
GO

--Add PK to cdm.relationship
IF OBJECT_ID('cdm.xpk_relationship', 'PK') IS NULL
  ALTER TABLE cdm.relationship ADD CONSTRAINT xpk_relationship PRIMARY KEY NONCLUSTERED (relationship_id);
GO

--Add PK to cdm.concept_ancestor
IF OBJECT_ID('cdm.xpk_concept_ancestor', 'PK') IS NULL
  ALTER TABLE cdm.concept_ancestor ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY NONCLUSTERED (ancestor_concept_id,descendant_concept_id);
GO

--Add PK to cdm.source_to_concept_map
IF OBJECT_ID('cdm.xpk_source_to_concept_map', 'PK') IS NULL
  ALTER TABLE cdm.source_to_concept_map ADD CONSTRAINT xpk_source_to_concept_map PRIMARY KEY NONCLUSTERED (source_vocabulary_id,target_concept_id,source_code,valid_end_date);
GO

--Add PK to cdm.drug_strength
IF OBJECT_ID('cdm.xpk_drug_strength', 'PK') IS NULL
  ALTER TABLE cdm.drug_strength ADD CONSTRAINT xpk_drug_strength PRIMARY KEY NONCLUSTERED (drug_concept_id, ingredient_concept_id);
GO

/*ADD INDEXES TO VOCAB TABLES*/
--Add unique clustered index to cdm.concept.concept_id (idx_concept_concept_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_concept_id' AND object_id = OBJECT_ID('cdm.concept'))
    BEGIN
	    CREATE UNIQUE CLUSTERED INDEX idx_concept_concept_id ON cdm.concept (concept_id ASC);
	  END
;
GO

--Add index to cdm.concept.concept_code (idx_concept_code)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_code' AND object_id = OBJECT_ID('cdm.concept'))
    BEGIN
	    CREATE INDEX idx_concept_code ON cdm.concept (concept_code ASC);
	  END
;
GO

--Add index to cdm.concept.vocabulary_id (idx_concept_vocabluary_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_vocabluary_id' AND object_id = OBJECT_ID('cdm.concept'))
    BEGIN
  	  CREATE INDEX idx_concept_vocabluary_id ON cdm.concept (vocabulary_id ASC);
  	END
;
GO

--Add index to cdm.concept.domain_id (idx_concept_domain_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_domain_id' AND object_id = OBJECT_ID('cdm.concept'))
    BEGIN
  	  CREATE INDEX idx_concept_domain_id ON cdm.concept (domain_id ASC);
  	END
;
GO

--Add index to cdm.concept.concept_class_id (idx_concept_class_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_class_id' AND object_id = OBJECT_ID('cdm.concept'))
    BEGIN
  	  CREATE INDEX idx_concept_class_id ON cdm.concept (concept_class_id ASC);
  	END
;
GO

--Add unique clustered index to cdm.vocabulary.vocabulary_id (idx_vocabulary_vocabulary_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_vocabulary_vocabulary_id' AND object_id = OBJECT_ID('cdm.vocabulary'))
    BEGIN
  	  CREATE UNIQUE CLUSTERED INDEX idx_vocabulary_vocabulary_id ON cdm.vocabulary (vocabulary_id ASC);
  	END
;
GO

--Add unique clustered index to cdm.doman.domain_id (idx_domain_domain_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_domain_domain_id' AND object_id = OBJECT_ID('cdm.domain'))
    BEGIN
  	  CREATE UNIQUE CLUSTERED INDEX idx_domain_domain_id ON cdm.domain (domain_id ASC);
  	END
GO

--Add unique clustered index to cdm.concept_class.concept_class_id (idx_concept_class_class_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_class_class_id' AND object_id = OBJECT_ID('cdm.concept_class'))
    BEGIN
  	  CREATE UNIQUE CLUSTERED INDEX idx_concept_class_class_id ON cdm.concept_class (concept_class_id ASC);
  	END
;
GO

--Add index to cdm.concept_relationship.concept_id_1 (idx_concept_relationship_id_1)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_relationship_id_1' AND object_id = OBJECT_ID('cdm.concept_relationship'))
    BEGIN
  	  CREATE INDEX idx_concept_relationship_id_1 ON cdm.concept_relationship (concept_id_1 ASC);
  	END
;
GO

--Add index to cdm.concept_relationship.concept_id_2 (idx_concept_relationship_id_2)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_relationship_id_2' AND object_id = OBJECT_ID('cdm.concept_relationship'))
    BEGIN
  	  CREATE INDEX idx_concept_relationship_id_2 ON cdm.concept_relationship (concept_id_2 ASC);
  	END
;
GO

--Add index to cdm.concept_relationship.concept_id_3 (idx_concept_relationship_id_3)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_relationship_id_3' AND object_id = OBJECT_ID('cdm.concept_relationship'))
    BEGIN
  	  CREATE INDEX idx_concept_relationship_id_3 ON cdm.concept_relationship (relationship_id ASC);
  	END
;
GO

--Add unique clustered index to cdm.relationship.relationship_id (idx_concept_class_class_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_relationship_rel_id' AND object_id = OBJECT_ID('cdm.relationship'))
    BEGIN
  	  CREATE UNIQUE CLUSTERED INDEX idx_relationship_rel_id ON cdm.relationship (relationship_id ASC);
  	END
;
GO

--Add clustered index to cdm.concept_synonym.concept_id (idx_concept_synonym_id)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_synonym_id' AND object_id = OBJECT_ID('cdm.concept_synonym'))
    BEGIN
  	  CREATE CLUSTERED INDEX idx_concept_synonym_id ON cdm.concept_synonym (concept_id ASC);
  	END
;
GO

--Add clustered index to cdm.concept_ancestor.ancestor_concept_id (idx_concept_ancestor_id_1)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_ancestor_id_1' AND object_id = OBJECT_ID('cdm.concept_ancestor'))
    BEGIN
  	  CREATE CLUSTERED INDEX idx_concept_ancestor_id_1 ON cdm.concept_ancestor (ancestor_concept_id ASC);
  	END
;
GO

--Add index to cdm.concept_ancestor.descendant_concept_id (idx_concept_ancestor_id_2)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_concept_ancestor_id_2' AND object_id = OBJECT_ID('cdm.concept_ancestor'))
    BEGIN
  	  CREATE INDEX idx_concept_ancestor_id_2 ON cdm.concept_ancestor (descendant_concept_id ASC);
  	END
;
GO

--Add clustered index to cdm.source_to_concept_map.target_concept_id (idx_source_to_concept_map_id_3)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_source_to_concept_map_id_3' AND object_id = OBJECT_ID('cdm.source_to_concept_map'))
    BEGIN
  	  CREATE CLUSTERED INDEX idx_source_to_concept_map_id_3 ON cdm.source_to_concept_map (target_concept_id ASC);
  	END
;
GO

--Add index to cdm.source_to_concept_map.source_vocabulary_id (idx_source_to_concept_map_id_1)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_source_to_concept_map_id_1' AND object_id = OBJECT_ID('cdm.source_to_concept_map'))
    BEGIN
  	  CREATE INDEX idx_source_to_concept_map_id_1 ON cdm.source_to_concept_map (source_vocabulary_id ASC);
  	END
;
GO

--Add index to cdm.source_to_concept_map.target_vocabulary_id (idx_source_to_concept_map_id_2)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_source_to_concept_map_id_2' AND object_id = OBJECT_ID('cdm.source_to_concept_map'))
    BEGIN
  	  CREATE INDEX idx_source_to_concept_map_id_2 ON cdm.source_to_concept_map (target_vocabulary_id ASC);
  	END
;
GO

--Add index to cdm.source_to_concept_map.source_code (idx_source_to_concept_map_code)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_source_to_concept_map_code' AND object_id = OBJECT_ID('cdm.source_to_concept_map'))
    BEGIN
  	  CREATE INDEX idx_source_to_concept_map_code ON cdm.source_to_concept_map (source_code ASC);
  	END
;
GO

--Add clustered index to cdm.drug_strength.drug_concept_id (idx_drug_strength_id_1)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_drug_strength_id_1' AND object_id = OBJECT_ID('cdm.drug_strength'))
    BEGIN
  	  CREATE CLUSTERED INDEX idx_drug_strength_id_1 ON cdm.drug_strength (drug_concept_id ASC);
  	END
;
GO

--Add index to cdm.drug_strength.ingredient_concept_id (idx_drug_strength_id_2)
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE name = 'idx_drug_strength_id_2' AND object_id = OBJECT_ID('cdm.drug_strength'))
    BEGIN
  	  CREATE INDEX idx_drug_strength_id_2 ON cdm.drug_strength (ingredient_concept_id ASC);
  	END
;

