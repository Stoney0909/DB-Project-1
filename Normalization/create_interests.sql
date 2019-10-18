USE Normalization1;
DROP TABLE IF EXISTS Interests;
DROP TABLE IF EXISTS Person_Interest;

alter table my_contacts
    add column Interest_1 varchar(45)
    as(substring_index(interests, ',', 1));

alter table my_contacts
    add column Interest_2 varchar(45)
    as(substring_index(substring(interests, length(my_contacts.Interest_1) + 3, length(interests)), ',', 1));

alter table my_contacts
    add column Interest_3 varchar(45)
    as(substring(interests, length(substring_index(interests, ',', 2)) + 3, length(interests)));


CREATE TABLE Interest(
  Interest_ID int(11) NOT NULL auto_increment,
  Interest VARCHAR(42) NOT NULL,
  PRIMARY KEY  (Interest_ID)
);
drop table if exists extra_Table;
Create table extra_Table(
    Interest varchar(45) not null
);

insert into extra_Table(Interest)
select distinct Interest_1
from my_contacts
where Interest_1 is not null and not Interest_1 = ''
order by Interest_1;

insert into extra_Table(Interest)
select distinct Interest_2
from my_contacts
where Interest_2 is not null and not Interest_2 = ''
order by Interest_2;

insert into extra_Table(Interest)
select distinct Interest_3
from my_contacts
where Interest_3 is not null and not Interest_3 = ''
order by Interest_3;


insert into Interest(Interest)
select distinct Interest
from extra_Table
where Interest is not null
order by Interest;

 ALTER TABLE my_contacts
 	ADD COLUMN Person_ID INT(11) not null auto_increment
    primary key;

CREATE TABLE Person_Interest (
  Person_ID int(11),
  Interest_ID VARCHAR(25)
);

INSERT INTO Person_Interest (Interest_ID, Person_ID)
    select inter.Interest_ID, mc.Person_ID
    from my_contacts mc
    join Interest inter
    where inter.Interest = mc.Interest_1;

INSERT INTO Person_Interest (Interest_ID, Person_ID)
    select inter.Interest_ID, mc.Person_ID
    from my_contacts mc
    join Interest inter
    where inter.Interest = mc.Interest_2;

INSERT INTO Person_Interest (Interest_ID, Person_ID)
    select inter.Interest_ID, mc.Person_ID
    from my_contacts mc
    join Interest inter
    where inter.Interest = mc.Interest_3;


# select mc.Interest_1, mc.Interest_1, inter.interest, inter.Interest_ID, mc.Person_ID
#     from my_contacts mc
#     join Interest inter
#     where inter.Interest = mc.Interest_1;

# select pi.Person_ID, pi.Interest_ID, mc.Interest_1, mc.Interest_2, mc.Interest_3, inter.Interest, inter.Interest_ID
#     from Person_Interest as pi
#     join my_contacts as mc
#     on pi.Person_ID = mc.Person_ID
#     join Interest as inter
#     on pi.Interest_ID = inter.Interest_ID;

drop table extra_Table;


ALTER TABLE my_contacts
    DROP COLUMN Interest_3;
ALTER TABLE my_contacts
    DROP COLUMN Interest_2;
ALTER TABLE my_contacts
    DROP COLUMN Interest_1;
ALTER TABLE my_contacts
    DROP COLUMN interests;