OPTIONS (SKIP=2, LOAD=1000)

LOAD DATA
INFILE 'order_item.dat'

INTO TABLE order_item
   (ORDERID        TERMINATED BY WHITESPACE,
    PRODUCTID         TERMINATED BY WHITESPACE,
    QUANTITY		TERMINATED BY WHITESPACE)
    
    
    

