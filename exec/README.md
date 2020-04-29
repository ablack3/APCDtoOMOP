## APCD to OMOP  

This folder contains the R scripts that execute the APCD to OMOP CDM transformation process.  

**/schema_<name>** - Orchestration scripts specific to a single ETL layer (schema).

There are three layers to the transformation process

1. schema_raw - load the raw data from flat files into the database
2. schema_stg - stage the source data and perform some basic data cleaning and transformation
3. schema_cdm - map the staged data to the cdm format and load into the cdm tables

The scripts must run in order: raw first, then stg, then cdm.

