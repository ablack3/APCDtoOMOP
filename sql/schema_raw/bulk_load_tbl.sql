/***********************
params: database, table_name, data_path, error_path, delimiter
***********************/

--Select database
USE @database@;
GO

--Load @table_name@ from csv
IF(OBJECT_ID('@table_name@') IS NOT NULL)
  BEGIN
    BULK INSERT @table_name@
    FROM '@data_path@'
    WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = '@delimiter@',
    ROWTERMINATOR = '0x0a',
    ERRORFILE = '@error_path@',
    TABLOCK
    );
  END
;
