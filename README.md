**"Selling on Amazon" Project**

Welcome to the "Selling on Amazon" project! This project is part of a course where I had the opportunity to design, implement, and utilize my own database, all within a single term. The main goal of this project was to create a fully functional database that supports the selling process on Amazon. Through this project, I gained hands-on experience in database design, implementation, and testing, while also understanding the core data, requirements, and use cases specific to the "Selling on Amazon" domain.

Structural business rules are a useful tool to frame and guide your design; they indicate the entities, relationships, optionalities, and pluralities of any Project design.

**Entities that are critical to the design of this project are**

•	Seller
•	Customers
•	Products
•	Product Category
•	Inventory
•	Orders
•	Package/Shipment
•	Speed
•	Notifications

**Structural Business Rules**

1.	A Customer can Order one or more Products

2.	A Customer can create one and one account under one username.

3.	Every Order must be placed by only one Customer.

4.	A Product can be ordered one or more times.

5.	A Product can never be ordered by any of the Customers.

6.	A Product belongs to one and one Product Category.

7.	A Product Category can have multiple Products associated with it.

8.	A Seller can sell multiple Products.

9.	Each Package must be delivered by one Seller only.

10.	An Order can have one or more Products.

11.	All the Products should be listed in the Inventory.

12.	An inventory can have one or more Products.

13.	The number of Products should be updated every time a new product is added by the Seller, or any Products is Ordered by any Customer.

14.	 Every Package should be notified to the Customer.

15.	A Seller can create a new listing or reuse the already existing Product listing.

**Conceptual ER Diagram**
![image](https://github.com/parulbaderia/MyProjects/assets/137832452/e2525c13-01b3-4deb-acbc-b944184bd6f5)


**Logical ER Diagram**

![image](https://github.com/parulbaderia/MyProjects/assets/137832452/936877e9-54f6-4a4a-9c55-7b47156a8128)










