
/*
Homework prerequisite: 
1. 	create a new table called ProductHistory. 
	Columns should be (id serial, oldPrice real, oldCost real, newPrice real, newCost real, changedOn date, orderedOn date, orderedQuantity int).
*/
DROP TABLE ProductHistory
create table ProductHistory(
    id serial,
    oldPrice real,
    oldCost real,
    newPrice real,
    newCost real,
    changedOn timestamp,
    orderedOn date,
    orderedQuantity int
)

select * from ProductHistory

/*
2. 	Create a trigger that after the Product table gets updated, the trigger inserts a row in the ProductHistory. with the old and new price and cost. 
	Set the current date to the changedOn column. Leave the other columns null.
*/
CREATE OR REPLACE FUNCTION log_product ()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
BEGIN
	IF (NEW.price <> OLD.price) OR (NEW.cost <> OLD.cost) THEN
		INSERT INTO ProductHistory (oldprice, oldcost, newprice, newcost, changedon)
		VALUES (OLD.price, OLD.cost, NEW.price, NEW.cost, now());
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER product_update
	BEFORE UPDATE
	ON product
	FOR EACH ROW
	EXECUTE PROCEDURE log_product ();
	

SELECT * FROM product WHERE id < 5

UPDATE product SET price = price + 5 WHERE id < 5

SELECT * FROM ProductHistory

/*
3.	Create a trigger that after the OrderDetails table gets a record added, the trigger inserts a row in the ProductHistory table. 
	Set the orderedOn column to the current date and the orderedQuantity with the quantity coming from the new OrderDetails record.
*/
CREATE OR REPLACE FUNCTION log_order_added()
	RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO producthistory (orderedon, orderedquantity)
	VALUES (now(), NEW.quantity);
	RETURN NEW;
END;
$$;

CREATE TRIGGER order_insert
AFTER INSERT
ON orderdetails
FOR EACH ROW
EXECUTE PROCEDURE log_order_added();

INSERT INTO orderdetails (orderid, productid, quantity, price) 
VALUES (50, 5, 5, 50)

SELECT * FROM ProductHistory





