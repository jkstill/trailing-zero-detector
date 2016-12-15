

col n1 format a8
col n1_raw format a16
col n1_bitand format 9999999999
col n1_bitxor format a80

select to_char(n1) n1
	, utl_raw.cast_to_raw(n1) n1_raw
	, bitand(n1,0) n1_bitand
	, utl_raw.bit_or(
			utl_raw.cast_to_raw(n1),
			utl_raw.cast_to_raw('FFFFFFFFFFFFFFFFFF')
	) n1_bitxor 
from num
/


