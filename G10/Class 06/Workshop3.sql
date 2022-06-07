
-- 3 	Create a procedure that inserts an order. Insert a record in Order table and OrderDetails table. The parameters required are employeeId, totalPrice, quantity and productId. 
		--After inserting a row in Order table, check if a product with the given productId exists. If not, rollback the transaction.
CREATE OR REPLACE PROCEDURE insert_order
(
		employeeid int
	,	totalprice real
	,	quantity int
	,	productid int
)
LANGUAGE plpgsql
AS $$
DECLARE 
	existing_product record;
	new_order_id int;
BEGIN
	INSERT INTO "Order" (orderdate, employeeid, totalprice)
	VALUES (now(), employeeid, totalprice)
	RETURNING id INTO new_order_id;
	
	SELECT * FROM product INTO existing_product
	WHERE id = productid;
	
	IF NOT FOUND THEN
		RAISE 'A product with ID:% cannot be found! Performing rollback!', product_id;
		ROLLBACK;
		RETURN;
	END IF;
	
	INSERT INTO orderdetails (orderid, productId, quantity, price)
	VALUES (new_order_id, productid, quantity, totalprice);
	COMMIT;
END;
$$;

CALL insert_order (1, 1000, 10, 1000)

SELECT * FROM "Order" ORDER BY id DESC

SELECT * FROM orderdetails 
WHERE orderid = 101



