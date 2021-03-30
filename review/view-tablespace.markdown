```sql


set linesize 200
col name format a20
 
select (select tablespace_name
from dba_tablespaces
where tablespace_name = b.tablespace_name
) name
,round(kbytes_alloc/1024, 2) mbytes
,round((kbytes_alloc-nvl(kbytes_free,0))/1024, 2) used
,round(nvl(kbytes_free,0)/1024, 2) free
,round(((kbytes_alloc-nvl(kbytes_free,0))/ kbytes_alloc)*100, 2) pct_used
,round(nvl(largest,0)/1024, 2) largest
,round(nvl(kbytes_max,kbytes_alloc)/1024, 2) max_size
,round(decode(kbytes_max,0,0,((kbytes_alloc-nvl(kbytes_free,0))/kbytes_max)*100),2) pct_max_used
,(select extent_management
from dba_tablespaces
where tablespace_name = b.tablespace_name) extent_management
,(select segment_space_management
from dba_tablespaces
where tablespace_name = b.tablespace_name) segment_space_management
from (select sum(bytes)/1024 Kbytes_free, max(bytes)/1024 largest, tablespace_name
from sys.dba_free_space
group by tablespace_name ) a
,(select sum(bytes)/1024 Kbytes_alloc, sum(maxbytes)/1024 Kbytes_max, tablespace_name
from sys.dba_data_files
group by tablespace_name
union all
select sum(bytes)/1024 Kbytes_alloc, sum(maxbytes)/1024 Kbytes_max, tablespace_name
from sys.dba_temp_files group by tablespace_name )b
where a.tablespace_name (+) = b.tablespace_name
order by 2;

```

