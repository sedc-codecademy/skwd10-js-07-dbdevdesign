/*
Declare function (get_customer_orders) that returns the orders for a certain customer based on their customerId. Return a separate column for:

The customer’s name and account number divided by a space character
The customer’s city’s first three characters together with their region’s first three characters, divided by a backwards slash (‘/’)
The order id and its price, divided by a dash (‘-’)
*/

drop function if exists get_customer_orders;

create or replace function get_customer_orders(customer_Id int)
returns table(
    name_accountnumber text,
    city_region text,
    totalprice text,
    employeeid int
)
language plpgsql
as $$
begin
    return query
select
    name || ' ' || accountnumber,
    left(city, 3) || '/' ||left(regionname, 3),
    o.id || '-' || o.totalprice,
    o.employeeid
from customer c 
inner join "Order" o on c.id = o.customerid
where c.id = customer_Id;
end;
$$;

-- SAMPLE CALL FUNCTION
/*
select *
from get_customer_orders(5) t1
inner join employee e on t1.employeeid = e.id
*/
