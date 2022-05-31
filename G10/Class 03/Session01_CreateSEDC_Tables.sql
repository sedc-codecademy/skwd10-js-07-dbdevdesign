
CREATE TABLE BusinessEntity
(
	Id INTEGER PRIMARY KEY,
	Name varchar(100),
	Region varchar(1000) null,
	ZipCode char(4) null,
	Size varchar(10) null
)

select * from BusinessEntity

CREATE TABLE Employee
(
	Id integer PRIMARY KEY not null,
	FirstName varchar(100) not null,
	LastName varchar(100) not null,
	DateOfBirth date null,
	Gender nchar(1) null,
	HireDate date null,
	NationalIdNumber varchar(20) null
);

Select * from Employee

Create table Product
(
	Id serial primary key not null,
	Code varchar(50),
	Name varchar(100),
	Description varchar(5000),
	Weight float(2),
	Price float(2),
	Cost float(2)
)

select * from Product

drop table Customer
CREATE TABLE Customer
(
	Id serial primary key,
	Name varchar(100),
	AccountNumber varchar(50),
	City varchar(50),
	RegionName varchar(50),
	PhoneNumber varchar(20),
	isActive boolean
)

select * from Customer

create table "Order"
(
	id serial primary key,
	Orderdate date,
	Status smallint,
	BusinessEntityId integer,
	CustomerId integer,
	EmployeeId integer,
	TotalPrice float(2),
	Comment varchar(500)
);

select * from "Order"

create table orderdetails 
(
	id serial primary key,
	OrderId integer,
	ProductId integer,
	Quantity Integer,
	Price float(2)
)

select * from orderdetails


