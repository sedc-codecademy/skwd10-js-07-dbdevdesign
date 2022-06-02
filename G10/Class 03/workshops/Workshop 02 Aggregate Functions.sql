

--Find the highest order for every customer
select 
		customerid
	,	max(totalprice) as HighestOrder
from public."Order"
group by customerid
--Find the average price of orders per employee, only when the customer ID > 5
select 
		employeeid
	,	avg(totalprice)
from public."Order"
where 
	customerId > 5
group by 
	employeeid
order by 
	employeeid
--Find the maximum price of an order for every customer, showing their name
select 
		c.Name as CustomerName
	,	max(totalprice) as HighestOrder
from public."Order" o
inner join customer c on o.customerid = c.id
group by c.Name
--Find the minimum price of an order for every business entity, showing their name, and region and zip code concatenated in one column
select 
		b.name as businessentity_name
	,	region || '-' || zipcode as region_zipcode
	,	min(totalprice) as MinimumPrice
from public."Order" o
inner join businessentity b on o.businessentityid = b.id
group by 
		b.name
	,	region || '-' || zipcode

--Concatenate all the prices of the orders for every business entity with a ‘; ’ delimiter and show their names
select
		b.Name as businessentity_name
	,	string_agg(totalprice::text, ';') as prices_concatenated
from public."Order" o
inner join businessentity b on o.businessentityid = b.id
group by 
	b.Name
	
--Show the quantities (from OrderDetails table) of the highest price order for every business entity
select 
		o.businessentityid
	,	o.id as OrderId	
	,	sum(Quantity) as Quantities
	,	max(TotalPrice) as HighesPriceOrder
from public."Order" o
inner join OrderDetails od on o.id = od.OrderId
group by
		o.businessentityid
	,	o.id	



