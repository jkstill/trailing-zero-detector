declare
	n_decrement number := .1;
	n_start number := -1;
	n_max_iter number;
	x number;
	mynum number(18,6);
begin
	n_max_iter := (abs(n_start) / n_decrement) * 2;
	for i in 0..n_max_iter
	loop
		mynum := n_start + ( i * n_decrement);
		insert into performance_1722 (n1) values(mynum);
		-- every 20th row is invalid number
				dbms_output.put_line('MYNUM: ' || mynum);
				dbms_output.put_line('HEX: ' || rawtohex(utl_raw.cast_to_raw(mynum)));
				dbms_output.put_line('BACK: ' || utl_raw.cast_to_number(utl_raw.cast_from_number(mynum)));
	end loop;
	commit;
end;
/
