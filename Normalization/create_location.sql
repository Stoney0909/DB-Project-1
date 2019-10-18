USE Normalization1;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS state;

update my_contacts
    set my_contacts.location = 'San Francisco, CA'
    where my_contacts.location = 'San Fran, CA';

alter table my_contacts
    add column City varchar(45)
    as(substring_index(location, ',', 1));

alter table my_contacts
    add column State varchar(45)
    as(substring(location, LENGTH(location) - 1, 2));



CREATE TABLE city (
  city_ID int(11) NOT NULL auto_increment,
  city VARCHAR(25) NOT NULL,
  PRIMARY KEY  (city_ID)
) AS
	SELECT DISTINCT City
	FROM my_contacts
	WHERE City IS NOT NULL
	ORDER BY City;

CREATE TABLE state (
  state_ID int(11) NOT NULL auto_increment,
  state VARCHAR(25) NOT NULL,
  PRIMARY KEY  (state_ID)
) AS
	SELECT DISTINCT State
	FROM my_contacts
	WHERE State IS NOT NULL
	ORDER BY State;


 ALTER TABLE my_contacts
 	ADD COLUMN State_ID INT(11);

ALTER TABLE my_contacts
 	ADD COLUMN City_ID INT(11);

UPDATE my_contacts
	INNER JOIN city
	ON city.city = my_contacts.City
	SET my_contacts.City_ID = city.city_ID
	WHERE city.city IS NOT NULL;

UPDATE my_contacts
	INNER JOIN state
	ON state.state = my_contacts.State
	SET my_contacts.State_ID = state.state_ID
	WHERE state.state IS NOT NULL;

# SELECT mc.first_name, mc.last_name, mc.City, mc.City_ID, ci.city
# 	FROM city AS ci
# 		INNER JOIN my_contacts AS mc
# 	ON ci.city_ID = mc.City_ID;
#
# SELECT mc.first_name, mc.last_name, mc.State, mc.State_ID, st.state
# 	FROM state AS st
# 		INNER JOIN my_contacts AS mc
# 	ON st.state_ID = mc.State_ID;


ALTER TABLE my_contacts
    DROP COLUMN city;
ALTER TABLE my_contacts
    DROP COLUMN State;
ALTER TABLE my_contacts
    DROP COLUMN location;
