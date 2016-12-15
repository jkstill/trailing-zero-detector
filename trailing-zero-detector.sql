

set serveroutput on size unlimited

create or replace package trailing_zero_detector
is

debug boolean := false;

procedure main;

end;
/

show errors package trailing_zero_detector

create or replace package body trailing_zero_detector
is

	v_detector_sql varchar(32767);

	procedure p ( str varchar2)
	is
	begin
		dbms_output.put(str);
	end;

	procedure pl ( str varchar2)
	is
	begin
		p(str);
		dbms_output.put_line('');
	end;

	procedure pd ( str varchar2)
	is
	begin
		if debug then
			p(str);
		end if;
	end;

	procedure pld ( str varchar2)
	is
	begin
		if debug then
			pd(str);
			p('');
		end if;
	end;

	-- build the SQL statement based 
	function build_sql (v_owner in varchar2, v_table_name in varchar2)
	return varchar2
	is
		pv_sql varchar2(32767) := '';
	begin

		pv_sql := 'select sum(';
		
		begin
			for crec in (
				select column_name
				from dba_tab_columns
				where owner = upper(v_owner)
					and table_name = upper(v_table_name)
					and data_type = 'NUMBER'
			)
			loop
				null;
				pv_sql := pv_sql || ' ' || 'utl_raw.compare(rawtohex(' || crec.column_name || '), rawtohex(to_number(to_char(' || crec.column_name || ')))) +';
			end loop;
			pv_sql := substr(pv_sql,1,length(pv_sql)-1);
			pv_sql := pv_sql || ' ) bitcompare_agg from ' || v_owner || '.' || v_table_name;
		exception
			when value_error then -- ora-6502
				if sqlerrm like '%buffer too small%' then
					pl(rpad('!',40,'!'));
					pl('SQL Statement too large - check Manually');
				else
					raise;
				end if;
			when others then
				raise;
		end;

		return pv_sql;

	end;


	procedure main
	is
		n_trailing_zero_sum number := 0;
	begin

		-- unlimited dbms_output buffer
		dbms_output.enable(null);

		for srec in (
			select username
			from dba_users
			where default_tablespace not in ('SYSTEM','SYSAUX')
			--where username = 'JKSTILL'
		)
		loop
			pl('Schema: ' || srec.username);
			for trec in (
				select distinct t.table_name
				from dba_tab_columns t
				-- exclude views
				join dba_objects o on o.owner = t.owner
					and o.object_name = t.table_name
					and o.object_type = 'TABLE'
				where t.owner = srec.username
					and t.data_type = 'NUMBER'
				order by table_name
			)
			loop
				p('--- Table: ' || trec.table_name);
				v_detector_sql := build_sql(srec.username, trec.table_name);	
				pld('SQL: ' || v_detector_sql);
				pld(rpad('=',100,'='));

				-- if value is not zero, then trailing zeroes are present
				execute immediate v_detector_sql into n_trailing_zero_sum;

				if n_trailing_zero_sum != 0 then
					pl(' Trailing Zero Detected!!');
				else
					pl(' All Ok');
				end if;

			end loop;
		end loop;
	end;

end;
/


show errors package body trailing_zero_detector



