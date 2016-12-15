select  n1
	,to_char(n1) n1
	,utl_raw.compare(rawtohex(n1), rawtohex(to_number(to_char(n1))))
from ora_1722
/
