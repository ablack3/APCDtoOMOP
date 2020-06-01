## Transforming Maine’s All Payer Claims Database to an internationally used common data model to support collaborative research

*Adam Black, Dave Denton, Maine Medical Center Research Institute; Tega Dibie, Tom Merrill, Katherine Ahrens, Ph.D University of Southern Maine*


This repository contains the ETL code for transforming the Maine All Payer Claim Data into the OMOP common data model. This repository is an R package.

**/R** - R functions used in the ETL execution     
**/data** - External data sources used in the APCD to OMOP transformation process (need to be added by user)     
**/docs** - Documentation for the project  
**/exec** - R scripts that execute the ETL  
**/sql** - SQL scripts that define specific ETL processes.



### Background: 

Health data sharing is hindered by the disparate nature of data sources and privacy concerns, therefore there is a critical need to standardize health data sources into a common data model that can be used for collaborative research across settings. 

### Methods: 

The Observational Medical Outcomes Partnerships (OMOP) Common Data Model is a standardized data model designed to accommodate various health-related data sources, such as administrative claims, electronic health records, survey data, and vital records. The OMOP common data model has been adopted internationally by health care researchers, and open source code allows for a transparent and reproducible process for generating evidence across sites.

### Results: 

We transformed Maine’s All Payer Claims Database (APCD) to the OMOP common data model. The APCD is a repository containing public and commercial claims data for nearly all residents of Maine since 2003, representing over 700 million individual claims. We designed an extract, transform, and load process to convert the APCD into the common data model, a process which includes mapping eligibility information, diagnoses, procedures, and prescriptions filled to standard codes in the common data model. 

### Conclusion: 

Completing this project allows us to join an international observational research community and participate in multisite analyses, while protecting the private health information of Maine residents.  Further work is needed to test this data transformation by comparing findings based on the original vs. transformed data.
