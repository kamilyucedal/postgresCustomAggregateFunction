## Postgres Custom Aggregate Function For Min To Max Representation

Hi, 
This aggregation function is written to present minimum and maximum value in a group, in postgresql.
ıt has some overloading variations;
min_to_max(numeric)
min_to_max(int)
min_to_max(bigint)
min_to_max(text)
min_to_max(numeric,text)

It can be installed by running scripts in "aggregate-in-sql" file ( or directly run with "psql -f /path/to/file/aggregate-in-sql.sql").

#### Sample Usage
select min_to_max(tt) from (values(1),(22),(3)) as a(tt);

#### Output be like 
#####min_to_max
------------
 1->22

I plan to write an extension with C language for it as well. 
