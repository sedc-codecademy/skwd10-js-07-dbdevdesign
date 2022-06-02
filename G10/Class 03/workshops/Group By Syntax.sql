

select
*
from employee

select
	count(*) as "count", max(id) as "max", min(id) as "min", avg(id) as "avg"
from employee

select
	gender
	,	count(*) as "count", max(id) as "max", min(id) as "min", avg(id) as "avg"
from employee
group by gender

--Calculate the total amount on all orders in the system
select
		count(totalprice) as "count"
	,	sum(totalprice) as totalprice	
from public."Order"

select *
from public."Order"

--Calculate the total amount per BusinessEntity on all orders in the system
select
		businessentityid
	,	count(totalprice) as "count"
	,	sum(totalprice) as totalprice	
from public."Order"
group by 
	businessentityid

--Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 5
select
		businessentityid
	,	count(totalprice) as "count"
	,	sum(totalprice) as totalprice	
from public."Order"
--join.....
where Customerid < 5
group by 
	businessentityid

--Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system
select
		businessentityid
	,	count(totalprice) as "count"
	,	sum(totalprice) as totalprice	
	,	max(totalprice) as maxOrder
	,	avg(totalprice) as avgOrder
from public."Order"
group by 
	businessentityid
order by businessentityid

