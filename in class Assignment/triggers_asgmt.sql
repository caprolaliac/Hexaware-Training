-- triggers
/*
7) Create a trigger to updates the Stock (quantity) table whenever new order placed in orders tables
 
8) Create a trigger to that prevents deletion of a customer if they have existing orders.
 
9) Create Employee,Employee_Audit  insert some test data

	b) Create a Trigger that logs changes to the Employee Table into an Employee_Audit Table
 
*/

-- 7. 

select * from sales.orders
select * from production.stocks

create trigger t_update_quan on sales.orders
after insert as
begin
UPDATE production.stocks
SET quantity = s.quantity - oi.quantity
FROM production.stocks s
INNER JOIN sales.order_items oi
ON s.product_id = oi.product_id
INNER JOIN inserted i
ON oi.order_id = i.order_id
WHERE s.store_id = i.store_id
end

INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES (1, 1, '2023-10-01', '2023-10-05', NULL, 1, 1)

select * from production.stocks

--8. 

create trigger t_prevent_delete
on sales.customers
instead of delete
as
begin
if exists (select 1 from deleted d
join sales.orders o on d.customer_id = o.customer_id)
begin
print 'Cannot delete the customer'
end
else
begin
delete from sales.customers
where customer_id in (select customer_id from deleted)
end
end

select top 10 * from sales.customers order by customer_id
select top 10 * from sales.orders order by customer_id

delete from sales.customers where customer_id = 2


--9. 
drop TABLE Employee_Audit

CREATE TABLE Employee_Audit (
    audit_id INT IDENTITY (1, 1) PRIMARY KEY,
    employee_id INT NOT NULL,
    action VARCHAR(50) NOT NULL, 
    old_name VARCHAR(255),
    old_gender VARCHAR(10),
    old_dob DATE,
    old_dept_id INT,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO Employee (ID,emp_name, gender, dob, dept_id)
VALUES 
(1234,'Ram Charan', 'Male','1990-2-3', 1),
(2345,'Rjani', 'Female','1991-3-12', 2);

delete from employee where ID=1234

create trigger t_log_emp 
on employee
after insert, update, delete
as
begin
if exists (select * from inserted) 
begin
insert into employee_audit (employee_id, action, old_name, old_gender, old_dob, old_dept_id)
select ID, 'insert', null, null, null, null
from inserted;
end
if exists (select * from deleted) and exists (select * from inserted) 
begin
insert into employee_audit (employee_id, action, old_name, old_gender, old_dob, old_dept_id)
select ID, 'update', old.emp_name, old.gender, old.dob, old.dept_id
from deleted old;
end

if exists (select * from deleted) 
begin
insert into employee_audit (employee_id, action, old_name, old_gender, old_dob, old_dept_id)
select ID, 'delete', old.emp_name, old.gender, old.dob, old.dept_id
from deleted old;
end
end

SELECT * FROM Employee_Audit;
