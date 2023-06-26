-- create a table CUSTOMERS
CREATE TABLE CUSTOMERS(
cust_id decimal(12) not null primary key,
fname varchar(256) not null,
lname varchar(256) not null,
address varchar(256) not null,
email varchar(256) not null,
contact_no decimal(12) not null
);
-- create a table PROD_CATEGORY
CREATE TABLE PROD_CATEGORY(
cat_id decimal(12) not null primary key,
cat_name varchar(256) not null);

-- create a table SELLER
CREATE TABLE SELLER(
seller_id decimal(12) not null primary key,
sname varchar(256) not null,
address varchar(256) not null,
s_contact_no decimal(12) not null,
s_email varchar(256) not null);

-- create a table SPEED
CREATE TABLE SPEED(
speed_id decimal(12) not null primary key,
speed_type_name varchar(256) not null);

-- create a table PRODUCTS
CREATE TABLE PRODUCTS
(prod_id decimal(12) not null primary key,
cat_id decimal(12) not null,
seller_id decimal(12) not null,
prod_name varchar(256) not null,
description varchar(256) not null,
price decimal(12) not null,
Foreign key(seller_id) references seller(seller_id),
Foreign key(cat_id) references prod_category(cat_id));

-- create a table INVENTORY
CREATE TABLE INVENTORY(
invent_id decimal(12) not null primary key,
seller_id decimal(12) not null,
prod_id decimal(12) not null,
cat_id decimal(12) not null,
units decimal(12) not null,
prod_condition varchar(70) not null,
Foreign key(seller_id) references seller(seller_id),
Foreign key(cat_id) references prod_category(cat_id),
Foreign key(prod_id) references products(prod_id));

-- create a table ORDERS
CREATE TABLE ORDERS(
order_id decimal(12) not null primary key,
cust_id decimal(12) not null,
prod_id decimal(12) not null,
seller_id decimal(12) not null,
Foreign key(seller_id) references seller(seller_id),
Foreign key(prod_id) references products(prod_id),
Foreign key(cust_id) references customers(cust_id));

-- create a table PACKAGE
CREATE TABLE PACKAGE(
package_id decimal(12) not null primary key,
order_id decimal(12) not null,
speed_id decimal(12) not null,
Foreign key(order_id) references orders(order_id),
Foreign key(speed_id) references speed(speed_id));

-- create a table NOTIFICATIONS
CREATE TABLE NOTIFICATIONS(
notifiication_id decimal(12) not null primary key,
cust_id decimal(12) not null,
package_id decimal(12) not null,
Foreign key(cust_id) references customers(cust_id),
Foreign key(package_id) references package(package_id));