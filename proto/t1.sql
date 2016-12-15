
-- see Oracle note How Does Oracle Store Internal Numeric Data? (Doc ID 1031902.6)

select column_name
, data_precision
, floor((data_precision+1)/2) + 1 internal_len
from user_tab_columns
where table_name = 'ORA_1722'
	and data_type = 'NUMBER'
/
