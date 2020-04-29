--Select database
USE @database;
GO

--Remove duplicate "PHENIBUT" records from cdm.concept_synonym
DELETE FROM cdm.concept_synonym WHERE cdm.concept_synonym.concept_id = 43534828 AND cdm.concept_synonym.concept_synonym_name = 'PHENIBUT'
;
GO

--Add single "PHENIBUT" record to cdm.concept_synonym
INSERT INTO cdm.concept_synonym VALUES(43534828, 'PHENIBUT', 4180186)