

-- 1	Calculate “(price + cost) / weight” for all products.
select
(price + cost) / weight as Calculation
, *
from public.product
-- 2	Get a round number that is higher or equal for the costs and a round number that is lower or equal for the prices for all products.
select
ceil(cost) as cost_ceil, cost, floor(price) as price_floor, price
from product
-- 3	Get all orders and generate a random number between 0 and 100 for every order.
select
id, floor(random() * 1000) as RandomNumber
, *
from "Order"
-- 4	Concatenate the name, region and zipcode from every business entity and add the delimiter ‘; ‘ between them.
select
    name || '; ' || region || '; ' || zipcode as concatanation
from businessentity
select 
	concat(name, '; ', region, '; ', zipcode) as concatanation
from businessentity	
-- 5	Concatenate the first and last name for every employee and show the character length for the full name.
select 
	length(firstname || ' ' || LastName) as Version1
,	length(concat(firstname, ' ', Lastname)) as Version2
,	*
from employee
-- 6	Replace every employee’s last name that ends with ‘ski’ with ‘ic’.
Select 
	replace(lastname, 'ski', 'ic') as ReplacedLastName
,	*
from employee

-- 7	Create a temporary table ‘Holidays’ that will contain the columns: id (PK), startDate, endDate; add some values and select them.
create temporary table holidays
(
		id integer primary key
	,	startdate date
	,	enddate date
);

select * from holidays

insert into holidays (id, startdate, enddate) 
values (1, '2022-06-12', '2022-06-19')



