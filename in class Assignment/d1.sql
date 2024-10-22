/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/
-- create schemas

create database Bikestore

CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go

-- create tables
CREATE TABLE production.categories (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.brands (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);



--- assignment

/*
You need to create a stored procedure that retrieves a list of all customers who have purchased a specific product.

consider below tables Customers, Orders,Order_items and Products

Create a stored procedure,it should return a list of all customers who have purchased the specified product, 

including customer details like CustomerID, CustomerName, and PurchaseDate.

The procedure should take a ProductID as an input parameter.
 
*/

select * from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
where oi.product_id =7

create procedure getCfromP 
@productId int as
begin
select c.customer_id,c.first_name,c.last_name,o.order_date from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
where oi.product_id = @productId
end

exec getCfromP @productId=7


--assignment
/*
3 ) Create a user Defined function to calculate the TotalPrice based on productid and Quantity Products Table
*/


create function TotalPrice(@product_id INT, @quantity INT)
returns int
as
begin

return  (select p.list_price * @quantity
from production.products p
where p.product_id = @product_id)
end

select dbo.TotalPrice(1,3)

/*
4) create a function that returns all orders for a specific customer, including details such as 
OrderID, OrderDate, and the total amount of each order.
*/

create function orderDetails(@customer_id int)
returns @TempTable table(OrderId int,OrderDate date, TotalAmount int)
as
begin
insert into @TempTable 
select o.order_id,o.order_date, sum(oi.quantity*oi.list_price*(1 - oi.discount / 100.0)) as totalamount
from sales.orders o
join sales.order_items oi 
on o.order_id = oi.order_id
where o.customer_id = @customer_id
group by o.order_id, o.order_date
return
end

select * from orderDetails(1);

/*
5. create a Multistatement table valued function that calculates the total sales for each product, considering quantity and price.
 
6)create a  multi-statement table-valued function that lists all customers along with the total amount they have spent on orders.

*/

--5

create function totalSales()
returns @TempTable table (ProductID int, TotalSales int)
as
begin
insert into @TempTable
select p.product_id, sum(oi.quantity * p.list_price) as TotalSales
from production.products p
join sales.order_items oi on p.product_id=oi.product_id
group by p.product_id
return
end

select * from  totalSales()

--6

create function moneySpent()
returns @TempTable table ( CustomerID int,TotalSpent int )
as
begin
insert into @TempTable
select c.customer_id,sum(oi.quantity*oi.list_price*(1 - oi.discount / 100.0)) as moneySpent
from sales.customers c
join sales.orders o on o.customer_id=c.customer_id 
join sales.order_items oi on o.order_id = oi.order_id
group by c.customer_id
return
end

select * from moneySpent()

---------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

/*
CREATE TABLE Department with the below columns
  ID,Name
populate with test data
 
 
CREATE TABLE Employee with the below columns
  ID,Name,Gender,DOB,DeptId
populate with test data
 
a) Create a procedure to update the Employee details in the Employee table based on the Employee id.
b) Create a Procedure to get the employee information by passing the employee gender and department id from the Employee table
c) Create a Procedure to get the Count of Employee based on Gender(input)
*/

create database asgmt

create table department
(
ID int primary key,
dept_name varchar(100)
)

insert into department values
(1,'IT'),
(2,'HR'),
(3,'Analytics'),
(4,'Sales'),
(5,'Marketing')

select * from department

CREATE TABLE employee
(
ID int primary key,
emp_name VARCHAR(100),
gender varchar(15),
dob date,
dept_id int,
foreign key (dept_id) REFERENCES department(ID)
)

insert into Employee VALUES
(1, 'Amit Shah', 'Male', '1990-05-01', 1),
(2, 'Raja Kumari', 'Female', '1992-08-12', 2),
(3, 'Rahul Gandhi', 'Male', '1988-03-22', 3),
(4, 'Priyanka Gandhi', 'Female', '1995-11-30', 4),
(5, 'Narendra Modi', 'Male', '1985-07-15', 5);

-- a.

create proc update_emp_details
@emp_id int,
@emp_name varchar(100),
@emp_gender char(1),
@emp_dob date,
@emp_dept_id int
as
begin
update employee
set emp_name = @emp_name, gender = @emp_gender, dob = @emp_dob, dept_id = @emp_dept_id
where id = @emp_id
end


alter procedure update_emp_details
@emp_id int,
@emp_name varchar(100),
@emp_gender char(15),
@emp_dob date,
@emp_dept_id int
as
begin
update employee
set emp_name = @emp_name, gender = @emp_gender, dob = @emp_dob, dept_id = @emp_dept_id
where id = @emp_id
end


select * from employee

exec update_emp_details @emp_id=2,@emp_name='Varun', @emp_gender='Male', @emp_dob='2003-03-05', @emp_dept_id='3'

select * from employee

--b.

create proc get_emp_details
@emp_gender varchar(15),
@emp_dept_id int
as
begin
select * from employee
where gender = @emp_gender and dept_id = @emp_dept_id
end

exec get_emp_details @emp_gender='Male', @emp_dept_id=3

--c.

create proc emp_count_gender
@emp_gender varchar(15)
as
begin
select count(*) from employee
where gender=@emp_gender
end

alter proc emp_count_gender
@emp_gender varchar(15)
as
begin
select count(*)  as emp_count from employee
where gender=@emp_gender
end

exec emp_count_gender @emp_gender='Male'
exec emp_count_gender @emp_gender='Female'


-- Table Valued Function
-- inline table valued function --> contains single select statement

create function GetEmployeeByID(@empID int)
returns table
as 
return (Select * from dbo.Employee where ID = @empID)

select * from GetEmployeeByID(4)

create function GetEmployees()
returns table
as 
return (Select * from dbo.Employee)

select * from GetEmployees()

update GetEmployees() set dob = '2003-05-19' where ID = 4

-- multi statement table valued func -- cannot update cause it is selecting data from temp table
create function GetEmployeewithTheirDepartments()
returns @TempTable table
(EmployeeID int, EmployeeName varchar(max), DepartmentID int, DepartmentName varchar(max))
as
begin
	insert into @TempTable 
	select e.ID,e.emp_name,e.dept_id,d.dept_name
	from dbo.Employee e
	join
	dbo.Department d
	on e.dept_id = d.ID
	return 
end

select * from GetEmployeewithTheirDepartments()
