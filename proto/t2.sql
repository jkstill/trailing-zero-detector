select column_name
, data_precision
, floor((data_precision+1)/2) + 1 internal_len
from user_tab_columns
where table_name = 'NUM'
	and data_type = 'NUMBER'
/
