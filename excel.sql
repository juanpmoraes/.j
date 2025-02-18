set linesize 200
set verify   off
set feedback off
set pagesize 999
alter session set nls_territory='portugal';
alter session set nls_language='portuguese';
set markup html on entmap on spool on preformat off
spool /home/oracle/coleta.xls
select to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss') data_coleta, instance_name, host_name  from v$instance
/
select  (select instance_name  from v$instance) as instance_name
       ,to_char(round(sum(used.bytes) / 1024 / 1024 / 1024),'fm999999d00')    db_size_gb
       ,to_char(round(sum(used.bytes) / 1024 / 1024 / 1024) -
        round(free.p / 1024 / 1024 / 1024),'fm999999d00')   used_space_gb
       ,to_char(round(free.p / 1024 / 1024 / 1024),'fm999999d00')  free_space_gb
  from (select bytes
          from v$datafile
        union all
        select bytes
          from v$tempfile
        union all
        select bytes from v$log) used
      ,(select sum(bytes) as p from dba_free_space) free
group by free.p
/
select name group_name
      ,to_char(trunc(total_mb / 1024), 'fm999999d00') total_gb
      ,to_char(trunc((total_mb - free_mb) / 1024), 'fm999999d00') used_gb
      ,to_char(round((1 - (free_mb / total_mb)) * 100, 2), 'fm999999d00') pct_used
      ,to_char(100 - (round((1 - (free_mb / total_mb)) * 100, 2)),
               'fm999999d00') pct_free
  from v$asm_diskgroup
where total_mb != 0
union all 
select '_' as group_name, null total_gb, null used_gb, null pct_used,  null pct_free
from dba_objects 
where rownum <= 5 - 
(
select count(1)
  from v$asm_diskgroup
where total_mb != 0
)
/
select to_char(trunc(z.data),'dd/mm/yyyy') as data
      ,z.consumo_gb
  from (select trunc(f.timestamp) as data
              ,to_char(round(sum(f.total_bytes / 1024 / 1024 / 1024), 2),'fm999999d00') consumo_gb
          from inm_monitor.inmetspace f
         where trunc(f.timestamp) in
               (select distinct trunc(g.timestamp, 'mm')
                  from inm_monitor.inmetspace g)
         group by trunc(f.timestamp)
         order by 1 desc) z
where rownum < 7     
union all  
select '_' as data, null consumo_gb
from dba_objects 
where rownum <= 6 -(
select count(1)
  from (select trunc(f.timestamp) as data
              ,to_char(round(sum(f.total_bytes / 1024 / 1024 / 1024), 2),'fm999999d00') consumo_gb
          from inm_monitor.inmetspace f
         where trunc(f.timestamp) in
               (select distinct trunc(g.timestamp, 'mm')
                  from inm_monitor.inmetspace g)
         group by trunc(f.timestamp)
         order by 1 desc) z
where rownum < 7    )     
/
select  to_char(trunc(z.data),'dd/mm/yyyy') as data, z.consumo_gb
from (
select trunc(f.timestamp) as data
      ,(round(sum(f.total_bytes / 1024 / 1024 / 1024), 2)) consumo_gb
  from inm_monitor.inmetspace f
group by trunc(f.timestamp)
order by 1 desc ) z
where rownum < 151    
union all  
select '_' as data, null consumo_gb
from dba_objects 
where rownum <= 150 -(
select  count(1)
from (
select trunc(f.timestamp) as data
      ,(round(sum(f.total_bytes / 1024 / 1024 / 1024), 2)) consumo_gb
  from inm_monitor.inmetspace f
group by trunc(f.timestamp)
order by 1 desc ) z
where rownum < 151 )
/          
set markup html off entmap off spool off preformat on