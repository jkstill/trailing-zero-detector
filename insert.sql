
-- see ORA-01722: Invalid Number After Upgrade Database From 8i To 11g (Doc ID 1916361.1)

-- create a table with invalid numbers for some performance testing

truncate table performance_1722;

commit;

set serveroutput on size unlimited

declare
	n_decrement number := .1;

	n_start number := -1000;
	n_max_iter number;

	n_mynum number;

begin

	n_max_iter := (abs(n_start) / n_decrement) * 2;

	for i in 0..n_max_iter
	loop

		n_mynum := n_start + ( i * n_decrement);

		insert into performance_1722 (n1) values(n_mynum);

		-- dbms_output.put_line('MYNUM: ' || mynum);
		-- dbms_output.put_line('HEX: ' || rawtohex(utl_raw.cast_to_raw(mynum)));
		-- dbms_output.put_line('BACK: ' || utl_raw.cast_to_number(utl_raw.cast_from_number(mynum)));

		-- every 20th row is invalid number
		if mod(i,3) = 0 then
			insert into performance_1722 (n1) values(
				--utl_raw.cast_to_number(utl_raw.concat(utl_raw.cast_from_number(n_mynum), hextoraw('1')))
				utl_raw.cast_to_number(hextoraw(rawtohex(utl_raw.cast_from_number(n_mynum)) || '01'))
			);
		end if;

	end loop;

	commit;
end;
/

--select * from performance_1722;

