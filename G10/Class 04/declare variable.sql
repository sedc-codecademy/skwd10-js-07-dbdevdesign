
do
$$
	declare
		totalquantiy int;
		totalprice real;
	begin
		select count(quantity) into totalquantiy
		from orderdetails;
		select sum(price) into totalprice
		from orderdetails;

		raise notice 'The total number of quantities for all orders is: %, and the total price is: %', totalquantiy, totalprice;
	end;	

$$;



do $$
declare
    first_name varchar(50) := 'Edi';
    last_name varchar(50) := 'Doe';
    payment numeric(11,2) := 2500.5;
begin
    raise notice '% % has been paid % USD',
    first_name,
    last_name,
    payment;
end $$;



