select * 
from employee
where FirstName = 'Goran';

select * 
from employee
where LastName like '%sk%'

select * 
from employee
where LastName like '%a'

select * 
from employee
where DateOfBirth >= '1980-01-01';

select * 
from employee
where gender = 'M';


select * 
from employee
order by hiredate

select * 
from employee
where hireDate between '2010-06-01' and '2010-06-30';

select * 
from employee
where hireDate >= '2013-02-01' and hiredate <= '2013-05-31';

select * 
from employee
where hireDate >= '1983-02-01' 
	and hiredate <= '2013-05-31'
	and LastName like 'T%';
	
	
select * 
from employee
order by firstName desc, dateOfBirth desc

select * 
from employee
where FirstName = 'Aleksandar'
order by LastName;

select * 
from employee
order by FirstName;

select * 
from employee
where gender = 'M'
order by HireDate desc

select *
from BusinessEntity

select *
from customer

select region
from BusinessEntity
union --returns 11 rows without duplicates
select RegionName
from customer

select region
from BusinessEntity
union all -- returns all rows with diplicates
select RegionName
from customer

select region
from BusinessEntity
intersect -- will return duplicates that intersect
select RegionName
from customer


select *
from employee
where FirstName = 'Aleksandar'

select *
from employee
where LastName = 'Nikolovski'

-------------------- VEZBA 2

select name
from BusinessEntity
union all
select name
from Customer

select region
from BusinessEntity
union
select regionname
from Customer

select region
from BusinessEntity
intersect
select regionname
from Customer

----------------------------

create table customer2
(
	Name text not null,
	Adress text null,
	FirstName text --by default is null
)

create table customer3
(
	name text,
	address text,
	PhoneNumber text unique -- unique constraint
)

insert into customer3
values ('Edi','Skopje', '071252525')

insert into customer3
values ('Edi','Skopje', '071252525') --THROWS AN ALREADY EXISTS NUMBER



--adding constraint afterwards
truncate table customer3; --deletes everything from customer3 table but keeps the table

insert into customer3
values ('Edi','Skopje', '071252525');


--unique address constraint
alter table customer3
add constraint customer3_address_uq
unique (address);

insert into customer3
values ('Edi','Skopje', '071252425');


--CHECK Constraint
drop table if exists customer4;
create table customer4
(
	Name text,
	LastName text,
	Age integer check(age > 18)
);

insert into customer4
values ('Ivan', 'Jamandilovski', 32);

insert into customer4
values ('Jan', 'Jamandilovski', 1); --throws a constraint violation due to customer4_age_check constraint


-------UNIQUE KEY CONSTRAINT
create table customer5
(
	Id integer primary key,
	Name text,
	Address text
);

--with unique composite pk
create table customer6
(
	Id integer not null,
	Id2 integer not null,	
	Name text,
	Address text,
	primary key (id, id2) --composite primary key combination of id and id2
)


create table company
(
	id integer primary key,
	Name text,
	address text
)

create table employee_Ref
(
	Name text,
	Address text,
	Age smallint,
	companyId integer references Company(id)
)

select * from employee_Ref

-----WORKSHOP 3

drop table if exists public.product1;
CREATE TABLE IF NOT EXISTS public.product1
(
    id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass),
    code character varying(50) COLLATE pg_catalog."default",
    name character varying(100) COLLATE pg_catalog."default",
    description character varying(5000) COLLATE pg_catalog."default",
    weight real,
    price real Check(price < 2*cost),
    cost real    
)

alter table product1
add constraint uq_product1_name
unique(Name);

CREATE TABLE IF NOT EXISTS public.product2
(
    id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass),
    code character varying(50) COLLATE pg_catalog."default",
    name character varying(100) unique,
    description character varying(5000) COLLATE pg_catalog."default",
    weight real,
    price real Check(price < 2*cost),
    cost real    
);

select * from "Order"
where id = 1

select * from businessentity
where id = 1

select * from customer
where id = 3

select * from employee
where id = 2


--FOREIGN KEYS

select * from "Order"

alter table "Order"
add constraint fk_order_businessentity
	foreign key (businessentityid) 
	references businessentity(id);
	
alter table customer
add constraint fk_order_businessentity
	foreign key (id) 
	references employee (id);
		
alter table employee
add constraint fk_order_businessentity
	foreign key (id)
	references customer (id);
	
select * 
from customer;

	
select * 
from employee;


--TYPES OF RELATIONS
-- 1:M  M:M   1:1


--JOIN TYPES: Inner, Outer, Left, Right, Cross

drop table if exists table1;
drop table if exists table2;

create table table1
(
	id1 integer primary key
);

create table table2
(
	id2 integer primary key
);

insert into table1
values (1),(2),(3);

insert into table2
values (3), (4),(5);

select * from table1; --3 rows
select * from table2; --3 rows

--CROSSJOIN
select *
from table1
cross join table2;

--INNER JOIN
select *
from table1 t1 --t1 i alias for table1
join table2 t2 --by default is inner join
on t1.id1 = t2.id2;

--left outer join
select *
from table1 t1 --t1 i alias for table1
left outer join table2 t2 --by default is inner join
on t1.id1 = t2.id2;

--right join
select *
from table2 t2
right outer join table1 t1 --by default is inner join
on t1.id1 = t2.id2;

--full outer join

select *
from table1 t1
full outer join table2 t2 --by default is inner join
on t1.id1 = t2.id2;

drop table if exists table1;
drop table if exists table2;

---WORKSHOP 4

--CROSSJOIN
select Name 
from customer;

select Name 
from product;

select c.Name as CustomerName, p.name as ProductName --as names the column with the name provided after "as"
from customer c
cross join product p

--SELECT THE BUSINESS ENTITIES THAT HAVE MADE AN ORDER
select distinct b.Name as BusinessEntityName -- selecting distinct business entities
from "Order" o --from order aliased in this query as o
inner join businessentity b --join with order
on o.businessentityid = b.id --on the businessentityid with the order id

select *
from businessentity -- 7 business entities

update "Order"
set BusinessEntityId = 2 
where BusinessEntityId = 1;

--list all entities without orders 
--with right join
select b.Name as businessEntityName_WithoutOrders --as names the column with the name provided after "as"
from "Order" o
right join businessEntity b
on o.businessEntityId = b.id
where o.Id is null

--with left join
select b.Name as businessEntityName_WithoutOrders
from businessEntity b
left join "Order" o
on o.businessEntityId = b.id
where o.Id is null

--list all customers without orders using left and right join
--with left join
select c.Name as customer_WithoutOrders --as names the column with the name provided after "as"
from customer c
left join "Order" o
on o.businessEntityId = c.id
where o.Id is null


--with right join
select c.Name as customer_WithoutOrders
from "Order" o
right join customer c
on o.businessEntityId = c.id
where o.Id is null





	

