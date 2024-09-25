-- Case Study: Ecommerce Application
/*
Create following tables in SQL Schema with appropriate class and write the unit test case for the Ecommerce Application
*/

-- customers table
create table customers (
customer_id int primary key identity(1,1),
name varchar(50) not null,
email varchar(100) not null unique,
password varchar(100) not null
)

-- products table
create table products (
product_id int primary key identity,
name varchar(50) not null,
price decimal(10,2) not null,
description text,
stockQuantity int not null
)

-- cart table
create table cart (
cart_id int primary key identity,
customer_id int not null,
product_id int not null,
quantity int not null default 0 check (quantity > 0),
foreign key (customer_id) references customers(customer_id) on delete cascade,
foreign key (product_id) references products(product_id) on delete cascade
)

-- orders table
create table orders (
order_id int primary key identity,
customer_id int not null,
order_date datetime not null default getdate(),
total_price decimal(10,2) not null default 0 check (total_price >= 0),
shipping_address text not null,
foreign key (customer_id) references customers(customer_id) on delete cascade
)

-- order_items table
create table order_items (
order_item_id int primary key identity(1,1),
order_id int not null,
product_id int not null,
quantity int not null default 0 check(quantity > 0),
foreign key (order_id) references orders(order_id) on delete cascade,
foreign key (product_id) references products(product_id)
)

insert into customers values
('John Doe', 'john@xyz.com', 'JDoe@123'),
('Varun G', 'varun@xyz.com', 'VarunG@123'),
('Raj Kumar', 'raj@xyz.com', 'RajK@123')

insert into products values
('Smartphone', 40000.00, 'Fastest 5-G Smartphone', 50),
('Laptop', 129990.00, 'Gaming laptop', 30),
('Headphones', 10000.00, 'Noise cancelling headphones', 10),
('Tablet', 15500.00, '10-inch tablet', 40),
('Smartwatch', 2999.00, 'Fitness smartwatch', 100),
('Jeans', 1999.00, 'Blue Denim', 250)

insert into cart (customer_id, product_id, quantity) values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1)

INSERT INTO orders (customer_id, total_price, shipping_address) VALUES
(1, 60000.00, 'D-1234, Mumbai, India'),
(2, 129990.00, 'd-1434, DL 91, Delhi, India'),
(3, 15500.00, 'VIT, Vellore, Tami Nadu, India')

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1)

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1)
