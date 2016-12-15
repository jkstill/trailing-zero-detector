
col n1_raw format a10
col n2_raw format a10
col n3_raw format a10
col n4_raw format a10

select 
	n1, rawtohex(utl_raw.cast_to_raw(n1))  n1_raw,
	n2, rawtohex(utl_raw.cast_to_raw(n2))  n2_raw,
	n3, rawtohex(utl_raw.cast_to_raw(n3))  n3_raw,
	n4, rawtohex(utl_raw.cast_to_raw(n4))  n4_raw
from num
order by n1
/
