-- Assignment: 2. Student Information System (SIS)

-- Create Database
CREATE DATABASE SIS
-- TASK 1
 /* 
Define the schema for the Students, Courses, Enrollments, Teacher, and Payments tables based
on the provided schema. Write SQL scripts to create the mentioned tables with appropriate data
types, constraints, and relationships.
a. Students
b. Courses
c. Enrollments
d. Teacher
e. Payments
*/

--students table
create table Students(
student_id int identity(1,1) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
date_of_birth date not null,
email varchar(150) unique not null,
phone_number varchar(20)
)

-- courses table
create table Courses (
course_id int identity(1,1) primary key,
course_name varchar(100) not null,
credits int not null,
)

-- teacher table
create table Teacher (
teacher_id int identity(1,1) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique not NULL
)

-- enrollments table
create table Enrollments (
enrollment_id int identity(1,1) primary key,
student_id int,
foreign key (student_id) references Students(student_id),
course_id int,
foreign key (course_id) references Courses(course_id),
enrollment_date date NOT NULL
)

--payments table
create table Payments (
payment_id int identity(1,1) primary key,
student_id int,
foreign key (student_id) references Students(student_id),
amount int not null,
payment_date date not null
)

/*
alter table Courses 
drop teacher_id int
*/
alter table Courses 
add teacher_id int

-- Create appropriate Primary Key and Foreign Key constraints for referential integrity.
alter table Courses 
add constraint FK_Courses_Teacher foreign key (teacher_id) references Teacher(teacher_id);

/*
Insert at least 10 sample records into each of the following tables.
i. Students
ii. Courses
iii. Enrollments
iv. Teacher
v. Payments
*/

-- inserting in students table

insert into Students values 
('Varun', 'G', '2003-05-03', 'varun.hex@gmail.com', '9999999999'),
('Karan', 'A', '2000-01-15', 'karan.a@xyz.com','9898989898'),
('Tony', 'S', '2001-03-22', 'Tony.s@xyz.com', '1234567890'),
('Thomas', 'S', '1999-07-10', 'ThomasS@email.com', '2345678901'),
('Victoria', 'B', '2002-11-05', 'VictoriaB@xyz.com', '3456789012'),
('David', 'Be', '2000-09-18', 'David.be@abc.com', '4567890123'),
('Rohit', 'K', '2001-05-30', 'Rohit.k@abc.com', '5678901234'),
('Krish', 'O', '1999-12-25', 'KrishO@email.com', '6789012345'),
('Ram', 'Si', '2002-02-14', 'RamSi@gg.com', '7890123456'),
('Joe', 'Mc', '2000-08-07', 'joeMc@gg.com', '8901234567')

select * from Students

-- inserting in teachers table
insert into Teacher values
('Raju', 'S', 'raju.s@email.com'),
('Brahmi', 'N', 'brahmi.n@email.com'),
('William', 'Keen', 'william.keen@email.com'),
('john', 'Mayer', 'john.mayer@email.com'),
('Louis', 'Cartier', 'louis.cart@email.com'),
('Gerald', 'Genta', 'gerald.g@email.com'),
('Robert', 'Brown', 'robert.brown@email.com'),
('Chris', 'Grey', 'chris.greyy@email.com'),
('James', 'Wilson', 'james.wilson@email.com'),
('William', 'Raid', 'will.raid@email.com')

select * from Teacher

-- inserting into courses table
insert into Courses values
('Introduction to Computer Science', 3, 1),
('Calculus', 4, 10),
('English', 3, 3),
('Software Engineering', 4, 4),
('History', 3, 5),
('Chemistry', 4, 1),
('Spanish', 3, 2),
('Environmental Science', 3, 3),
('Lean Startup Management', 3, 6),
('Research Analysis', 3, 5),
('Java', 3, 4),
('Python', 3, 7),
('Microprocessor Architecture', 4, 8),
('Game Science', 3, 9),
('Data Visualisation', 4, 10);

select * from Courses

insert into Enrollments values 
(1, 1, '2023-09-01'),
(1, 2, '2023-09-01'),
(2, 1, '2023-09-02'),
(2, 3, '2023-09-02'),
(3, 2, '2023-09-03'),
(3, 4, '2023-09-03'),
(4, 3, '2023-09-04'),
(4, 5, '2023-09-04'),
(5, 4, '2023-09-05'),
(5, 6, '2023-09-05'),
(6, 7, '2023-09-06'),
(7, 8, '2023-09-07'),
(8, 9, '2023-09-08'),
(9, 10, '2023-09-09'),
(10, 1, '2023-09-10')

select * from Enrollments

insert into Payments values 
(1, 1000, '2023-08-15'),
(2, 1200, '2023-08-16'),
(3, 950, '2023-08-17'),
(4, 1100, '2023-08-18'),
(5, 1050, '2023-08-19'),
(6, 600, '2023-08-20'),
(7, 800, '2023-08-21'),
(8, 700, '2023-08-22'),
(9, 650, '2023-08-23'),
(10, 500, '2023-08-24'),
(1, 500, '2023-09-15'),
(2, 600, '2023-09-16'),
(3, 475, '2023-09-17'),
(4, 550, '2023-09-18'),
(5, 525, '2023-09-19');

select * from Payments

-- TASK 2
/*
1. Write an SQL query to insert a new student into the "Students" table with the following details:
a. First Name: John
b. Last Name: Doe
c. Date of Birth: 1995-08-15
d. Email: john.doe@example.com
e. Phone Number: 1234567890
*/

insert into Students values 
('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

select * from Students
/*
2. Write an SQL query to enroll a student in a course. Choose an existing student and course and
insert a record into the "Enrollments" table with the enrollment date.
*/
insert into Enrollments (student_id, course_id, enrollment_date)
values (1003, 4, getdate());

select * from Enrollments

/*
3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and
modify their email address.
*/
select * from Teacher
update Teacher
set email = 'williamKeen123@gmail.com'
where teacher_id=3

/*
4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select
an enrollment record based on the student and course.
*/
select * from Enrollments
delete from Enrollments
where student_id=4 and course_id=5

/*
5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and
teacher from the respective tables.
*/
select * from Courses
update Courses
set teacher_id=9
where course_id=1

/*
6. Delete a specific student from the "Students" table and remove all their enrollment records
from the "Enrollments" table. Be sure to maintain referential integrity.
*/
select * from Enrollments

Alter table Enrollments
add constraint FK_Enrollments_Students
foreign key(student_id) references Students(student_id)
on delete cascade

delete from Enrollments 
where student_id = 1003;

select * from Enrollments
select * from Students

/*
7. Update the payment amount for a specific payment record in the "Payments" table. Choose any
payment record and modify the payment amount.
*/
select * from Payments
update Payments
set amount=999
where payment_id=11

-- Task 3
/*
1.Write an SQL query to calculate the total payments made by a specific student. 
You will need to join the "Payments" table with the "Students" table based on the student's ID
*/
select * from Payments
select * from Students

select s.student_id, s.first_name, s.last_name, SUM(p.amount) as [Total Payments]
from Students s
join Payments p on p.student_id=s.student_id
group by s.student_id, s.first_name, s.last_name
having s.student_id=1

/*
2.Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. 
Use a JOIN operation between the "Courses" table and the "Enrollments" table
*/

select * from Courses
select * from Enrollments

select c.course_id, c.course_name, count(e.student_id) as [Enrolled Students]
from Courses c
left join Enrollments e
on c.course_id=e.course_id
group by c.course_id, c.course_name

/*
3. Write an SQL query to find the names of students who have not enrolled in any course. 
Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments
*/

select s.student_id, s.first_name, s.last_name
from Students s 
left join Enrollments e
on s.student_id=e.student_id
where e.enrollment_id is null

/*
4.Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. 
Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables
*/
select * from Courses
select s.first_name, s.last_name, c.course_name
from Students s
join Enrollments e on e.student_id=s.student_id
join Courses c on c.course_id=e.course_id

/*
5.Create a query to list the names of teachers and the courses they are assigned to. 
Join the "Teacher" table with the "Courses" table
*/
select t.first_name,t.last_name,c.course_name
from Teacher t
join Courses c on c.teacher_id=t.teacher_id

/*
6.Retrieve a list of students and their enrollment dates for a specific course. 
You'll need to join the "Students" table with the "Enrollments" and "Courses" tables
*/

select s.first_name, s.last_name, c.course_name, e.enrollment_date
from Students s
join Enrollments e on e.student_id=s.student_id
join Courses c on c.course_id=e.course_id

select s.student_id, s.first_name, s.last_name, c.course_name, e.enrollment_date
from Students s
join Enrollments e on e.student_id=s.student_id
join Courses c on c.course_id=e.course_id
where c.course_id=9

/*
7.Find the names of students who have not made any payments. 
Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records
*/
select * from Payments

select s.student_id,s.first_name, s.last_name
from Students s
left join Payments p on p.student_id=s.student_id
where p.payment_id is null

/*
8.Write a query to identify courses that have no enrollments. 
You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and 
filter for courses with NULL enrollment records
*/

select c.course_id, c.course_name
from Courses c
left join Enrollments e on e.course_id=c.course_id
where e.enrollment_id is null

/*
9.Identify students who are enrolled in more than one course. 
Use a self-join on the "Enrollments" table to find students with multiple enrollment records
*/

select s.student_id, s.first_name, s.last_name,count(e1.enrollment_id) as [# of Enrollments]
from Students s
join Enrollments e1 on s.student_id=e1.student_id
join Enrollments e2 on e1.student_id = e2.student_id
group by s.student_id, s.first_name, s.last_name
having count(e1.enrollment_id)>1

/*
10.Find teachers who are not assigned to any courses. 
Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.
*/

select t.teacher_id, t.first_name, t.last_name
from Teacher t
left join Courses c on c.teacher_id=t.teacher_id
where c.course_id is null

-- Task 4
/*
1. Write an SQL query to calculate the average number of students enrolled in each course. 
Use aggregate functions and subqueries to achieve this.
*/
select * from Enrollments

select avg([# of students]) as [Avg Students]
from (select course_id,count(student_id) as [# of students]
from Enrollments
group by course_id) as [average per course]

/* 
2. Identify the student(s) who made the highest payment. 
Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount
*/
select student_id, first_name, last_name
from Students where student_id in(
select top 1 student_id
from Payments p
group by student_id
order by sum(amount) desc)

/*
3. Retrieve a list of courses with the highest number of enrollments. 
Use subqueries to find the course(s) with the maximum enrollment count.
*/
select course_id, course_name
from Courses
where course_id in
(select top 1 count(student_id) as [student count]
from Enrollments
group by course_id
order by COUNT(student_id) DESC)

/*
4. Calculate the total payments made to courses taught by each teacher. 
Use subqueries to sum payments for each teacher's courses
*/
--joining Enrollments and Payments
select e.course_id, sum(p.amount) as [Total Payment]
from Payments p
JOIN Enrollments e on p.student_id = e.student_id
group by e.course_id

-- joining above table with (teacher+courses)

select t.first_name, t.last_name, sum(tot_p.[Total Payment]) as [Total Payments]
from Teacher t
join Courses c on t.teacher_id = c.teacher_id
join (select e.course_id, sum(p.amount) as [Total Payment]
from Payments p
JOIN Enrollments e on p.student_id = e.student_id
group by e.course_id) as tot_p ON c.course_id = tot_p.course_id
group by t.first_name, t.last_name

/*
5. Identify students who are enrolled in all available courses. 
Use subqueries to compare a student's enrollments with the total number of courses
*/

declare @coursecount int
select @coursecount = count(course_id) from Courses

select count(course_id) 
from Courses
select student_id, first_name, last_name
from Students s
where (select count(distinct course_id)
from Enrollments e
where e.student_id=s.student_id) = @coursecount

/*
6. Retrieve the names of teachers who have not been assigned to any courses. 
Use subqueries to find teachers with no course assignments.
*/
select teacher_id, first_name, last_name
from Teacher
where teacher_id not in (
select distinct teacher_id
from Courses
where teacher_id is not null
)

/*
7. Calculate the average age of all students.
Use subqueries to calculate the age of each student based on their date of birth.
*/

select avg([Students Age]) as [Students Avg Age] from(

select datediff(year,date_of_birth,getdate()) as [Students Age] from Students
) s


/*
8. Identify courses with no enrollments. Use subqueries to find courses without enrollment records.
*/

select course_id, course_name
from Courses
where course_id not in (
select distinct course_id
from Enrollments
)

/*
9. Calculate the total payments made by each student for each course they are enrolled in. 
Use subqueries and aggregate functions to sum payments.
*/
select (select first_name from Students where student_id = e.student_id) as first_name,
(select last_name from Students where student_id = e.student_id) as last_name,
(select course_name from Courses where course_id = e.course_id) as course_name,
(select sum(amount)
from Payments 
where student_id = e.student_id) as total_payment
from Enrollments e

/*
10. Identify students who have made more than one payment. 
Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.
*/
select * from Payments
select student_id, first_name, last_name
from Students
where student_id in (
select student_id
from Payments
group by student_id
having count(payment_id) > 1
)

/*
11. Write an SQL query to calculate the total payments made by each student. 
Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
*/
select student_id, first_name, last_name, (select sum(amount) 
from Payments p 
where p.student_id = s.student_id) as total_payments
from Students s

/*
12. Retrieve a list of course names along with the count of students enrolled in each course. 
Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments
*/
--using sub-queries
select c.course_id, c.course_name,(select count(e.enrollment_id) 
from Enrollments e 
where e.course_id = c.course_id) as [# of Students]
from Courses c

--using joins
select c.course_id, c.course_name, COUNT(e.enrollment_id) AS [# of students]
from Courses c
left join Enrollments e 
on c.course_id = e.course_id
group by c.course_id, c.course_name
order by c.course_id


/*
13. Calculate the average payment amount made by students. 
Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average
*/
select avg(amount) as [Avg. Payment]
from (select amount from Payments) as all_payments
