SPOOL Table
/*---------------------------------------------------*/
/*     DROP OBJECTS                                  */
/*---------------------------------------------------*/

drop table PAYMENT;
drop table ORDER_ITEM;
drop table ORDERS;
drop table PRODUCT;
drop table CUSTOMER;
drop table ZIP;

/*---------------------------------------------------*/
/*     CREATE TABLES                                 */
/*---------------------------------------------------*/

create table ZIP
	(ZIPCODE			char(10)		NOT NULL,
	 CITY				char(25),
     	 STATE				char(2),
constraint pk_zip  primary key (ZIPCODE)
	using index tablespace USER_INDX1
	STORAGE (INITIAL 1000K NEXT 120K)
	)
PARTITION BY RANGE (STATE)
(
PARTITION ZIP_PART1 VALUES LESS THAN ('N')
	pctfree 5
	pctused 90
TABLESPACE USER_DATA1
	storage
		(
			initial 	1240k
			next 		200k
			maxextents	unlimited
			pctincrease	0
		),
PARTITION ZIP_PART2 VALUES LESS THAN (MAXVALUE)
	pctfree 5
	pctused 90
TABLESPACE USER_DATA2
storage
		(
			initial 	1240k
			next 		200k
			maxextents	unlimited
			pctincrease	0
		)
);

create table CUSTOMER
(	 CUSTOMERID	NUMBER(10) NOT NULL,
	 FIRSTNAME	VARCHAR2(15),
	 LASTNAME	VARCHAR2(15),
	 PHONENO	CHAR(15),
	 ADDRESS	VARCHAR2(35),
	 ZIPCODE	CHAR(10),
constraint pk_customer_id primary  key (CUSTOMERID)
	using index tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K),
constraint fk_zip foreign  key (ZIPCODE) references ZIP
)
	pctfree 20
	pctused 40
TABLESPACE USER_DATA1
	storage
		(
			initial 120k
			next 10k
			maxextents unlimited
			pctincrease 0
		);

create table PRODUCT
	(PRODUCTID 			NUMBER(10),
	 PROD_UNIT_PRICE		NUMBER(10),
	 DESCRIPTION		VARCHAR2(150),
constraint pk_productid  primary key (PRODUCTID)
	using index tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K)
	)
	pctfree 5
	pctused 90
TABLESPACE USER_DATA2
	storage
		(
			initial  150k
			next	 20k
			maxextents unlimited
			pctincrease 0
		);

create table ORDERS
	(ORDERID	NUMBER(10) NOT NULL,
	 CUSTOMERID	NUMBER(10) NOT NULL,
	 SALES_EMP_SSN	NUMBER(9),
	 ORDER_METHOD	CHAR(10),
constraint pk_orderid  primary key (ORDERID)
	using index tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K),
constraint fk_customerid foreign  key (CUSTOMERID) references CUSTOMER
	)
	pctfree 5
	pctused 60
TABLESPACE USER_DATA1
	storage
		(
			initial 100k
			next 10k
			maxextents unlimited
			pctincrease 0
		);
	
	

create table ORDER_ITEM
	(ORDERID		NUMBER(10) NOT NULL,
	 PRODUCTID		NUMBER(10),
	 QUANTITY		NUMBER(10),
Constraint pk_order_item primary key(ORDERID,PRODUCTID)
		using index tablespace USER_INDX1
		STORAGE (INITIAL 50K NEXT 10K),
Constraint fk_order_id1 foreign key (ORDERID) references ORDERS,
Constraint fk_product_id foreign key (PRODUCTID) references PRODUCT
	)
	pctfree 5
	pctused 90
TABLESPACE USER_DATA2
	storage
		(
			initial 50k
			next 20k
			maxextents unlimited
			pctincrease 0
		);


create table PAYMENT
	(PAYMENTID		NUMBER(10),
	 ORDERID		NUMBER(10),
	 CARD_EXP_DATE	DATE,
	 CARD_NUMBER	NUMBER(30),
	 PAYMENT_AMOUNT	NUMBER(20),
	 PAYMENT_METHOD	VARCHAR2(5),
constraint pk_paymentid  primary key (PAYMENTID)
	using index tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K),
constraint fk_order_id2 foreign key (ORDERID) references ORDERS )
	pctfree 20
	pctused 40
TABLESPACE USER_DATA2
	storage
		(
			initial	100k
			next		10k
			maxextents	unlimited
			pctincrease 0
		);
	
/*--------------------------------------------*/
/*				INDEXES       */
/*--------------------------------------------*/
create index  fk_zip
  on CUSTOMER (ZIPCODE)
tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K)
	;
	
create index  fk_customerid
  on ORDERS (CUSTOMERID)
tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K)
	;
	
create index  fk_order_id1
  on ORDER_ITEM (ORDERID)
tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K)
	;

create index  fk_product_id
  on ORDER_ITEM (PRODUCTID)
tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K)
	;
	
create index  fk_order_id2
  on PAYMENT (ORDERID)
tablespace USER_INDX1
	STORAGE (INITIAL 50K NEXT 10K)
	;
	
/*---------------------------------------------*/
/*     CHECK CONTENT OF CATALOG                */
/*---------------------------------------------*/
select substr(object_name, 1, 20), object_type, status
     from user_objects
	;

SPOOL OFF
