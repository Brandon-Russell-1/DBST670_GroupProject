SET ECHO ON;

SET SERVEROUTPUT ON;

/*---------------------------------------------------*/
/*     Generate Read and Work Loads for Lab 10/11    */
/*---------------------------------------------------*/

SHOW USER;

CONNECT sys/sysdba as SYSDBA;

SHOW USER;

/*Create Database statistics snapshot*/

exec dbms_workload_repository.create_snapshot();

/*Generate ADDM report - Run from SQLPlus as SYS*/
set long 1000000;
set pagesize 50000;
column get_clob format a80;
select dbms_advisor.get_task_report(
task_name, 'TEXT', 'ALL') 
as ADDM_report
from dba_advisor_tasks
where task_id=(
select max(t.task_id)
from dba_advisor_tasks t,dba_advisor_log l
where t.task_id = l.task_id
and t.advisor_name='ADDM'
and l.status= 'COMPLETED');


/*Write Load*/

/*Drop/Create region backup table*/
DROP TABLE regionbackup;

CREATE TABLE regionbackup (
    regionid      NUMBER(10) NOT NULL,
    regionname    VARCHAR(25),
    description   VARCHAR(150),
    CONSTRAINT pk_region PRIMARY KEY ( regionid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K )
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data1
    STORAGE ( INITIAL 192 k NEXT 20 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

/*Insert current data*/
INSERT INTO regionbackup SELECT * FROM DataDesignLeadUser.region;


/*Create loop to insert from 1,001 to 1,000,000 additional rows*/
BEGIN
    FOR v_LoopCounter IN 1001..1000000 LOOP
        INSERT INTO REGIONBACKUP (regionid,regionname, description)
        VALUES (v_LoopCounter, 'name', 'description');
        END LOOP;
    END;
/
/*Verify data is there*/

SELECT * FROM REGIONBACKUP;

/*Run loop to delete each record individually*/

declare
  i number := 1;
  cursor s1 is SELECT rowid, r.* FROM REGIONBACKUP r;
begin
  for c1 in s1 loop
      DELETE FROM REGIONBACKUP 
             WHERE regionid = i;
      i := i + 1;             
  end loop;
  commit;
end;
/

/*Verify data is Gone*/
SELECT * FROM REGIONBACKUP;

/*Do it again!*/

/*Drop/Create region backup table*/
DROP TABLE regionbackup;

CREATE TABLE regionbackup (
    regionid      NUMBER(10) NOT NULL,
    regionname    VARCHAR(25),
    description   VARCHAR(150),
    CONSTRAINT pk_region PRIMARY KEY ( regionid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K )
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data1
    STORAGE ( INITIAL 192 k NEXT 20 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

/*Insert current data*/
INSERT INTO regionbackup SELECT * FROM DataDesignLeadUser.region;

/*Create loop to insert from 1,001 to 1,000,000 additional rows*/
BEGIN
    FOR v_LoopCounter IN 1001..1000000 LOOP
        INSERT INTO REGIONBACKUP (regionid,regionname, description)
        VALUES (v_LoopCounter, 'name', 'description');
        END LOOP;
    END;
/
/*Verify data is there*/
SELECT * FROM REGIONBACKUP;

/*Run loop to delete each record individually*/

declare
  i number := 1;
  cursor s1 is SELECT rowid, r.* FROM REGIONBACKUP r;
begin
  for c1 in s1 loop
      DELETE FROM REGIONBACKUP 
             WHERE regionid = i;
      i := i + 1;             
  end loop;
  commit;
end;
/

/*Verify data is Gone*/
SELECT * FROM REGIONBACKUP;


/*Create Database statistics snapshot*/

exec dbms_workload_repository.create_snapshot();

/*Generate ADDM report - Run from SQLPlus as SYS*/
set long 1000000;
set pagesize 50000;
column get_clob format a80;
select dbms_advisor.get_task_report(
task_name, 'TEXT', 'ALL') 
as ADDM_report
from dba_advisor_tasks
where task_id=(
select max(t.task_id)
from dba_advisor_tasks t,dba_advisor_log l
where t.task_id = l.task_id
and t.advisor_name='ADDM'
and l.status= 'COMPLETED');
    