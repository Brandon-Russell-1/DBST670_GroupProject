SET ECHO ON;

SET SERVEROUTPUT ON;

/*---------------------------------------------------*/
/*     DROP OBJECTS                                  */
/*---------------------------------------------------*/

SHOW USER;

CONNECT DataDesignLeadUser/abc123;

SHOW USER;

/*Drop Table*/

DROP TABLE product_cat_backup;


/*-------------------------------------------------------------------*/
/*A script to create a small table with 3 rows for recovery testing.*/
/*-----------------------------------------------------------------*/

/*Create Table*/

CREATE TABLE product_cat_backup (
    prodcatid     NUMBER(10) NOT NULL,
    prodcattype   VARCHAR(25),
    description   VARCHAR(150),
    CONSTRAINT pk_prodcat_backup PRIMARY KEY ( prodcatid )
        USING INDEX TABLESPACE user_indx1
            STORAGE ( INITIAL 50 K NEXT 10 K )
)
PCTFREE 5 PCTUSED 90 TABLESPACE user_data1
    STORAGE ( INITIAL 192 k NEXT 20 k MAXEXTENTS UNLIMITED PCTINCREASE 0 );

/*Insert 3 rows of data from original product category table*/

INSERT INTO product_cat_backup SELECT * FROM product_cat WHERE PRODCATID <= 3;

commit;
/*Verify data is there*/
SELECT * FROM product_cat_backup;



/*------------------------------------------------------------------------------------------*/
/*Backup and recovery commands for Recovery testing using export/import and RMAN utilities.*/
/*----------------------------------------------------------------------------------------*/

/*Run exp command from Unix command line then return to drop table*/
DROP TABLE product_cat_backup;
SELECT * FROM product_cat_backup;

/*Drop other objects in schema for cleaner import output*/
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


/*Run imp command from Unix command line then return to view restored table*/
SELECT * FROM product_cat_backup;



/*Connect to RMAN from Unix Command Line. Create backup. Return and drop table*/
DROP TABLE product_cat_backup;

/*Check the curren scn, it should be greater than the backup scn we made at this point*/
SELECT current_scn FROM v$database; /*Run as system*/

/*Restore to backup scn and check Status with the select statement.*/
SELECT * FROM product_cat_backup;

/*-------------------------------------------------------------------------------------------*/
/*Include explanations for what happened during the recovery when import vs. RMAN was used. */
/*-----------------------------------------------------------------------------------------*/

/*-----------------------------*/
/*Flashback recovery commands.*/
/*---------------------------*/
/*Create restore point in RMAN, then view it with this select statement*/
SELECT * FROM v$restore_point; /*Run as system*/

/*Drop table*/
DROP TABLE product_cat_backup;


/*Use flashback to restore point then verify table has returned*/
SELECT * FROM product_cat_backup;

