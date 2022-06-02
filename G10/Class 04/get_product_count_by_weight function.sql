

create or replace function get_product_count_by_weight
(	min_weight int
 ,	max_weight int
)
returns int
language plpgsql
as
$$
declare
    product_count integer;
begin
    select count(*)
    into product_count
    from product
    where 
		weight between min_weight and max_weight;
    
    return product_count;
end;
$$;

-- USING POSITIONAL NOTATION
select get_product_count_by_weight(40, 90)
-- USING NAMED NOTATION
select get_product_count_by_weight(min_weight => 40, max_weight => 90)
-- USING MIXED NOTATION
select get_product_count_by_weight(40, max_weight => 90)

select get_product_count_by_weight(min_weight => 40, 90)





