select tab.owner as schema_name,
       tab.table_name as table_name,
       obj.created,
       obj.last_ddl_time as last_modified,       
       tab.num_rows,
       tab.last_analyzed,
       comm.comments
  from all_tables tab
       inner join all_objects obj
           on obj.owner = tab.owner
          and obj.object_name = tab.table_name
       left outer join all_tab_comments comm
           on tab.table_name = comm.table_name
          and tab.owner = comm.owner
 where tab.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS',
 'LBACSYS', 'MDSYS','MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS',
 'ORDSYS','OUTLN', 'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM',
 'TSMSYS','WK_TEST','WKSYS', 'WKPROXY','WMSYS','XDB','APEX_040000',
 'APEX_PUBLIC_USER','DIP', 'FLOWS_30000','FLOWS_FILES','MDDATA',
 'ORACLE_OCM','SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR',
 'XS$NULL','PUBLIC')
 --  and tab.owner = 'HR' 
 order by tab.owner, 
       tab.table_name;
       
       
       
SELECT
  table_name, num_rows, owner
FROM
  all_tables
WHERE owner = 'DATADESIGNLEADUSER'
ORDER BY
  owner, table_name       