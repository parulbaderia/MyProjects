-- --Aspect 1:New Product Created by Seller

CREATE OR REPLACE PROCEDURE ADD_PRODUCTS(
prod_id_arg IN DECIMAL,
cat_id_arg IN DECIMAL,
seller_id_arg IN DECIMAL,
prod_name_arg IN VARCHAR,
description_arg  IN VARCHAR,
price_arg IN DECIMAL)
IS BEGIN
INSERT INTO PRODUCTS(prod_id,cat_id,seller_id,prod_name,description,price)
VALUES(prod_id_arg,cat_id_arg,seller_id_arg,prod_name_arg,description_arg,price_arg);
END;

-- --ASPECT 1 EXECUTION

BEGIN
ADD_PRODUCTS(10,1,1,'self‐driving video camera',
'automatically follows a subject that is being recorded',120);
END;
/
BEGIN
ADD_PRODUCTS(11,2,2,'holographic keyboard',
'emits a three‐dimensional projection of a keyboard and recognizes virtual key presses from the typist',25.99);
END;
/

-- --ASPECT 1 DISPLAY PRODUCTS WITH $30 OR LESS

SELECT PROD_ID,P.CAT_ID,PC.CAT_NAME,SELLER_ID,PROD_NAME,DESCRIPTION,PRICE FROM PRODUCTS P
JOIN PROD_CATEGORY PC
ON P.CAT_ID=PC.CAT_ID
WHERE PRICE<=30 AND CAT_NAME IN ('Electronics','Computer');

-- --Aspect 2: Amazon Receipt of Product from Seller

CREATE OR REPLACE PROCEDURE ADD_INVENTORY(
invent_id_arg IN DECIMAL,
seller_id_arg IN DECIMAL,
prod_id_arg IN DECIMAL,
cat_id_arg IN DECIMAL,
units_arg IN DECIMAL,
prod_condition_arg IN VARCHAR)
IS BEGIN
INSERT INTO INVENTORY(invent_id,seller_id,prod_id,cat_id,units,prod_condition)
VALUES(invent_id_arg,seller_id_arg,prod_id_arg,cat_id_arg,units_arg,prod_condition_arg);
END;

-- --ASPECT 2 EXECUTION

BEGIN
ADD_INVENTORY(10,1,10,1,4,'New');
END;
/

BEGIN
ADD_INVENTORY(11,2,11,2,4,'New');
END;
/

-- --ASPECT 2 DISPLAY PRODUCTS WITH UNITS 11 OR LESS

SELECT PROD_NAME,UNITS
FROM PRODUCTS P
JOIN INVENTORY I
ON P.PROD_ID=I.PROD_ID WHERE UNITS<=11;

-- --CREATE  PROCEDURE TO UPDATE INVENTORY

CREATE OR REPLACE PROCEDURE UPDATE_INVENTORY(
prod_id_arg IN DECIMAL,
units_arg IN DECIMAL)
IS BEGIN
UPDATE INVENTORY
SET units=units_arg where prod_id=prod_id_arg;
END;

BEGIN
UPDATE_INVENTORY(1,40);
END;

SELECT * FROM INVENTORY
WHERE PROD_ID=1;

-- Aspect 3: New Consumer Account

CREATE OR REPLACE PROCEDURE ADD_CUSTOMERS(
cust_id_arg IN DECIMAL,
fname_arg IN VARCHAR,
lname_arg IN VARCHAR,
address_arg IN VARCHAR,
email_arg IN VARCHAR,
contact_no_arg IN DECIMAL)
IS BEGIN
INSERT INTO CUSTOMERS
VALUES(cust_id_arg,fname_arg,lname_arg,address_arg,email_arg,contact_no_arg);
END;

-- --ASPECT 3 EXECUTION

BEGIN
ADD_CUSTOMERS(6,'Parul','Baderia','110,River drive,New Jersey,07310','pbaderia@clarku.edu',7746964000);
END;
/
BEGIN
ADD_CUSTOMERS(7,'Amay','Jain','501,White House St,Wahington DC,20500','amayjain@xyz.com',7778989564);
END;
/
-- --DISPLAY ASPECT-3 SAME LAST NAME

SELECT lname,COUNT(CUST_ID) AS NUMBER_OF_LNAMES FROM CUSTOMERS
GROUP BY lname
HAVING COUNT(DISTINCT CUST_ID)>=4;

-- --ASPECT-4  ADD NEW ORDER

CREATE OR REPLACE PROCEDURE ADD_NEW_PURCHASE(
order_id_arg IN DECIMAL,
cust_id_arg IN DECIMAL,
prod_id_arg IN DECIMAL,
seller_id_arg IN DECIMAL)
IS BEGIN
INSERT INTO ORDERS
VALUES(order_id_arg,cust_id_arg,prod_id_arg,seller_id_arg);
END;

-- --ASPECT 4 EXECUTION

BEGIN
ADD_NEW_PURCHASE(3,6,10,1);
ADD_NEW_PURCHASE(4,7,11,2);
END;
/
BEGIN
UPDATE_INVENTORY(10,3);
END;
/
BEGIN
UPDATE_INVENTORY(11,3);
END;
/
-- --ASPECT 4 DISPLAY POPULAR PRODUCTS

with Popular_Products AS(SELECT Cust_ID,
                        Prod_ID,COUNT(DISTINCT(CUST_ID)) OVER(PARTITION BY PROD_ID)
                        AS N_CUSTOMERS
                        FROM ORDERS)
SELECT a.fname,a.lname,a.address,b.prod_id
FROM CUSTOMERS a
JOIN POPULAR_PRODUCTS b
ON a.CUST_ID=b.CUST_ID
WHERE b.N_CUSTOMERS>=3;

-- --ASPECT-5 Product Shipment by Amazon

CREATE OR REPLACE PROCEDURE ADD_PACKAGE(
package_id_arg IN DECIMAL,
order_id_arg IN DECIMAL,
speed_id_arg IN DECIMAL)
IS BEGIN
INSERT INTO PACKAGE
VALUES(package_id_arg,order_id_arg,speed_id_arg);
END;
/
-- --ASPECT-5 EXECUTION
BEGIN
ADD_PACKAGE(1,3,1);
END;
/
BEGIN
ADD_PACKAGE(2,4,3);
END;
/

SELECT * FROM PACKAGE;
--USE OF SUBQUERY

INSERT INTO ORDERS
VALUES(8,(SELECT CUST_ID FROM CUSTOMERS WHERE EMAIL LIKE '%ankit%'),9,6);

select * from orders where order_id=8;

BEGIN
ADD_PACKAGE(3,8,2);
END;
/
-- --INDEX CREATION

SELECT P.CAT_ID,PROD_NAME 
FROM PRODUCTS P JOIN PROD_CATEGORY PC
ON P.CAT_ID=PC.CAT_ID
ORDER BY PROD_ID ASC;

CREATE INDEX ix_prod_name
ON PRODUCTS(PROD_NAME);
