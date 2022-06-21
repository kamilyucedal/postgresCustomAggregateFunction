
-----------------------------------------------------------
-- min_to_max(numeric)
-- example usage 
-- select min_to_max(tt::numeric) from (values(1),(22),(3)) as a(tt);
-----------------------------------------------------------

drop aggregate min_to_max(numeric);

drop function min_to_max_group(numeric[]);

drop function min_to_max_row(numeric[],numeric);

create or replace function min_to_max_row(numeric[],numeric) returns numeric[] 
language plpgsql 
strict 
as $$
declare 
_min numeric:=$1[1];
_max numeric:=$1[2];
begin

	if _min>$2 then 
		_min := $2;
	end if;
	
	if _max<$2 then 
		_max := $2;
	end if;
	return ARRAY[_min, _max];

end;		
$$
;

create or replace function min_to_max_group(numeric[]) returns text as 
$$
	select $1[1]||'->'||$1[2];
$$ language 'sql' strict;


create aggregate min_to_max(numeric)
(
	INITCOND = '{9e131071,-9e131071}',
	STYPE = numeric[] ,
	SFUNC = min_to_max_row, 
	FINALFUNC = min_to_max_group
);

-----------------------------------------------------------
-- min_to_max(int)
-- example usage 
-- select min_to_max(tt) from (values(1),(22),(3)) as a(tt);
-----------------------------------------------------------

drop aggregate min_to_max(int);

drop function min_to_max_group(int[]);

drop function min_to_max_row(int[],int);

create or replace function min_to_max_row(int[],int) returns int[] 
language plpgsql 
strict 
as $$
declare 
_min int:=$1[1];
_max int:=$1[2];
begin

	if _min>$2 then 
		_min := $2;
	end if;
	
	if _max<$2 then 
		_max := $2;
	end if;
	return ARRAY[_min, _max];

end;		
$$
;

create or replace function min_to_max_group(int[]) returns text as 
$$
	select $1[1]||'->'||$1[2];
$$ language 'sql' strict;


create aggregate min_to_max(int)
(
	INITCOND = '{2147483647,-2147483648}',
	STYPE = int[] ,
	SFUNC = min_to_max_row, 
	FINALFUNC = min_to_max_group
)
;

-----------------------------------------------------------
-- min_to_max(bigint)
-- example usage 
-- select min_to_max(tt::bigint) from (values(1),(22),(3)) as a(tt);

-----------------------------------------------------------

drop aggregate min_to_max(bigint);

drop function min_to_max_group(bigint[]);

drop function min_to_max_row(bigint[],bigint);

create or replace function min_to_max_row(bigint[],bigint) returns bigint[] 
language plpgsql 
strict 
as $$
declare 
_min bigint:=$1[1];
_max bigint:=$1[2];
begin

	if _min>$2 then 
		_min := $2;
	end if;
	
	if _max<$2 then 
		_max := $2;
	end if;
	return ARRAY[_min, _max];

end;		
$$
;

create or replace function min_to_max_group(bigint[]) returns text as 
$$
	select $1[1]||'->'||$1[2];
$$ language 'sql' strict;


create aggregate min_to_max(bigint)
(
	INITCOND = '{9223372036854775807,-9223372036854775808}',
	STYPE = bigint[] ,
	SFUNC = min_to_max_row, 
	FINALFUNC = min_to_max_group
)
;

-----------------------------------------------------------
-- min_to_max(text)
-- example usage 
-- select min_to_max(tt) from (values('a'),('s'),('d')) as a(tt);
-----------------------------------------------------------

drop  aggregate min_to_max(text);

drop  function min_to_max_group(text[]) ;

drop function min_to_max_row(text[],text);

create or replace function min_to_max_row(text[],text) returns text[] 
language plpgsql 
strict 
as $$
declare 
_min text:=$1[1];
_max text:=$1[2];
begin

	if _min>$2 then 
		_min := $2;
	end if;
	
	if _max<$2 then 
		_max := $2;
	end if;
	return ARRAY[_min, _max];

end;		
$$
;

create or replace function min_to_max_group(text[]) returns text as 
$$
	select $1[1]||'->'||$1[2];
$$ language 'sql' strict;


create aggregate min_to_max(text)
(
	INITCOND = '{ZZZZZ,0000}',
	STYPE = text[] ,
	SFUNC = min_to_max_row, 
	FINALFUNC = min_to_max_group
);



-----------------------------------------------------------
-- min_to_max(numeric,text) 
-- example usage :  
-- select min_to_max(tt,' to ') from (values(-1),(11),(2)) as a(tt);
-----------------------------------------------------------

drop aggregate min_to_max(numeric,text);

drop function min_to_max_group(min_to_max_type);

drop function min_to_max_row(min_to_max_type,numeric,text);

drop type min_to_max_type;


create type min_to_max_type as (_min numeric, _max numeric, _delimiter text);

create or replace function min_to_max_row(min_to_max_type,numeric,text) returns min_to_max_type 
language plpgsql 
strict 
as $$
declare 
_min numeric:=$1._min;
_max numeric:=$1._max;
begin

	if _min>$2 then 
		_min := $2;
	end if;
	
	if _max<$2 then 
		_max := $2;
	end if;
	return (_min, _max,$3)::min_to_max_type;

end;		
$$
;

create or replace function min_to_max_group(min_to_max_type) returns text as 
$$
	select $1._min||$1._delimiter||$1._max;
$$ language 'sql' strict;


create aggregate min_to_max(numeric,text)
(
	INITCOND = '(9e131071,-9e131071,null)',
	STYPE = min_to_max_type ,
	SFUNC = min_to_max_row, 
	FINALFUNC = min_to_max_group
)
;
