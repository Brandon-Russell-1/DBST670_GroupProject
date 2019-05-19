SET ECHO ON;

SET SERVEROUTPUT ON;

/*---------------------------------------------------*/
/*     Part 2 Checklist Items 13-19                  */
/*---------------------------------------------------*/

SHOW USER;

CONNECT DBAUser/abc123;

SHOW USER;

/*Item 13-15 - Monitor Database status*/

/*Check if database status is open and active*/
SELECT instance_name, status, database_status FROM V$INSTANCE;

/*Check if status allows you to read and write to database*/
SELECT name, open_mode FROM V$DATABASE;


/*Get Database reserved, used, and free space size*/
SELECT "Reserved_Space(MB)", "Reserved_Space(MB)" - "Free_Space(MB)" "Used_Space(MB)","Free_Space(MB)"
FROM ( SELECT 
        (SELECT round(SUM(bytes/(1024*1024)),2) FROM dba_data_files) "Reserved_Space(MB)",
        (SELECT round(SUM(bytes/(1024*1024)),2) FROM dba_free_space) "Free_Space(MB)"
            FROM dual);

/*Show tablespace file location. Also, allocated and free space per tablespace*/
SELECT 
   a.tablespace_name, 
   a.file_name, 
   round(a.bytes/(1024*1024), 2) allocated_MB, 
   round(b.free_bytes/(1024*1024),2) free_MB
FROM 
   (SELECT tablespace_name, file_name, bytes 
        FROM dba_data_files UNION SELECT tablespace_name, file_name, bytes FROM dba_temp_files )a, 
   (SELECT tablespace_name, SUM(bytes) free_bytes 
        FROM dba_free_space b GROUP BY tablespace_name) b  
            WHERE a.tablespace_name=b.tablespace_name(+) ORDER BY a.tablespace_name;
            

/*Return all objects*/           
SELECT substr(object_name,1,20), object_type,status FROM all_objects;

/*Return all invalid objects*/
SELECT owner, substr(object_name,1,20), object_type, status FROM all_objects WHERE status = 'INVALID';

/*Item 16 - Create end users and give privileges*/

/*Drop Users*/

DROP USER jkamando CASCADE;

DROP USER tokusanya CASCADE;

DROP USER joluwadamilare CASCADE;

DROP USER brussell CASCADE;

DROP USER rseyoum CASCADE;

/*---------------------------------------------------*/
/*     CREATE USERS                                  */
/*---------------------------------------------------*/

CREATE USER jkamando IDENTIFIED BY abc123
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;

CREATE USER tokusanya IDENTIFIED BY abc123
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;

CREATE USER joluwadamilare IDENTIFIED BY abc123
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;

CREATE USER brussell IDENTIFIED BY abc123
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;

CREATE USER rseyoum IDENTIFIED BY abc123
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;


/*Grant necessary permissions*/

GRANT connect,resource TO jkamando;

GRANT connect,resource TO tokusanya;

GRANT connect,resource TO joluwadamilare;

GRANT connect,resource TO brussell;

GRANT connect,resource TO rseyoum;


/*Alter unprivileged user tablespace*/
ALTER USER JKamando DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER TOkusanya DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER JOluwadamilare DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER BRussell DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER RSeyoum DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;

/*Item 17 - Create synonyms*/

/*Create synonym for each table from DBAUser*/
CREATE OR REPLACE PUBLIC SYNONYM MYCUSTOMERS
    FOR DATADESIGNLEADUSER.CUSTOMER;
CREATE OR REPLACE PUBLIC SYNONYM MYEMPLOYEE
    FOR DATADESIGNLEADUSER.EMPLOYEE;    
CREATE OR REPLACE PUBLIC SYNONYM MYORDER_ITEM
    FOR DATADESIGNLEADUSER.ORDER_ITEM;    
CREATE OR REPLACE PUBLIC SYNONYM MYORDERS
    FOR DATADESIGNLEADUSER.ORDERS;
CREATE OR REPLACE PUBLIC SYNONYM MYPAYMENT
    FOR DATADESIGNLEADUSER.PAYMENT;
CREATE OR REPLACE PUBLIC SYNONYM MYPRODUCT
    FOR DATADESIGNLEADUSER.PRODUCT;
CREATE OR REPLACE PUBLIC SYNONYM MYPRODUCT_CAT
    FOR DATADESIGNLEADUSER.PRODUCT_CAT;
CREATE OR REPLACE PUBLIC SYNONYM MYREGION
    FOR DATADESIGNLEADUSER.REGION;
CREATE OR REPLACE PUBLIC SYNONYM MYSTORES
    FOR DATADESIGNLEADUSER.STORES;
CREATE OR REPLACE PUBLIC SYNONYM MYZIP
    FOR DATADESIGNLEADUSER.ZIP;    
 
/*Verify synonym works*/    
SELECT * FROM MYCUSTOMERS;    
SELECT * FROM MYEMPLOYEE;
SELECT * FROM MYORDER_ITEM;
SELECT * FROM MYORDERS;
SELECT * FROM MYPAYMENT;
SELECT * FROM MYPRODUCT;
SELECT * FROM MYPRODUCT_CAT;
SELECT * FROM MYREGION;
SELECT * FROM MYSTORES;
SELECT * FROM MYZIP;

/*Item 18 - Use dbms_metadata to reverse engineer table and index ddls*/
/*Set Display Environment*/
SET HEADING ON;
SET PAGES 999;
SET LONG 90000;

/*Generate DDLs for tables and indexes in DataDesignLeadUser schema*/
SELECT 
   dbms_metadata.GET_DDL(object_type,object_name,'DATADESIGNLEADUSER')
FROM all_objects
WHERE owner = 'DATADESIGNLEADUSER' AND (object_type = 'TABLE' OR object_type = 'INDEX');


/*Item 19 - Script to detect end user and what they are running*/
SET LINESIZE 100;
SELECT  a.sid, a.username, optimizer_mode, cpu_time, elapsed_time, sql_text
  FROM v$sqlarea sqlarea, v$session a
        WHERE a.sql_hash_value = sqlarea.hash_value
            AND a.sql_address    = sqlarea.address AND a.username is not null;

