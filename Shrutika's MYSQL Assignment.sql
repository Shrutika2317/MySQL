
show databases;
use classicmodels;

-- Q1. SELECT clause with WHERE, AND, DISTINCT, Wild Card (LIKE)
-- a. Fetch the employee number, first name and last name of those employees who are working as Sales Rep reporting to employee with employeenumber 1102 

-- Solution:- 

show tables;
select * from employees;
select employeenumber,firstname,lastname from employees where jobtitle ='Sales Rep' and reportsto = 1102;


-- b.	Show the unique productline values containing the word cars at the end from the products table.

-- Solution :-

select * from products;
select distinct productline from products where productline like '%cars';


-- Q2. CASE STATEMENTS for Segmentation

-- a. Using a CASE statement, segment customers into three categories based on their country:(Refer Customers table)
                       --  "North America" for customers from USA or Canada
                        -- "Europe" for customers from UK, France, or Germany
                       -- "Other" for all remaining countries
     -- Select the customerNumber, customerName, and the assigned region as "CustomerSegment".

-- Solution :-
select * from customers;
select customernumber,customername,
CASE
WHEN country="usa" or "canada" THEN "North America"
WHEN country="uk" or "france" or "germany" THEN "Europe"
else "Others"
END as Customer_Segment from customers;


-- Q3. Group By with Aggregation functions and Having clause, Date and Time functions
-- a.Using the OrderDetails table, identify the top 10 products (by productCode) with the highest total order quantity across all orders.

-- Solution :-

select * from orderdetails;
select  productcode,SUM(quantityordered) AS Total_Ordered FROM orderdetails group by productcode order by total_ordered desc limit 10;

-- b.	Company wants to analyse payment frequency by month. Extract the month name from the payment date to count the total number of payments for each month and include only those months with a payment count exceeding 20. Sort the results by total number of payments in descending order.  
  
-- Solution :-
select * from payments;
select date_format(paymentdate,'%M') as Payment_Month,count(customernumber) as num_payments from payments
group by payment_month having num_payments>20 order by num_payments desc;

-- Q4. CONSTRAINTS: Primary, key, foreign key, Unique, check, not null, default
-- Create a new database named and Customers_Orders and add the following tables 

-- Solution :-

create database Customers_Orders;
use customers_orders;
create table Customers (customer_id integer primary key auto_increment,
first_name varchar(50)not null,
last_name varchar(50)not null,
email varchar(255) unique,
phone_number varchar(20));

-- b.	Create a table named Orders to store information about customer orders. Include the following columns:

-- Solution :-

create table orders(order_id int primary key auto_increment,
customer_id int references customers(customer_id),order_date date,total_amount decimal(10,2) check (total_amount>=0));

-- Q5. JOINS
-- a. List the top 5 countries (by order count) that Classic Models ships to. (Use the Customers and Orders tables)

-- Solution :-
select * from customers limit 10;
select * from orders limit 10;
select customers.country,count(orders.customernumber) as order_count from orders 
INNER JOIN customers on orders.customernumber=customers.customernumber 
group by customers.country order by order_count desc limit 5;

-- Q6. SELF JOIN
-- a. Create a table project with below fields.
-- Solution :-

create table projects(EmployeeID int primary key auto_increment,FullName varchar(50) NOT NULL,Gender ENUM("Male","Female"),ManagerID int);
insert into projects values(1,"Pranaya","Male",3),
(2,"Priyanka","Female",1),
(3,"Pretty","Female",Null),
(4,"Anurag","Male",1),
(5,"Sambit","Male",1),
(6,"Rajesh","Male",3),
(7,"Hina","Female",3);
select * from projects;
select a.fullname as "Manager Name",e.fullname as "Emp Name" from projects e inner join projects a on e.employeeid=a.managerid;

-- Q7. DDL Commands: Create, Alter, Rename
-- a. Create table facility. Add the below fields into it.

-- Solution :-

drop table facility;
create table facility(Facility_ID int, Name varchar(100),State varchar(100),Country varchar(100));
alter table facility modify facility_id int primary key auto_increment;
alter table facility add City varchar(100) not null after name;
desc facility;

-- Q8. Views in SQL
-- a. Create a view named product_category_sales that provides insights into sales performance by product category

-- Solution:- 

create view product_category_sales as
select products.productline,sum(orderdetails.quantityordered*orderdetails.priceeach) as Total_Sales,count(distinct orders.ordernumber) as Number_of_Orders
 from ((orderdetails inner join products on orderdetails.productcode=products.productcode) 
 inner join orders on orderdetails.ordernumber=orders.ordernumber) 
 group by products.productline;

select * from product_category_sales;

-- Q9. Stored Procedures in SQL with parameters

-- Solution :-
DELIMITER //

CREATE PROCEDURE `Get_country_payments ` (YEAR INT,COUNTRY VARCHAR(255))
BEGIN
select year(payments.paymentdate) as YEAR,customers.country as COUNTRY,CONCAT(FORMAT(SUM(payments.amount)/1000,0),'K') as TOTAL_AMOUNT
from payments inner join customers on payments.customernumber=customers.customernumber
where YEAR(payments.paymentdate)=YEAR AND customers.country=Country
group by Year(payments.paymentdate),customers.country;
END

DELIMITER //

call Get_country_payments(2023,'France');


-- Q10. Window functions - Rank, dense_rank, lead and lag
-- a) Using customers and orders tables, rank the customers based on their order frequency

-- Solution:-

select customers.customername,count(orders.customernumber) as Order_count,dense_rank() over (order by count(orders.customernumber) desc) as Order_Frequency_Rnk
from customers inner join orders on customers.customernumber=orders.customernumber
group by orders.customernumber
order by Order_Frequency_Rnk;

-- b) Calculate year wise, month name wise count of orders and year over year (YoY) percentage change. Format the YoY values in no decimals and show in % sign.

-- Solution :-

WITH YearMonthOrderCounts AS (
    SELECT YEAR(orderDate) AS `Year`,MONTHNAME(orderDate) AS `Month`,
        MONTH(orderDate) AS `MonthNumber`,COUNT(orderNumber) AS OrderCount
    FROM orders
    GROUP BY YEAR(orderDate), MONTHNAME(orderDate), MONTH(orderDate)
),
YoYCalculation AS (
    SELECT `Year`,`Month`,`MonthNumber`,OrderCount,LAG(OrderCount, 1) OVER (ORDER BY `Year`) AS PreviousYearOrderCount
    FROM YearMonthOrderCounts
)
SELECT `Year`,`Month`,OrderCount,
    CASE 
        WHEN PreviousYearOrderCount IS NULL THEN 'N/A'
        ELSE CONCAT(ROUND((OrderCount - PreviousYearOrderCount) * 100.0 / PreviousYearOrderCount, 0), '%')
    END AS YoY_Change
FROM YoYCalculation
ORDER BY `Year`, `MonthNumber`;

-- Q11.Subqueries and their applications

-- a. Find out how many product lines are there for which the buy price value is greater than the average of buy price value. Show the output as product line and its count.

-- Solution :-

select * from products;
select productline,count(productcode) as Total_Count from products where buyprice >(select avg(buyprice) as Average_Price from products) 
group by productline order by count(productcode) desc;

-- Q12. ERROR HANDLING in SQL

-- Solution :-
DELIMITER //
CREATE PROCEDURE `Emp_EH` (Emp_ID int,Emp_Name varchar(30),Email_Address varchar(30))
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback any changes made if an error occurs
        ROLLBACK;
        -- Show the error message
        SELECT 'Error occurred' AS ErrorMessage;
    END;

    -- Start a transaction
    START TRANSACTION;

    -- Insert the values into the Emp_EH table
    INSERT INTO Emp_EH (Emp_ID, Emp_Name, Email_Address)
    VALUES (Emp_ID, Emp_Name, Email_Address);

    -- Commit the transaction
    COMMIT;
END    //
DELIMITER ;


-- Q13. TRIGGERS
-- Create the table Emp_BIT. Add below fields in it.

-- Solution :-

create table Emp_BIT(Name varchar(30),Occupation varchar(30),Working_date date,Working_hours time);
Insert into Emp_BIT values
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  
select * from Emp_BIT;

DELIMITER //

CREATE TRIGGER Before_Insert_Emp_BIT
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = ABS(NEW.Working_hours);
    END IF;
END //

DELIMITER ;
insert into Emp_BIT values ('Shrutika', 'Data Analyst', '2024-11-10', -2);
select * from Emp_BIT;









