select 
	utl_raw.bit_or(hextoraw('FFFF'),hextoraw('FFFF')) 
	, utl_raw.bit_or(utl_raw.cast_to_raw(hextoraw('FFFF')),utl_raw.cast_to_raw(hextoraw('FFFF'))) 
from dual
/
