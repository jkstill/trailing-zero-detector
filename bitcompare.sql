with data as (
	select  n1
        	,to_char(n1) n1
        	,utl_raw.compare(rawtohex(n1), rawtohex(to_number(to_char(n1)))) bitcompare
	from performance_1722
)
select distinct bitcompare,
	count(*) over (partition by bitcompare)
from data
--where bitcompare != 0
/
