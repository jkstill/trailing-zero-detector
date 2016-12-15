
-- see ORA-01722: Invalid Number After Upgrade Database From 8i To 11g (Doc ID 1916361.1)

delete from ora_1722;
insert into ora_1722 values(0.00050);
-- same as .0005
insert into ora_1722 values(utl_raw.cast_to_number(hextoraw('BF06'))); 
-- becomes .00050 - trailing zero not legal
insert into ora_1722 values(utl_raw.cast_to_number(hextoraw('BF0601'))); 
commit;
