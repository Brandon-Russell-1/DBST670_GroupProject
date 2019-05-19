SET ECHO ON;

SET SERVEROUTPUT ON;

/*---------------------------------------------------*/
/*     DROP INDEXES and TABLES for Export/Import     */
/*---------------------------------------------------*/

SHOW USER;

CONNECT DataDesignLeadUser/abc123;

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


/*Verify Data is loaded */

SELECT COUNT(*)
FROM customer;

SELECT COUNT(*)
FROM employee;

SELECT COUNT(*)
FROM order_item;

SELECT COUNT(*)
FROM orders;

SELECT COUNT(*)
FROM payment;

SELECT COUNT(*)
FROM product;

SELECT COUNT(*)
FROM product_cat;

SELECT COUNT(*)
FROM region;

SELECT COUNT(*)
FROM stores;

SELECT COUNT(*)
FROM zip;