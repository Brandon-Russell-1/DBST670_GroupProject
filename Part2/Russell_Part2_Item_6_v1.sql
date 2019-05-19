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

CONNECT DataDesignLeadUser/abc123;

SHOW USER;
/*Read Load*/


SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM CUSTOMER c1 WHERE c1.zipcode = z1.zipcode) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode) emp_zip_usage, 
        (SELECT avg(p1.payment_amount) FROM PAYMENT p1 WHERE p1.orderid = o1.orderid) payment_avg,
        (SELECT sum(p0.prod_unit_price) FROM PRODUCT p0 WHERE p0.productid = pr1.productid) unit_cost_sum,
        (SELECT count(z0.zipcode) FROM ZIP z0 WHERE z0.zipcode = z1.zipcode) random_zip,
        (SELECT count(o0.orderid) FROM ORDERS o0 WHERE o0.orderid = o1.orderid) order_count,
        (SELECT count(s0.storeid) FROM STORES s0 WHERE s0.storeid = s1.storeid) store_count,
        (SELECT count(r0.regionid) FROM REGION r0 WHERE r0.regionid = r1.regionid) region_count,
        (SELECT count(oi0.orderid) FROM ORDER_ITEM oi0 WHERE oi0.orderid = o1.orderid) order_item_count,
        (SELECT count(pc0.prodcatid) FROM PRODUCT_CAT pc0 WHERE pc0.prodcatid = pc1.prodcatid) prod_cat_count
            FROM ZIP z1 
                FULL JOIN CUSTOMER c2 ON c2.zipcode = z1.zipcode
                FULL JOIN ORDERS o1 ON o1.customerid = c2.customerid
                FULL JOIN PAYMENT p2 ON p2.orderid = o1.orderid
                FULL JOIN ORDER_ITEM oi1 ON oi1.orderid = o1.orderid
                FULL JOIN PRODUCT pr1 ON pr1.productid = oi1.productid
                FULL JOIN PRODUCT_CAT pc1 ON pc1.prodcatid = pr1.prodcatid
                FULL JOIN EMPLOYEE e1 ON e1.sales_emp_ssn = o1.sales_emp_ssn
                FULL JOIN STORES s1 ON s1.storeid = e1.storeid
                FULL JOIN REGION r1 ON r1.regionid = s1.regionid
                    ORDER BY cust_zip_usage DESC;

SELECT z1.zipcode, 
        (SELECT count(c1.zipcode) FROM DataDesignLeadUser.CUSTOMER c1 WHERE c1.zipcode = z1.zipcode AND c1.zipcode = (SELECT c0.zipcode FROM CUSTOMER c0 WHERE c0.customerid = c1.customerid)) cust_zip_usage, 
        (SELECT count(e0.zipcode) FROM DataDesignLeadUser.EMPLOYEE e0 WHERE e0.zipcode = z1.zipcode AND e0.zipcode = (SELECT e2.zipcode FROM EMPLOYEE e2 WHERE e2.sales_emp_ssn = e0.sales_emp_ssn)) emp_zip_usage, 
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
    
