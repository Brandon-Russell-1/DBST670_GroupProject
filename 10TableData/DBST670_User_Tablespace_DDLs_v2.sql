SET ECHO ON;

SET SERVEROUTPUT ON;

/*---------------------------------------------------*/
/*     DROP OBJECTS                                  */
/*---------------------------------------------------*/

SHOW USER;

CONNECT dbauser/abc123;

SHOW USER;

/*Drop Indexes*/

DROP INDEX fk_zip;

DROP INDEX fk_customerid;

DROP INDEX fk_order_id1;

DROP INDEX fk_product_id;

DROP INDEX fk_order_id2;

DROP INDEX fk_emp_storeid;

DROP INDEX fk_emp_zip;

DROP INDEX fk_store_region;

DROP INDEX fk_store_zip;

DROP INDEX fk_prodcatid;

DROP INDEX fk_emp_ssn;

/*Drop Tables*/

DROP TABLE payment;

DROP TABLE order_item;

DROP TABLE orders;

DROP TABLE product;

DROP TABLE customer;

DROP TABLE employee;

DROP TABLE stores;

DROP TABLE zip;

DROP TABLE region;

DROP TABLE product_cat;


/*Disconnect and Login From DBAUser to System or Vice Versa as necessary*/

SELECT 'alter system kill session '''
       || sid
       || ','
       || serial#
       || ''';'
FROM v$session
WHERE username = 'DBAUSER';

DISCONNECT;

SHOW USER;

CONNECT system/sysdba;

SHOW USER;

/*Drop Users*/

DROP USER jkamando CASCADE;

DROP USER tokusanya CASCADE;

DROP USER joluwadamilare CASCADE;

DROP USER brussell CASCADE;

DROP USER rseyoum CASCADE;

DROP USER dbauser CASCADE;

DROP USER datadesignleaduser CASCADE;

/*Create Users*/

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

CREATE USER dbauser IDENTIFIED BY abc123
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;

CREATE USER datadesignleaduser IDENTIFIED BY abc123
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;

/*Grant necessary permissions*/

GRANT connect,resource TO jkamando;

GRANT connect,resource TO tokusanya;

GRANT connect,resource TO joluwadamilare;

GRANT connect,resource TO brussell;

GRANT connect,resource TO rseyoum;

GRANT dba TO dbauser;

GRANT connect,resource TO datadesignleaduser;

/*Disconnect and Login From DBAUser to System or Vice Versa as necessary*/

SELECT 'alter system kill session '''
       || sid
       || ','
       || serial#
       || ''';'
FROM v$session
WHERE username = 'SYSTEM';

DISCONNECT;

SHOW USER;

CONNECT dbauser/abc123;

SHOW USER;

/*Drop/Create Tablespace*/

SELECT 'alter system kill session '''
       || sid
       || ','
       || serial#
       || ''';'
FROM v$session
WHERE username = 'DBAUSER';

DISCONNECT;

SHOW USER;

CONNECT system/sysdba;

SHOW USER;

DROP TABLESPACE "USER_DATA1" INCLUDING CONTENTS;

DROP TABLESPACE "USER_DATA2" INCLUDING CONTENTS;

DROP TABLESPACE "USER_INDX1" INCLUDING CONTENTS;

DROP TABLESPACE "USER_TEMP" INCLUDING CONTENTS;

CREATE TABLESPACE "USER_DATA1" LOGGING DATAFILE '/u01/app/oracle/oradata/DBST670/user_data101.dbf' SIZE 3148K REUSE AUTOEXTEND ON NEXT 512K MAXSIZE 65536K EXTENT MANAGEMENT LOCAL;  
CREATE TABLESPACE "USER_DATA2" LOGGING DATAFILE '/u01/app/oracle/oradata/DBST670/user_data201.dbf' SIZE 2552K REUSE AUTOEXTEND ON NEXT 512K MAXSIZE 65536K EXTENT MANAGEMENT LOCAL;  
CREATE TABLESPACE "USER_INDX1" LOGGING DATAFILE '/u01/app/oracle/oradata/DBST670/user_indx01.dbf' SIZE 4210K REUSE AUTOEXTEND ON NEXT 512K MAXSIZE 65536K EXTENT MANAGEMENT LOCAL;  
CREATE TEMPORARY TABLESPACE "USER_TEMP" TEMPFILE '/u01/app/oracle/oradata/DBST670/user_temp01.dbf' SIZE 16384K REUSE AUTOEXTEND ON NEXT 512K MAXSIZE 65536K EXTENT MANAGEMENT LOCAL;

/*Alter unprivileged user tablespace*/
ALTER USER JKamando DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER TOkusanya DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER JOluwadamilare DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER BRussell DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER RSeyoum DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER DBAUser DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;
ALTER USER DataDesignLeadUser DEFAULT TABLESPACE user_data1 TEMPORARY TABLESPACE user_temp;

/*Disconnect and Login From DBAUser to System or Vice Versa as necessary*/
SELECT 'alter system kill session '''
       || sid
       || ','
       || serial#
       || ''';'
FROM v$session
WHERE username = 'SYSTEM';

DISCONNECT;

SHOW USER;

CONNECT DBAUser/abc123;

SHOW USER;

/*---------------------------------------------------*/
/*     CREATE TABLES                                 */
/*---------------------------------------------------*/

CREATE TABLE zip (
    zipcode   CHAR(10) NOT NULL,
    city      CHAR(25),
    state     CHAR(2),
    CONSTRAINT pk_zip PRIMARY KEY ( zipcode )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 1000 K NEXT 120 K )
)
    PARTITION BY RANGE (
        state
    )
    ( PARTITION zip_part1
        VALUES LESS THAN ( 'N' )
    PCTFREE 5 PCTUSED 90 TABLESPACE user_data1
        STORAGE ( INITIAL 1240 k NEXT 200 k MAXEXTENTS UNLIMITED PCTINCREASE 0 ),
    PARTITION zip_part2
        VALUES LESS THAN ( MAXVALUE )
    PCTFREE 5 PCTUSED 90 TABLESPACE user_data2
        STORAGE ( INITIAL 1240 k NEXT 200 k MAXEXTENTS UNLIMITED PCTINCREASE 0 )
    );

CREATE TABLE customer (
    customerid   NUMBER(10) NOT NULL,
    firstname    VARCHAR2(15),
    lastname     VARCHAR2(15),
    phoneno      CHAR(15),
    address      VARCHAR2(35),
    zipcode      CHAR(10),
    CONSTRAINT pk_customer_id PRIMARY KEY ( customerid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K ),
    CONSTRAINT fk_zip FOREIGN KEY ( zipcode )
        REFERENCES zip
)
PCTFREE 20 PCTUSED 40 TABLESPACE user_data1
    STORAGE ( INITIAL 120 k NEXT 10 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

CREATE TABLE product (
    productid         NUMBER(10),
    prod_unit_price   NUMBER(10),
    description       VARCHAR2(150),
    CONSTRAINT pk_productid PRIMARY KEY ( productid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K )
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data2
    STORAGE ( INITIAL 168 k NEXT 20 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

CREATE TABLE region (
    regionid      NUMBER(10) NOT NULL,
    regionname    VARCHAR(25),
    description   VARCHAR(150),
    CONSTRAINT pk_region PRIMARY KEY ( regionid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K )
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data1
    STORAGE ( INITIAL 192 k NEXT 20 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

CREATE TABLE stores (
    storeid     NUMBER(10) NOT NULL,
    regionid    NUMBER(10),
    storename   VARCHAR2(15),
    address     VARCHAR2(35),
    phoneno     CHAR(15),
    zipcode     CHAR(10),
    CONSTRAINT pk_stores PRIMARY KEY ( storeid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K ),
    CONSTRAINT fk_store_region FOREIGN KEY ( regionid )
        REFERENCES region,
    CONSTRAINT fk_store_zip FOREIGN KEY ( zipcode )
        REFERENCES zip
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data1
    STORAGE ( INITIAL 96 k NEXT 10 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );
        
CREATE TABLE employee (
    sales_emp_ssn   NUMBER(9) NOT NULL,
    storeid         NUMBER(10),
    firstname       VARCHAR2(15),
    lastname        VARCHAR2(15),
    address         VARCHAR2(35),
    phoneno         CHAR(15),
    zipcode         CHAR(10),
    CONSTRAINT pk_sales_emp_ssn PRIMARY KEY ( sales_emp_ssn )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K ),
    CONSTRAINT fk_emp_storeid FOREIGN KEY ( storeid )
        REFERENCES stores,
    CONSTRAINT fk_emp_zip FOREIGN KEY ( zipcode )
        REFERENCES zip
)
PCTFREE 20 PCTUSED 40 TABLESPACE user_data1
    STORAGE ( INITIAL 120 k NEXT 10 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

CREATE TABLE orders (
    orderid         NUMBER(10) NOT NULL,
    customerid      NUMBER(10) NOT NULL,
    sales_emp_ssn   NUMBER(9) NOT NULL,
    order_method    CHAR(10),
    CONSTRAINT pk_orderid PRIMARY KEY ( orderid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K ),
    CONSTRAINT fk_customerid FOREIGN KEY ( customerid )
        REFERENCES customer,
    CONSTRAINT fk_emp_ssn FOREIGN KEY ( sales_emp_ssn )
        REFERENCES employee
)
PCTFREE 5 PCTUSED 60 TABLESPACE user_data1
    STORAGE ( INITIAL 24 k NEXT 10 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );
	
CREATE TABLE order_item (
    orderid     NUMBER(10) NOT NULL,
    productid   NUMBER(10),
    quantity    NUMBER(10),
    CONSTRAINT pk_order_item PRIMARY KEY ( orderid,
                                           productid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K ),
    CONSTRAINT fk_order_id1 FOREIGN KEY ( orderid )
        REFERENCES orders,
    CONSTRAINT fk_product_id FOREIGN KEY ( productid )
        REFERENCES product
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data2
    STORAGE ( INITIAL 16 k NEXT 20 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

CREATE TABLE payment (
    paymentid        NUMBER(10),
    orderid          NUMBER(10),
    card_exp_date    DATE,
    card_number      NUMBER(30),
    payment_amount   NUMBER(20,2),
    payment_method   VARCHAR2(5),
    CONSTRAINT pk_paymentid PRIMARY KEY ( paymentid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K ),
    CONSTRAINT fk_order_id2 FOREIGN KEY ( orderid )
        REFERENCES orders
)
PCTFREE 20 PCTUSED 40 TABLESPACE user_data2
    STORAGE ( INITIAL 40 k NEXT 10 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );
        
        
CREATE TABLE product_cat (
    prodcatid     NUMBER(10) NOT NULL,
    prodcattype   VARCHAR(25),
    description   VARCHAR(150),
    CONSTRAINT pk_prodcat PRIMARY KEY ( prodcatid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K )
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data1
    STORAGE ( INITIAL 192 k NEXT 20 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );
	
    
/*Alter Product table to include additional Product Category ID*/
ALTER TABLE PRODUCT ADD PRODCATID NUMBER (10) 
    CONSTRAINT fk_prodcatid references PRODUCT_CAT(PRODCATID);
    
    
/*--------------------------------------------*/
/*				INDEXES       */
/*--------------------------------------------*/
CREATE INDEX fk_zip ON
    customer (
        zipcode
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_customerid ON
    orders (
        customerid
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_order_id1 ON
    order_item (
        orderid
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_product_id ON
    order_item (
        productid
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_order_id2 ON
    payment (
        orderid
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_emp_storeid ON
    employee (
        storeid
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_emp_zip ON
    employee (
        zipcode
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );
    
CREATE INDEX fk_store_region ON
    stores (
        regionid
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_store_zip ON
    stores (
        zipcode
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );

CREATE INDEX fk_prodcatid ON
    product (
        prodcatid
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );  

CREATE INDEX fk_emp_ssn ON
    orders (
        sales_emp_ssn
    )
        TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K );      
/*Go to Console and Run the "RunSQLLoaders" file - Loads data into tables*/

/*Fill gaps from Loader*/
/*Product table needs PRODCATID from Product_Cat table*/

SHOW USER;

CONNECT DBAUser/abc123;

SHOW USER;

UPDATE product t1
SET
    t1.prodcatid = (
        SELECT prodcatid
        FROM product_cat t2
        WHERE t2.prodcatid = t1.productid
    )
WHERE EXISTS (
    SELECT NULL
    FROM product_cat t2
    WHERE t2.prodcatid = t1.productid
);

/*Verify Data is loaded */

SELECT *
FROM customer;

SELECT *
FROM employee;

SELECT *
FROM order_item;

SELECT *
FROM orders;

SELECT *
FROM payment;

SELECT *
FROM product;

SELECT *
FROM product_cat;

SELECT *
FROM region;

SELECT *
FROM stores;

SELECT *
FROM zip;

/*---------------------------------------------*/
/*     CHECK CONTENT OF CATALOG                */
/*---------------------------------------------*/

SELECT
        substr
    (object_name,1,20),
    object_type,status FROM
user_objects;

COMMIT;