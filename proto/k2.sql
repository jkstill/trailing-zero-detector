

set serveroutput on size unlimited

declare
	n_dec_1 number := 0.25;
	n_dec_2 number := 0.5;
	n_dec_minor number := .1;

	n_start number := -1;
	n_max_iter number := 20;
begin

	delete from num;

	for i in 1..n_max_iter
	loop

		insert into num (n1) values(n_start + ( i * n_dec_minor));

	end loop;

	commit;
end;
/

