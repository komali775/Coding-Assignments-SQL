create database sales;
use sales;

-- table salespeople 
create table salespeople (snum int primary key,
sname varchar(50), city varchar(50),comm decimal(4,2));

insert into salespeople (snum, sname, city, comm) values
(1001, 'peel', 'london', 0.12),
(1002, 'serres', 'san jose', 0.13),
(1004, 'motika', 'london', 0.11),
(1007, 'rafkin', 'barcelona', 0.15),
(1003, 'axelrod', 'new york', 0.10);

select * from salespeople;

-- table customers
create table cust (cnum int primary key,cname varchar(50), city varchar(50),
rating int, snum int, foreign key (snum) references salespeople(snum));

insert into cust (cnum, cname, city, rating, snum) values
(2001, 'hoffman', 'london', 100, 1001),
(2002, 'giovanne', 'rome', 200, 1003),
(2003, 'liu', 'san jose', 300, 1002),
(2004, 'grass', 'brelin', 100, 1002),
(2006, 'clemens', 'london', 300, 1007),
(2007, 'pereira', 'rome', 100, 1004);

select * from cust;

-- table orders
create table orders (onum int primary key, amt decimal(10,2),
odate date, cnum int, snum int, foreign key (cnum) references 
cust(cnum), foreign key (snum) references salespeople(snum));
select * from cust;

insert into cust (cnum, cname, city, rating, snum) values
(2008, 'unknown', 'unknown city', 100, 1007);

set foreign_key_checks = 0;

insert into orders (onum, amt, odate, cnum, snum) values
(3001, 18.69, '1994-10-03', 2008, 1007), 
(3003, 767.19, '1994-10-03', 2001, 1001), 
(3002, 1900.10, '1994-10-03', 2007, 1004), 
(3005, 5160.45, '1994-10-03', 2003, 1002), 
(3006, 1098.16, '1994-10-04', 2008, 1007), 
(3009, 1713.23, '1994-10-04', 2002, 1003), 
(3007, 75.75, '1994-10-05', 2004, 1002), 
(3008, 4723.00, '1994-10-05', 2006, 1001), 
(3010, 1309.95, '1994-10-06', 2004, 1002), 
(3011, 9891.88, '1994-10-06', 2006, 1001);

set foreign_key_checks = 1;
select * from orders;
