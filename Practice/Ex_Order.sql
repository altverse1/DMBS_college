use Ex_Order;

-- SALESMAN	(Salesman_id*, Name, City, Commission)
-- CUSTOMER	(Customer_id*, Cust_Name, City, Grade)
-- ORDERS	(Ord_No*, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)

CREATE TABLE salesman
(
	salesman_id		VARCHAR(5),
	name			VARCHAR(15),
	city			VARCHAR(25),
	commission		INT,
	PRIMARY KEY(salesman_id)
);

CREATE TABLE customer
(
	customer_id		VARCHAR(5),
	cust_name		VARCHAR(15),
	city			VARCHAR(25),
	grade			INT,
	PRIMARY KEY(customer_id)
);

CREATE TABLE orders
(
	ord_no			VARCHAR(5),
	purchase_amt	INT,
	ord_date		DATE,
	customer_id		VARCHAR(5),
	salesman_id		VARCHAR(5),
	PRIMARY KEY(ord_no),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
	FOREIGN KEY(salesman_id) REFERENCES salesman(salesman_id) ON DELETE CASCADE
);



-- SALESMAN	(Salesman_id*, Name, City, Commission)
INSERT INTO salesman VALUES ('1000', 'Meg', 'Manglore', 3),('1001', 'Greg', 'Udupi', 1),('1002', 'Aman', 'Mysore', 2)

-- CUSTOMER	(Customer_id*, Cust_Name, City, Grade)
INSERT INTO customer VALUES ('111', 'Apurv', 'Banglore', 5), ('112', 'Lemon', 'Banglore', 6), ('113', 'Lake', 'Chennai', 2), 
('114', 'Shin', 'Manglore', 9), ('115', 'Shoe', 'Udupi', 8), ('116', 'Yae', 'Delhi', 1), ('117','Taka', 'Mumbai', '7');

-- ORDERS	(Ord_No*, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)
INSERT INTO orders VALUES ('111',10,'2022-07-01','111','1000'),
('112',5,'2022-07-01','114','1000'),
('113',3,'2022-07-02','115','1001'),
('114',20,'2022-07-03','116','1002'),
('115',1,'2022-07-04','113','1001'),
('116',10,'2022-07-05','112','1000'),
('117',12,'2022-07-05','112','1000'),
('118',11,'2022-07-05','112','1000'),
('119',7,'2022-07-07','117','1002'),
('120',5,'2022-07-08','116','1002'),
('121',1,'2022-07-09','113','1001'),
('122',17,'2022-07-10','117','1002'),
('123',1,'2022-07-11','111','1002');


SELECT * FROM salesman;
SELECT * FROM customer;
SELECT * FROM orders;


-- Q. Count customers with grades above Banglore's Avg.
SELECT COUNT(DISTINCT c.customer_id) as count
from customer c
WHERE c.grade>
(SELECT AVG(cb.grade)
FROM customer cb
WHERE cb.city = 'Banglore'
);

-- Q. Find the name and numbers of all salesman who had more than one customer
SELECT s.name, s.salesman_id
FROM salesman s, orders o
WHERE s.salesman_id = o.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(DISTINCT customer_id)>1

-- Q. List all Salesman and indicate those who have and dont have customers in their cities
SELECT s.name, s.salesman_id, 'yes_exists' as same_city
FROM salesman s
WHERE city IN
(SELECT city 
FROM customer c
WHERE c.city=s.city)

UNION -- Works like an and operation. Do this if this and Do this if this.

SELECT s.name, s.salesman_id, 'not_exist' as same_city
FROM salesman s
WHERE city NOT IN
(SELECT city 
FROM customer c
WHERE c.city=s.city);

-- Q. Create view that finds the salesman who has the customer with the highest order of a day.
CREATE VIEW high_cus_ord_sale AS
SELECT s.salesman_id, o.ord_date, o.purchase_amt 
FROM salesman s, orders o
WHERE s.salesman_id = o.salesman_id AND
o.purchase_amt =
(
	SELECT max(purchase_amt)
	FROM orders
	WHERE o.ord_date = ord_date
)
SELECT * FROM high_cus_ord_sale
ORDER BY ord_date;

-- Q. Demonstrate the delete operation by removing salesman with id 1000. All his orders must delete.
DELETE 
FROM salesman 
WHERE salesman_id='1000';  

