-- 2	Create a procedure that inserts a business entity by providing a name, region and zipcode. Only insert a record if a business entity with that name does not exist. 
		--Define an inout parameter that gets populated with the new business entity ID.
CREATE OR REPLACE PROCEDURE insert_business_entity 
(
		businessentityname varchar
	,	region varchar
	,	zipcode varchar
	,	businessentityid inout int
)
LANGUAGE plpgsql
AS $$
DECLARE 
	existing_businessentity record;
BEGIN
	SELECT * FROM businessentity INTO existing_businessentity
	WHERE name = businessentityname;
	
	IF FOUND THEN
		RAISE 'A business entity with the name %, from region % and zipcode % already exists in the database!',
		existing_businessentity.name,
		existing_businessentity.region,
		existing_businessentity.zipcode;
		RETURN;
	END IF;
	
	INSERT INTO businessentity (name, region, zipcode)
	VALUES (businessentityname, region, zipcode);
	
	SELECT id FROM businessentity INTO businessentityid 
	WHERE name = businessentityname;
	COMMIT;
END;
$$;

CALL insert_business_entity ('EdiNew', 'Skopski', '1000', null)


		
