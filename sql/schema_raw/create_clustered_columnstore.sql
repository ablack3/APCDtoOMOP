/***************************************
params: database, index_name, table_name
***************************************/

--Select database
USE @database@;
GO

--Convert @table_name@ to clustered columnstore
IF NOT EXISTS
  (SELECT * FROM sys.indexes WHERE type_desc = 'CLUSTERED COLUMNSTORE' AND object_id = OBJECT_ID('@table_name@'))
    BEGIN
  	  CREATE CLUSTERED COLUMNSTORE INDEX @index_name@ ON @table_name@;
  	END
;