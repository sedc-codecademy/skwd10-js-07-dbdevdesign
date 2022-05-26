create table Person(
Id serial primary key not null,
Name varchar 	
)

insert into Person(Name) values ('Mitko')

select * from person

drop table person

update person set name ='Zoran2'
where
id = 2

delete from person


CREATE TABLE test_data_types (
id SERIAL PRIMARY KEY NOT NULL,
field1 int,
field2 	char(10),
field3 	varchar(10),
field4 	char(10),
field5  text,
field6 	varchar,
field7 	float, 
field8 	real, 
field9 	numeric(12,5),
field10 uuid, 
field11 bool,
field12 timestamp 	DEFAULT NOW()
)



CREATE TABLE Customer (
	Id bigserial primary key  NOT NULL,
	Name varchar(100) NOT NULL,
	City varchar(100) NULL)



INSERT INTO Customer ( Name, City)
VALUES  ('Vero Skopje', 'Skopje')

INSERT INTO Customer (Id, Name, City)
VALUES  (2, 'Vero Strumica', 'Strumica')


update Customer set 
name='Vero2',
city='Strumica2'
where city='Strumica'


select * from Customer


select 
-- delete
* from Customer
where id = 5



alter table customer add address  varchar not null default 'no address'





CREATE TABLE BusinessEntity (
Id Integer PRIMARY KEY NOT NULL,
Name varchar(100) NULL,
Region varchar(1000) NULL,
Zipcode varchar(10) NULL,
Size varchar(10) NULL)


CREATE TABLE Employee (
Id serial PRIMARY KEY NOT NULL,
FirstName varchar(100) NOT NULL,
LastName varchar(100) NOT NULL,
DateOfBirth date NULL,
Gender nchar(1) NULL,
HireDate date NULL,
NationalIdNumber varchar(20) NULL,
created_at timestamp DEFAULT NOW()	
)

CREATE TABLE Product (
Id serial PRIMARY KEY NOT NULL,
 Code varchar(100),
 Name varchar(100) NOT NULL,
Description varchar NOT NULL,	
Weight float(2)	
)

alter table person add    primary key(id)

alter table Product add Price float(2)	

ALTER TABLE Product RENAME TO Product1;
