create database insurance;
use insurance;
create table person ( driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));
desc person;

create table car(reg_num varchar(10),model varchar(10), 
year int,primary key(reg_num));
desc car;
drop table car;
create table car(reg_num varchar(10),model varchar(10),
year int,primary key(reg_num));
desc car;

create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id,reg_num),
foreign key(driver_id)references person(driver_id),
foreign key(reg_num)references car(reg_num));
desc owns;

create table accident(report_num int,accident_date date, location varchar(20),
primary key(report_num));
desc accident;

create table part(driver_id varchar(10),reg_num varchar(10),
report_num int,damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
desc part;

insert into person values("a1","richard","kumta");
insert into person values("a2","Pradeep","sirsi");
insert into person values("a3","Smith","karwar");
insert into person values("a4","Venu","NRcolony");
insert into person values("a5","Jhon","Mysore");


insert into car values("KA068","INDICA",1990);
insert into car values("KA015","LANCER",2000);
insert into car values("KA011","TOYOTA",2011);
insert into car values("KA087","HONDA",2008);
insert into car values("KA067","AUDI",2005);

insert into owns values("a1","KA068");
insert into owns values("a2","KA015");
insert into owns values ("a3","KA011");
insert into owns values("a4","KA087");
insert into owns values("a5","KA067");

insert into accident values(11,"2001-01-01","mysore road");
insert into accident values(12,"2002-02-04","south end");
insert into accident values(13,"1921-10-03","bull temple");
insert into accident values(14,"2017-12-08","kanpur");
insert into accident values(15,"2004-03-05","mysore south");

insert into part values("a1","KA068",11,1000);
insert into part values("a2","KA015",12,50000);
insert into part values("a3","KA011",13,60000);
insert into part values("a4","KA087",14,40000);
insert into part values("a5","KA067",15,30000);

update part set damage_amount=25000
where reg_num="KA087" and report_num=14;

select* from part;

insert into accident values(16,"2001-03-08","dombu");
select*from accident;

select accident_date,location
from accident;

select driver_id
from part
where damage_amount>=25000;

select * from car 
order by year asc;




