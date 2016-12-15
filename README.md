

Versions of Oracle older than 11.2 are subject to a bug that allows inserting invalid numeric data into the database.

While on the older version, all will appear fine.

When upgraded however to versions of oracle >= 11.2, then problems may appear in the form of ORA-1722 errors.

The following will illustrate:

<h3>Oracle 10gR2</h3>

<pre>

13:58:25 SQL> l
  1* select to_char(utl_raw.cast_to_number(hextoraw('BF0601'))) from dual
13:58:27 SQL> /

TO_CHAR(UTL_RAW.CAST_TO_NUMBER(HEXTORAW(
----------------------------------------
.00050

1 row selected.
</pre>

Notice the trailing zero.

<h3>Oracle 11.2</h3>

The code will raise an error on 11.2

<pre>
13:59:23 SQL> /
select to_char(utl_raw.cast_to_number(hextoraw('BF0601'))) from dual
               *
ERROR at line 1:
ORA-06502: PL/SQL: numeric or value error
ORA-06512: at "SYS.UTL_RAW", line 388
</pre>

The hex '01' portion represents a trailing zero in the internal format for NUMBER data types.

ORA-1722 would be raise if this data were selected from a table.

Remove the '01' and it will be fine.

<pre>

13:59:46 SQL> l
  1* select to_char(utl_raw.cast_to_number(hextoraw('BF06'))) from dual
13:59:47 SQL> /

TO_CHAR(UTL_RAW.CAST_TO_NUMBER(HEXTORAW(
----------------------------------------
.0005

1 row selected.

</pre>


How does this corruption occur?

So far we do not know - 10gR2 is quite old now, and this corruption could have occurred years ago.

See this Oracle note:

ORA-01722: Invalid Number After Upgrade Database From 8i To 11g (Doc ID 1916361.1)



