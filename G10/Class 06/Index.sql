
explain
SELECT * FROM customer
WHERE phonenumber = '365910'

CREATE INDEX idx_customer_phone
ON customer (phonenumber);


CREATE INDEX idx_order_totalprice
ON "Order" (totalprice);

EXPLAIN 
SELECT * FROM "Order"
WHERE totalprice = 28.598127