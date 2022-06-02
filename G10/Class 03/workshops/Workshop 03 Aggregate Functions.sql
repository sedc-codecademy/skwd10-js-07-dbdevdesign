
select 
		businessentityid
	,	sum(TotalPrice) as TotalAmount
from "Order"
where CustomerId < 5
group by
	businessentityid
having sum(TotalPrice) > 250		
order by 
	businessentityid
	
	
--Calculate the sum of prices of orders per business entities and show the records where their sum is greater than 400
select 
		businessentityid
	,	sum(TotalPrice) as TotalAmount
from "Order"
group by
	businessentityid
having sum(TotalPrice) > 400		
order by 
	businessentityid

--Calculate the sum of prices per business entity on all orders from customers with ID < 5 and filter only records with sums less then 1000
select 
		businessentityid
	,	sum(TotalPrice) as TotalAmount
from "Order"
where CustomerId < 5
group by
	businessentityid
having sum(TotalPrice) < 1000		
order by 
	businessentityid

--Find the Maximum Order amount, and the Average Order amount per business entity on all orders in the system. 
--Filter only records where the max price is 1.5x bigger than the average.
select 
		businessentityid
	,	max(TotalPrice) as MaxTotalAmount
	,	avg(TotalPrice) as AvgTotalPrice
from "Order"
group by
	businessentityid
having max(TotalPrice) > avg(TotalPrice)*1.5
order by 
	businessentityid


--List all BusinessEntity names, region and zipcode next to the other details from the previous query
select 
		b.Name as BusinessEntity_names
	,	b.Region
	,	b.ZipCode
	,	max(TotalPrice) as MaxTotalAmount
	,	avg(TotalPrice) as AvgTotalPrice
from "Order" o
inner join businessentity b on o.businessentityid = b.id
group by
		b.Name 
	,	b.Region
	,	b.ZipCode
having max(TotalPrice) > avg(TotalPrice)*1.5
order by 
	b.Name


