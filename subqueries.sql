SQL> SELECT C.CUSTOMERNAME
  2  FROM CUSTOMER C
  3  WHERE C.CUSTOMERID IN (SELECT O.CUSTOMERID
  4  				FROM ORDERS O
  5  				JOIN PRODUCT P ON O.PRODUCTID = P.PRODUCTID
  6  				WHERE P.PRICE > (SELECT AVG(PRICE) FROM PRODUCT)
  7  );

CUSTOMERNAME                                                                    
------------------------------                                                  
AROHI                                                                           

SQL> SELECT PNAME, PRICE
  2  FROM PRODUCT
  3  WHERE PRICE = (SELECT MAX(PRICE)
  4  			FROM PRODUCT);

PNAME                     PRICE                                                 
-------------------- ----------                                                 
WATCH-HARBER           14998.25                                                 

SQL> SELECT *
  2  FROM orders
  3  WHERE order_date = (SELECT MAX(order_date) FROM orders);

ORDER_ID                       ORDER_DAT CUSTOMERID  PRODUCTID                  
------------------------------ --------- ---------- ----------                  
30A194S                        25-FEB-25       1004      90011                  
30A195S                        25-FEB-25       1005      90013                  

SQL> SELECT C. CUSTOMERID, C.CUSTOMERNAME
  2  FROM CUSTOMER C
  3  WHERE C.CUSTOMERID IN (
  4    SELECT O.CUSTOMERID
  5    FROM ORDERS O
  6    WHERE O.PRODUCTID = (
  7      SELECT PRODUCTID FROM PRODUCT WHERE PRICE = (SELECT MIN(PRICE) FROM PRODUCT)
  8    )
  9  );

no rows selected


SQL> SELECT * FROM PRODUCT
  2  ;

 PRODUCTID PNAME                     PRICE  AVAILABLE                           
---------- -------------------- ---------- ----------                           
     90009 EARPHONES-NOIDA           99.85        100                           
     90010 EARPHONES-NOIDA-2A       199.85        100                           
     90011 EARBUDS-NOIDA-2A        1999.25        100                           
     90012 EARBUDS-NOIDA-109.A     1499.25        100                           
     90013 WATCH-HARBER           14998.25        100                           
     90014 WATCH-YEER                 1768         30                           

6 rows selected.  


SQL> SELECT CUSTOMERNAME
  2  FROM CUSTOMER
  3  WHERE CUSTOMERID IN (SELECT O.CUSTOMERID
  4  			FROM ORDERS O
  5  			WHERE O.PRODUCTID IN ( SELECT PRODUCTID
  6  						FROM PRODUCT
  7  						WHERE PRICE = (
  8  								SELECT MIN(PRICE)
  9  								FROM PRODUCT) ) );

no rows selected

SQL> SELECT * FROM ORDERS;

ORDER_ID                       ORDER_DAT CUSTOMERID  PRODUCTID                  
------------------------------ --------- ---------- ----------                  
30A190S                        24-SEP-24       1001      90012                  
30A191S                        24-SEP-24       1002      90012                  
30A192S                        25-SEP-24       1003      90014                  
30A193S                        25-JAN-25       1007      90011                  
30A194S                        25-FEB-25       1004      90011                  
30A195S                        25-FEB-25       1005      90013                  

6 rows selected.

SQL> SELECT * FROM PRODUCT;

 PRODUCTID PNAME                     PRICE  AVAILABLE                           
---------- -------------------- ---------- ----------                           
     90009 EARPHONES-NOIDA           99.85        100                           
     90010 EARPHONES-NOIDA-2A       199.85        100                           
     90011 EARBUDS-NOIDA-2A        1999.25        100                           
     90012 EARBUDS-NOIDA-109.A     1499.25        100                           
     90013 WATCH-HARBER           14998.25        100                           
     90014 WATCH-YEER                 1768         30                           

6 rows selected.

SQL> SELECT C. CUSTOMERID, C.CUSTOMERNAME
  2  FROM CUSTOMER C
  3  WHERE C.CUSTOMERID IN (
  4    SELECT O.CUSTOMERID
  5    FROM ORDERS O
  6    WHERE O.PRODUCTID IN (
  7      SELECT PRODUCTID FROM PRODUCT WHERE PRICE = (SELECT MAX(PRICE) FROM PRODUCT)
  8    )
  9  );

CUSTOMERID CUSTOMERNAME                                                         
---------- ------------------------------                                       
      1005 AROHI                                                                

SQL> SELECT DISTINCT C.CUSTOMERID, C.CUSTOMERNAME
  2  FROM CUSTOMER C
  3  WHERE EXISTS (
  4    SELECT 1
  5    FROM orders o1
  6    JOIN product p1 ON o1.productid = p1.productid
  7    WHERE o1.customerid = C.customerid
  8      AND p1.price > (
  9        SELECT AVG(p2.price)
 10        FROM orders o2
 11        JOIN product p2 ON o2.productid = p2.productid
 12        WHERE o2.customerid = c.customerid
 13      )
 14  );

no rows selected


SQL> 
SQL> SELECT DISTINCT p.productid, p.pname
  2  FROM product p
  3  WHERE p.price IN (
  4    SELECT MAX(p2.price)
  5    FROM orders o2
  6    JOIN product p2 ON o2.productid = p2.productid
  7    WHERE o2.customerid IN (
  8      SELECT o.customerid FROM orders o WHERE o.productid = p.productid
  9    )
 10  );

 PRODUCTID PNAME                                                                
---------- --------------------                                                 
     90011 EARBUDS-NOIDA-2A                                                     
     90012 EARBUDS-NOIDA-109.A                                                  
     90013 WATCH-HARBER                                                         
     90014 WATCH-YEER                                                           

SQL> SELECT c.customerid, c.customername
  2  FROM customer c
  3  WHERE (
  4    SELECT COUNT(*) FROM orders o WHERE o.customerid = c.customerid
  5  ) > 3;

no rows selected

SQL> SELECT c.customerid, c.customername
  2  FROM customer c
  3  WHERE (
  4    SELECT COUNT(*) FROM orders o WHERE o.customerid = c.customerid
  5  ) > 2;

no rows selected

SQL> SELECT p.productid, p.pname
  2  FROM product p
  3  WHERE NOT EXISTS (
  4    SELECT 1 FROM orders o WHERE o.productid = p.productid
  5  );

 PRODUCTID PNAME                                                                
---------- --------------------                                                 
     90009 EARPHONES-NOIDA                                                      
     90010 EARPHONES-NOIDA-2A                                                   

SQL> SELECT customerid, customername
  2  FROM customer
  3  WHERE customerid IN (
  4    SELECT customerid
  5    FROM orders
  6    WHERE productid IN (
  7      SELECT productid FROM product WHERE price > 1000
  8    )
  9  );

CUSTOMERID CUSTOMERNAME                                                         
---------- ------------------------------                                       
      1007 RAM                                                                  
      1004 VARAH                                                                
      1001 SMITH                                                                
      1002 MITH                                                                 
      1005 AROHI                                                                
      1003 VMITH                                                                

6 rows selected.

SQL> SELECT pname
  2  FROM product
  3  WHERE productid IN (
  4    SELECT DISTINCT productid FROM orders
  5  );

PNAME                                                                           
--------------------                                                            
EARBUDS-NOIDA-2A                                                                
EARBUDS-NOIDA-109.A                                                             
WATCH-HARBER                                                                    
WATCH-YEER                                                                      


SQL> SELECT customerid, customername
  2  FROM customer c
  3  WHERE EXISTS (
  4    SELECT 1 FROM orders o
  5    JOIN shipping s ON o.order_id = s.order_id
  6    WHERE o.customerid = c.customerid AND s.status = 'SHIPPED'
  7  );

no rows selected

SQL> SELECT customerid, customername
  2  FROM customer c
  3  WHERE EXISTS (
  4    SELECT 1 FROM orders o
  5    JOIN product p ON o.productid = p.productid
  6    WHERE o.customerid = c.customerid AND p.price > 2000
  7  );

CUSTOMERID CUSTOMERNAME                                                         
---------- ------------------------------                                       
      1005 AROHI                                                                

SQL> SELECT productid, pname
  2  FROM product
  3  WHERE price = (SELECT MAX(price) FROM product);

 PRODUCTID PNAME                                                                
---------- --------------------                                                 
     90013 WATCH-HARBER                                                         

SQL> SPOOL OFF
