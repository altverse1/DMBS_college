USE orderdb_ai012;

-- SALESMAN(Salesman_id*, Name, City, Comission)
-- CUSTOMER(Customer_id*, Cust_Name, City, Grade)
-- ORDERS(Ord_No*, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)

create table salesman
(
	salesman_id varchar(5),
	name varchar(15),
	city varchar(15),
	commission int,
	primary key(salesman_id)
);

create table customer
(
	customer_id varchar(5),
	cust_name varchar(15),
	city varchar(15),
	grade int, 
	primary key(customer_id),
);

create table orders
(
	ord_no varchar(5),
	purchase_amt int,
	ord_date date,
	customer_id varchar(5),
	salesman_id varchar(5),
	primary key(ord_no),
	foreign key(customer_id) references customer(customer_id) on delete cascade,
	foreign key(salesman_id) references salesman(salesman_id) on delete cascade
);


Insert into salesman values ('1','Guru','Manglore',5),('2','Ravi','Puttur',3),('3','Girish','Banglore',3);
Insert into customer values ('11','Srikanth','Puttur',4),('12','Sandeep','Manglore',2),('13','Uday','Puttur',3),('14','Mahesh','Sullia',2),('15','Shivaram','Puttur',2),('16','Shyam','Manglore',5);
Insert into orders values ('111',2500,'2017-JUL-11','11','2'), ('112',1999,'2017-JUL-09','12','1'),('113',999,'2017-JUL-12','13','2'),('114',9999,'2017-JUL-12','14','3'),('115',7999,'2017-JUL-11','15','2'),('116',1099,'2017-JUL-09','16','2');


select * from salesman;
select * from customer;
select * from orders;


-- 1.Count the customers with grades above Puttur's average
select count(*) as count from customer where grade>(select avg(grade)from customer where city='Puttur');

-- 2.Find the name and numbers of all salesman  who had more than one customer.
select s.name, s.salesman_id from salesman s, orders o where s.salesman_id=o.salesman_id group by s.salesman_id, s.name having count(o.customer_id)>1;

-- 3.List all the salesman and indicate those who have and don't have customers in their cities (Use UNION operation)
select name,'exists' as same_city
from salesman s
where city in 
	(select city
	from customer c, orders o
	where s.salesman_id=o.salesman_id and o.customer_id=c.customer_id)
union
select name,'non exists' as same_city
from salesman s where
city not in 
	(select city
	from customer c, orders o
	where s.salesman_id=o.salesman_id and o.customer_id=c.customer_id);

-- 4.Create a view that finds the salesman who has the customer with the highest order of a day. 
create view highest_order as 
select s.salesman_id,s.name, o.purchase_amt, o.ord_date from salesman s, orders o where s.salesman_id = o.salesman_id;
--execute these seperately
select name, ord_date
from highest_order h where purchase_amt=
(select max(purchase_amt) from highest_order where h.ord_date = ord_date);

-- 5.Demonstrate the delete operation bu removing salesman with id 1000. All his orders must also be deleted 
delete from salesman where salesman_id = 3


-- 6.Retrieve salesman details along with count of orders, totoal purchase amount of the orders assigned to him and comission earned by him
select s.salesman_id, s.name, s.city, count(*) as counts, sum(o.purchase_amt) as totalamt
from salesman s, orders o where s.salesman_id=o.salesman_id
group by s.salesman_id, s.name, s.city, s.commission;
