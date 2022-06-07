


-- 1	Create a procedure that calculates a discount for a given order ID and updates the orders table accordingly. The discount is also provided.
SELECT * FROM "Order"

CREATE OR REPLACE PROCEDURE update_order_discount (order_id int, discount int)
	LANGUAGE plpgsql
AS $$
DECLARE 
	original_price real;
BEGIN
	SELECT totalprice FROM "Order" INTO original_price -- JA SETIRAME STARATA VREDNOST NA TOTALPRICE
	WHERE id = order_id;
	IF NOT FOUND THEN
		RAISE NOTICE 'Order with ID: % was not found!', order_id;
		RETURN;
	END IF;
		UPDATE "Order"
		SET totalprice = original_price - (original_price * discount / 100),
			comment = format('%s%% discount used.', discount)
		WHERE id = order_id;
	COMMIT;	
END;
$$;

CALL public.update_order_discount(-1, 10)


select * from "Order"
where id = 1
