create database bank;
use bank;

create table branch(
branch_name varchar(20) primary key,
branchcity varchar(20),
assets int);

create table bank_account(
accno int primary key, branch_name varchar(20),
balance int,
foreign key(branch_name)references branch(branch_name));

create table bank_customer(
customer_name varchar(20),
customer_street varchar(20),
city varchar(20),
primary key(customer_name));

create table depositer(
customer_name varchar(20),
accno int,
primary key(customer_name,accno),
foreign key (customer_name)references bank_customer(customer_name),
foreign key (accno)references bank_account(accno));

create table loan(
loan_num int primary key,
branch_name varchar(20),
amount int,
foreign key(branch_name)references branch(branch_name));

insert into branch values("SBI_Chamrajpet","banglore",50000);
insert into branch values("SBI_Residency","banglore",10000);
insert into branch values("SBI_Shivajiroad","bombay",20000);
insert into branch values("SBI_Parlimentroad","delhi",10000);
insert into branch values("SBI_Jantarmantar","delhi",20000);
select *from branch;

insert into bank_account values(1,"SBI_Chamrajpet",2000);
insert into bank_account values(2,"SBI_Residency",5000);
insert into bank_account values(3,"SBI_Shivajiroad",6000);
insert into bank_account values(4,"SBI_Parlimentroad",9000);
insert into bank_account values(5,"SBI_Jantarmantar",8000);
insert into bank_account values(6,"SBI_Shivajiroad",4000);
insert into bank_account values(8,"SBI_Residency",4000);
insert into bank_account values(9,"SBI_Chamrajpet",3000);
insert into bank_account values(10,"SBI_Residency",5000);
insert into bank_account values(11,"SBI_Jantarmantar",2000);
select *from bank_account;

insert into bank_customer values("Avinash","Bull_temple_roadd","banglore");
insert into bank_customer values("Dinesh","Banergatta_road","banglore");
insert into bank_customer values("Mohan","Nc_road","banglore");
insert into bank_customer values("Nikil","Akbar_road","delhi");
insert into bank_customer values("Ravi","Prithviraj_road","delhi");
select*from  bank_customer;

insert into depositer values("Avinash",1);
insert into depositer values("Dinesh",2);
insert into depositer values("Nikil",4);
insert into depositer values("Ravi",5);
insert into depositer values("Avinash",8);
insert into depositer values("Nikil",9);
insert into depositer values("Dinesh",10);
insert into depositer values("Nikil",11);
select *from depositer;

insert into loan values(1,"SBI_Chamrajpet",1000);
insert into loan values(2,"SBI_Residency",2000);
insert into loan values(3,"SBI_Shivajiroad",3000);
insert into loan values(4,"SBI_Parlimentroad",4000);
insert into loan values(5,"SBI_Jantarmantar",5000);
select *from loan;


select d.customer_name,
		a.branch_name
from depositer d
	Join bank_account a on d.accno=a.accno
Group by
d.customer_name,a.branch_name
having COUNT(d.accno)>=2;

select branch_name ,(assets/1000000)as "assets in lakhs"
from branch;

create view branch_loan_summary AS
select branch_name,SUM(amount) AS
total_loan_amount
from loan
Group by branch_name;
select * from branch_loan_summary;

select customer_name
from bank_customer
where customer_name not in(
select DISTINCT customer_name from depositer
);

SELECT DISTINCT bc.customer_name
FROM bank_customer bc
JOIN depositer d ON bc.customer_name = d.customer_name
JOIN bank_account ba ON d.accno = ba.accno
JOIN branch br ON ba.branch_name = br.branch_name
JOIN loan l ON br.branch_name = l.branch_name
WHERE br.branchcity = 'banglore';

select branch_name
from branch
where assets > (
	select max(assets)
	from branch  
	where branchcity="banglore"
);

SELECT d.customer_name
FROM depositer d
JOIN bank_account a ON d.accno = a.accno
JOIN branch b ON a.branch_name = b.branch_name
WHERE b.branchcity = 'delhi'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT a.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branchcity = 'delhi'
);










