SET ECHO ON;

SET SERVEROUTPUT ON;

/*---------------------------------------------------*/
/*     Part 2 Checklist Items 4-5                    */
/*---------------------------------------------------*/

/*Check v$sysstat*/
DESC v$sysstat;

SELECT name,value FROM v$sysstat WHERE name like 'physical%';

SELECT name,value FROM v$sysstat WHERE name like '%cache%';

SELECT name,value FROM v$sysstat;


/*Run five stats, then read load, then five stats again*/
/*Check Stats*/
SELECT name, value FROM V$sysstat where name IN ('CPU used when call started', 'physical reads', 'physical writes', 'concurrency wait time', 'Requests to/from client');

/*Read Load - Same Command is ran 200 times to generate a intense load that takes at least 60 seconds.*/

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = 
            (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = 
            (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;           

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;                     

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;
                    

                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;           

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;                     

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;
                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;
                    

                    
SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC; 

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM DataDesignLeadUser.CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM DataDesignLeadUser.EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM DataDesignLeadUser.PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM DataDesignLeadUser.PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM DataDesignLeadUser.ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM DataDesignLeadUser.ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM DataDesignLeadUser.STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM DataDesignLeadUser.REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM DataDesignLeadUser.ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM DataDesignLeadUser.PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM DataDesignLeadUser.ZIP z1 
                FULL JOIN DataDesignLeadUser.CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN DataDesignLeadUser.ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN DataDesignLeadUser.PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN DataDesignLeadUser.PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN DataDesignLeadUser.PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN DataDesignLeadUser.EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN DataDesignLeadUser.STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN DataDesignLeadUser.REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;


/*Check Stats*/
SELECT name, value FROM V$sysstat where name IN ('CPU used when call started', 'physical reads', 'physical writes', 'concurrency wait time', 'Requests to/from client');


/*Flush shared pool before write load*/
ALTER SYSTEM flush shared_pool;

/*Run five stats, then write load, then five stats again*/

/*Check Stats*/
SELECT name, value FROM V$sysstat where name IN ('CPU used when call started', 'physical reads', 'physical writes', 'concurrency wait time', 'Requests to/from client');


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


/*Check Stats*/
SELECT name, value FROM V$sysstat where name IN ('CPU used when call started', 'physical reads', 'physical writes', 'concurrency wait time', 'Requests to/from client');