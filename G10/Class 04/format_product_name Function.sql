
/*
Declare function (format_product_name) for retrieving the Product description for specific ProductId in the following format:
First and second character from the Code
Last three characters from the Name
Product Price
Divide the three different values with a dash (‘-’);

select 
	left(Code, 2) as Code_UsingLeft
,	substring(code from 1 for 2) as Code_UsingSubstring
,	right(Name, 3) as Name_Right
,	concat(left(Code, 2), '-', right(Name, 3), '-', Price)
,	left(Code, 2) || '-' || right(Name, 3)|| '-'|| Price
, 	*
from product
*/
create or replace function format_product_name (productId int)
	returns varchar
	language plpgsql
as
$$
declare 
	formatted_product_name varchar;
begin	
	select 
		concat(left(Code, 1), '-', right(Name, 2), '-', Price)
		into formatted_product_name
	from product
	where id = productid;
	return formatted_product_name;
end
$$;

select format_product_name (1)

select 
	*
,	format_product_name (id)	as Formated_From_Function
,	concat(left(Code, 2), '-', right(Name, 3), '-', Price) as Formated_In_Query
from product;
