-------7
SELECT * FROM Employee
WHERE 
FirstName = 'Goran'


SELECT * FROM Employee
WHERE 
Employee.lastname like'S%';

SELECT * FROM Employee
WHERE 
Employee.dateofbirth >'13.01.1980'


SELECT * FROM Employee
WHERE  
Employee.gender = 'M'



SELECT * FROM Employee
WHERE 
Employee.hiredate >='01.06.2010'
and Employee.hiredate <'01.07.2010'



SELECT * FROM Employee
WHERE 
Employee.lastname like'M%' 
and Employee.hiredate >='01.01.2010'
and Employee.hiredate <'01.02.2013'


--------------9-
SELECT * FROM Employee
WHERE 
FirstName = 'Aleksandar'
order by Employee.lastname


SELECT * FROM Employee
order by Employee.firstname

SELECT * FROM Employee
where
Employee.gender = 'M'
order by Employee.hiredate desc


 

----------------14---------------
select businessentity."name" from businessentity 
union all
select customer."name" from customer  


select businessentity."region" from businessentity 
union all
select customer."regionname" from customer  


select businessentity."region" from businessentity 
INTERSECT
select customer."regionname" from customer  

---------------16,17,18
--drop table Customer1
CREATE TABLE Customer1 ( 
Id serial primary key not null,	
Name TEXT, 
Address TEXT,
PhoneNumber Text UNIQUE,
Age INTEGER CHECK(Age > 18)
);


-----------------19  compositen kluc
--drop table customer_bussinesssentiry
create table customer_bussinesssentiry(
CustomerID int not null,
BusinessEntityID int not null,
 primary key (CustomerID, BusinessEntityID)
)

----20
CREATE TABLE Company (
CompanyId INTEGER PRIMARY KEY, 
Name TEXT,
Address TEXT);

CREATE TABLE Employee2 ( 
Name TEXT, 
Address TEXT,
Age INTEGER,
CompanyId INTEGER references Company(CompanyId));


-----------21
--drop table product2
CREATE TABLE Product2 ( 
Id serial primary key not null,	
Price float(2),
Cost float(2) CHECK(2*Price >= Cost))


ALTER TABLE public."Order"
  ADD CONSTRAINT "Order_fk" FOREIGN KEY (customerid)
    REFERENCES public.customer(id)
    --ON DELETE NO ACTION
    --ON UPDATE NO ACTION
   

---------33
--drop table table2
create table table1 (
id1 int primary key
)
insert into table1(id1)values (1)
insert into table1(id1)values (2)
insert into table1(id1)values (3)

create table table2 (
id2 int primary key
)

insert into table2(id2)values (3);
insert into table2(id2)values (4);
insert into table2(id2)values (5);


select * from table1 t1 
inner join table2 t2 on (t1.id1=t2.id2)

select * from table1 t1 
left join table2 t2 on (t1.id1=t2.id2)

------34
select c.Name as CustomerName, p.Name as ProductName
from Customer c
cross join Product p


select DISTINCT b.Name
from "Order" o
inner join BusinessEntity b on b.Id = o.BusinessEntityId


select DISTINCT b.Name
from BusinessEntity b
left join "Order" o on b.Id = o.BusinessEntityId
where o.BusinessEntityId is null

--4
select c.*
from "Order" o
right join Customer c on o.CustomerId = c.Id
where o.CustomerId is null

--4
select c.*
from Customer c 
left join "Order" o on o.CustomerId = c.Id
where o.CustomerId is null
