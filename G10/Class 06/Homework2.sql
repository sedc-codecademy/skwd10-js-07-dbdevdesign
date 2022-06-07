

--	1. Create a procedure that inserts an order. The procedure takes in a business entity ID, an employee ID, a product ID and the quantity.
--	2. Insert a record in Order table. Set the orderDate to the current date. Set the totalPrice by getting the product with the given product ID, 
--	by calculating (product.price - product.cost). Set the status to 0.
-- 	3. Insert a record in OrderDetails table. The order ID should be the ID of the record that just got inserted. The product ID and quantity are given as parameters. 
--	The price should come from the newly inserted row in the Order table. 

CREATE OR REPLACE PROCEDURE create_new_order 
(
		business_entity_id int
	,	employee_id int
	,	product_id int
	,	quantity int
)
LANGUAGE plpgsql
AS $$
DECLARE 
	product_var record;
	new_order_id int;
BEGIN
	SELECT * FROM product INTO product_var
	WHERE id = product_id;
	
	INSERT INTO "Order" (orderdate, status, businessentityid, employeeid, totalprice)
	VALUES (now(), 0, business_entity_id, employee_id, (product_var.price - product_var.cost))
	RETURNING id INTO new_order_id;
	
	INSERT INTO orderdetails (orderid, productid, quantity, price)
	VALUES (new_order_id, product_id, quantity, (SELECT totalprice FROM "Order" WHERE id = new_order_id));
	
	COMMIT;
END;
$$;

CALL create_new_order (5,5,5,15)

SELECT * FROM "Order" ORDER BY ID DESC

SELECT * FROM orderdetails WHERE orderid = 103




