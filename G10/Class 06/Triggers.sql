
-- 1 Create new table called OrderDetailsAudits (id, orderId, orderDetailId, oldQuantity, oldPrice, newQuantity, newPrice, changedOn)
DROP TABLE OrderDetailsAudits
CREATE TABLE OrderDetailsAudits
(
		id serial primary key not null
	,	orderId int
	,	orderdetailsId int
	,	oldQuantity int
	,	oldPrice real
	,	newQuantity int
	,	newPrice real
	,	changedOn timestamp
)

-- 2 Whenever the table orderDetail gets updated, fill the OrderDetailsAudits with the relevant values. Check if the quantity or price values actually changed.
CREATE OR REPLACE FUNCTION log_order_details_changes ()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
BEGIN
	IF (NEW.quantity <> OLD.quantity) OR (NEW.price <> OLD.price) THEN
		INSERT INTO OrderDetailsAudits (orderId, orderdetailsId, oldquantity, oldprice, newquantity, newprice, changedon)
		VALUES (OLD.orderid, OLD.id, OLD.quantity, OLD.price, NEW.quantity, NEW.price, now());
	END IF;	
	RETURN NEW;
END;
$$;


-- CREATE TRIGGER FOR TIGGER FUNCTION
CREATE TRIGGER order_details_changes
	BEFORE UPDATE
	ON orderdetails
	FOR EACH ROW
	EXECUTE PROCEDURE log_order_details_changes ();
	

SELECT * FROM orderdetails order by id desc

SELECT * FROM orderdetails WHERE id = 100

UPDATE orderdetails SET quantity = 32, price = 23 WHERE id = 100

SELECT * FROM OrderDetailsAudits

-- 3 Create another trigger to fill the OrderDetailsAudits table when an order detail gets added, setting the oldquantity and oldprice columns to -1.
CREATE OR REPLACE FUNCTION log_order_details_changes ()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
BEGIN
	IF (OLD is null) THEN
		INSERT INTO OrderDetailsAudits (orderId, oldquantity, oldprice, newquantity, newprice, changedon)
		VALUES (NEW.orderid, -1, -1, NEW.quantity, NEW.price, now());
	ELSEIF (NEW.quantity <> OLD.quantity) OR (NEW.price <> OLD.price) THEN
		INSERT INTO OrderDetailsAudits (orderId, orderdetailsId, oldquantity, oldprice, newquantity, newprice, changedon)
		VALUES (OLD.orderid, OLD.id, OLD.quantity, OLD.price, NEW.quantity, NEW.price, now());	
	END IF;
	RETURN NEW;
END;
$$;


-- NEW TRIGGER FOR INSERT 
CREATE TRIGGER order_details_insert
	AFTER INSERT
	ON orderdetails
	FOR EACH ROW
	EXECUTE PROCEDURE log_order_details_changes ();


SELECT * FROM OrderDetailsAudits
UPDATE orderdetails SET quantity = 23, price = 13 WHERE id = 100

INSERT INTO orderdetails (orderid, productid, quantity, price)
VALUES (100, 1, 22, 44)

SELECT * FROM OrderDetails where orderid = 100
SELECT * FROM OrderDetailsAudits

-- 4 Create a trigger that fires when a row from OrderDetails gets deleted. 
--	Check if there are any rows in OrderDetailsAudits for the ID of the row being deleted and set all columns to -1.
CREATE OR REPLACE FUNCTION log_order_details_changes ()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
BEGIN
	IF (NEW is null) THEN
		UPDATE OrderDetailsAudits 
		SET		oldquantity = -1
			,	oldprice = -1
			,	newquantity = -1
			,	newprice = -1
			,	changedon = now()
		WHERE 
			orderdetailsid = OLD.id;
	ELSEIF (OLD is null) THEN
		INSERT INTO OrderDetailsAudits (orderId, oldquantity, oldprice, newquantity, newprice, changedon)
		VALUES (NEW.orderid, -1, -1, NEW.quantity, NEW.price, now());
	ELSEIF (NEW.quantity <> OLD.quantity) OR (NEW.price <> OLD.price) THEN
		INSERT INTO OrderDetailsAudits (orderId, orderdetailsId, oldquantity, oldprice, newquantity, newprice, changedon)
		VALUES (OLD.orderid, OLD.id, OLD.quantity, OLD.price, NEW.quantity, NEW.price, now());	
	END IF;		
	RETURN NEW;
END;
$$;

CREATE TRIGGER order_details_delete
	AFTER DELETE
	ON orderdetails
	FOR EACH ROW
	EXECUTE PROCEDURE log_order_details_changes ();


SELECT * FROM OrderDetailsAudits
UPDATE orderdetails SET quantity = 23, price = 13 WHERE id = 100

INSERT INTO orderdetails (orderid, productid, quantity, price)
VALUES (100, 1, 222, 444)

SELECT * FROM OrderDetails where orderid = 100
SELECT * FROM OrderDetailsAudits
	
DELETE FROM OrderDetails WHERE ID = 100
	
	
	
	
	
	