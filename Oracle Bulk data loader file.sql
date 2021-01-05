-- Oracle Bulk data loader file 
-- Created by: Alexandru Dragut
-- Scope: Automaticaly generate CTL File for SQL Loader


Select
'LOAD DATA
INFILE ' || '&FULL_PATH_FILE' ||
'
REPLACE
INTO TABLE ' || '&TABLE_NAME' ||
' FIELDS TERMINATED BY ","
TRAILING NULLCOLS
(' "Column Name",' ' "sql_loader_type" from dual
union all
select
COLUMN_NAME,
DECODE(DATA_TYPE,
'TIMESTAMP(6)','TIMESTAMP "MM/DD/YYYY HH24:MI:SS.FF",',
'NUMBER','DECIMAL EXTERNAL,',
'VARCHAR2','CHAR,',
'CHAR','CHAR',
'DATE','"TO_DATE(SUBSTR(:' || column_name || ',1,19),''MM/DD/YYYY HH24:MI:SS'')",'
) "sql_loader_type"
from (
select * from
all_tab_cols
where owner=UPPER('&SCHEMA_NAME') AND TABLE_NAME = UPPER('&TABLE_NAME')
order by column_id)
union all
select ')' "Column Name" , '' "sql_loader_type" from dual  

