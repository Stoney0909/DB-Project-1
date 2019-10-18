USE Normalization1;
DROP TABLE IF EXISTS Seeking;
DROP TABLE IF EXISTS Person_Seeking;

alter table my_contacts
    add column Seeking_1 varchar(45)
    as(substring_index(seeking, ',', 1));

alter table my_contacts
    add column Seeking_2 varchar(45)
    as(substring_index(substring(seeking, length(my_contacts.Seeking_1) + 3, length(seeking)), ',', 1));




CREATE TABLE Seeking(
  Seeking_ID int(11) NOT NULL auto_increment,
  Seeking VARCHAR(42) NOT NULL,
  PRIMARY KEY  (Seeking_ID)
);
drop table if exists extra_Table;
Create table extra_Table(
    Seeking varchar(45) not null
);

insert into extra_Table(Seeking)
select distinct Seeking_1
from my_contacts
where Seeking_1 is not null and not Seeking_1 = ''
order by Seeking_1;

insert into extra_Table(Seeking)
select distinct Seeking_2
from my_contacts
where Seeking_2 is not null and not Seeking_2 = ''
order by Seeking_2;

insert into Seeking(Seeking)
select distinct Seeking
from extra_Table
where Seeking is not null
order by Seeking;

CREATE TABLE Person_Seeking (
  Person_ID int(11),
  Seeking_ID VARCHAR(25)
);

INSERT INTO Person_Seeking (Seeking_ID, Person_ID)
    select se.Seeking_ID, mc.Person_ID
    from my_contacts mc
    join Seeking se
    where se.Seeking = mc.Seeking_1;

INSERT INTO Person_Seeking (Seeking_ID, Person_ID)
    select se.Seeking_ID, mc.Person_ID
    from my_contacts mc
    join Seeking se
    where se.Seeking = mc.Seeking_2;



#  select mc.Interest_1, mc.Interest_1, inter.interest, inter.Interest_ID, mc.Person_ID
#      from my_contacts mc
#      join Interest inter
#      where inter.Interest = mc.Interest_1;

# select pi.Person_ID, pi.Interest_ID, mc.Interest_1, mc.Interest_2, mc.Interest_3, inter.Interest, inter.Interest_ID
#     from Person_Interest as pi
#     join my_contacts as mc
#     on pi.Person_ID = mc.Person_ID
#     join Interest as inter
#     on pi.Interest_ID = inter.Interest_ID;

drop table extra_Table;

ALTER TABLE my_contacts
    DROP COLUMN Seeking_2;
ALTER TABLE my_contacts
    DROP COLUMN Seeking_1;
ALTER TABLE my_contacts
    DROP COLUMN seeking;
