use sales

-- 1. 	Display snum,sname,city and comm of all salespeople.
select snum, sname, city, comm from salespeople;

-- 2. 	Display all snum without duplicates from all orders.
Select distinct snum from orders ; 

-- 3. 	Display names and commissions of all salespeople in london.
Select sname,comm from salespeople where city = "London";

-- 4. 	All customers with rating of 100.
Select cname from cust where rating = 100;

-- 5. 	Produce orderno, amount and date form all rows in the order table.
Select onum, amt, odate from orders;

-- 6. 	All customers in San Jose, who have rating more than 200.
Select cname from cust where rating > 200;

-- 7. 	All customers who were either located in San Jose or had a rating above 200.
Select cname from cust where city = "San Jose" or rating > 200;

-- 8. 	All orders for more than $1000.
Select * from orders where amt > 1000;

-- 9. 	Names and citires of all salespeople in london with commission above 0.10.
Select sname, city from salespeople where comm > 0.10 and city = "London";

-- 10. 	All customers excluding those with rating <= 100 unless they are located in Rome.
Select cname from cust where rating <= 100 or city = "Rome";

-- 11. 	All salespeople either in Barcelona or in london.
Select sname, city from salespeople where city in ("Barcelona","London");

-- 12. 	All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
Select sname, comm from salespeople where comm > 0.10 and comm < 0.12;

-- 13. 	All customers with NULL values in city column.
Select cname from cust where city is null;

-- 14. 	All orders taken on Oct 3Rd   and Oct 4th  1994.
Select * from orders where odate in ('1994-10-03', '1994-10-04');

-- 15. 	All customers serviced by peel or Motika.
Select cname from cust where snum in (Select snum from salespeople Where sname in ('Peel', 'Motika'));

-- 16. 	All customers whose names begin with a letter from A to B.
Select cname from cust where cname like "A%" or cname like "B%";

-- 17. 	All orders except those with 0 or NULL value in amt field.
Select onum	from orders where amt != 0 or amt is not null;

-- 18. 	Count the number of salespeople currently listing orders in the order table.
Select count(distinct snum) from orders;

-- 19. 	Largest order taken by each salesperson, datewise.
Select odate, snum, max(amt) from orders group by odate, snum order by odate,snum;
	
-- 20. 	Largest order taken by each salesperson with order value more than $3000.
Select odate, snum, max(amt) from orders where amt > 3000 group by odate, snum order by odate,snum;

-- 21. 	Which day had the hightest total amount ordered.
Select odate, amt, snum, cnum from orders where amt = (select max(amt) from orders)

-- 22. 	Count all orders for Oct 3rd.
Select count(*) from orders where odate = "1994-10-03"; 

-- 23. 	Count the number of different non NULL city values in customers table.
Select count(distinct city) from cust;

-- 24. 	Select each customer’s smallest order.
Select cnum, min(amt) from orders group by cnum;

-- 25. 	First customer in alphabetical order whose name begins with G.
Select min(cname) from cust where cname like "G%";

-- 26. 	Get the output like “ For dd/mm/yy there are ___ orders.
Select date_format(odate, '%d/%m/%y') as Order_Date, 
concat('For ', date_format(odate, '%d/%m/%y'), ' there are ', 
count(*) , ' orders.') as Order_Summary from orders group by odate;

-- 27. 	Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
Select onum, snum, amt, amt * 0.12 from orders order by snum;

-- 28. 	Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).
Select city, max(rating) as Highest_Rating, 
concat('For the city ', city, ', the highest rating is : ', max(rating), '.') 
as Output_Message from cust group by city;
	
-- 29. 	Display the totals of orders for each day and place the results in descending order.
Select odate, count(onum) from orders group by odate order by count(onum);

-- 30. 	All combinations of salespeople and customers who shared a city. (ie same city).
Select sname, cname from salespeople, cust where salespeople.city = cust.city;

-- 31. 	Name of all customers matched with the salespeople serving them.
Select cname, sname from cust, salespeople where cust.snum = salespeople.snum;

-- 32. 	List each order number followed by the name of the customer who made the order.
Select onum, cname from orders, cust where orders.cnum = cust.cnum;

-- 33. 	Names of salesperson and customer for each order after the order number.
Select onum, sname, cname from orders, cust, salespeople where orders.cnum = cust.cnum and orders.snum = salespeople.snum;

-- 34.  Produce all customer serviced by salespeople with a commission above 12%.
Select cname, sname, comm from cust, salespeople where comm > 0.12 and cust.snum = salespeople.snum;

-- 35. 	Calculate the amount of the salesperson’s commission on each order with a rating above 100.
Select sname, amt * comm from orders, cust, salespeople where rating > 100 and
salespeople.snum = cust.snum and salespeople.snum = orders.snum and cust.cnum = orders.cnum

-- 36. 	Find all pairs of customers having the same rating.
Select a.cname, b.cname,a.rating from cust a, cust b where a.rating = b.rating and a.cnum != b.cnum

-- 37. 	Find all pairs of customers having the same rating, each pair coming once only.
Select a.cname, b.cname,a.rating from cust a, cust b where a.rating = b.rating 
and a.cnum != b.cnum and a.cnum < b.cnum;

-- 38. 	Policy is to assign three salesperson to each customers. Display all such combinations.
SELECT C.CNAME AS Customer, S1.SNAME AS Salesperson1, S2.SNAME AS Salesperson2, 
S3.SNAME AS Salesperson3 FROM CUST C, SALESPEOPLE S1, SALESPEOPLE S2, SALESPEOPLE S3 

-- 39. 	Display all customers located in cities where salesman serres has customer.
select * from cust where city in (select distinct city from cust 
where snum = (select snum from salespeople where sname = 'serres'));

-- 40.  Find all pairs of customers served by single salesperson.
Select cname, snum from cust where snum in (select snum from cust
group by snum having count(snum) > 1);

-- 41.  Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
Select a.sname, b.sname from salespeople a, salespeople b
where a.snum > b.snum and a.city = b.city;

-- 42. 	Produce all pairs of orders by given customer, names that customers and eliminates duplicates.
Select c.cname, a.onum, b.onum from orders a, orders b, cust c
where a.cnum = b.cnum and  a.onum > b.onum and c.cnum = a.cnum;

-- 43. 	Produce names and cities of all customers with the same rating as Hoffman.
Select cname, city from cust where rating = (select rating
from cust where cname = 'Hoffman') and cname != 'Hoffman';

-- 44. 	Extract all the orders of Motika.
Select Onum from orders where snum = ( select snum
from salespeople where sname = "Motika");
-- 45. 	All orders credited to the same salesperson who services Hoffman.
Select onum, sname, cname, amt from orders a, salespeople b, cust c where 
a.snum = b.snum and a.cnum = c.cnum and a.snum = ( select snum from 
orders where cnum = ( select cnum from cust where cname = 'Hoffman'));

-- 46. 	All orders that are greater than the average for Oct 4.
Select * from orders where amt > ( select avg(amt) 
from orders where odate = '1994-10-03');
	
-- 47. 	Find average commission of salespeople in london.
Select avg(comm) from salespeople where city = "London";

-- 48. 	Find all orders attributed to salespeople servicing customers in london.
Select snum, cnum from orders where cnum in (select cnum 
from cust where city = 'London');

-- 49. 	Extract commissions of all salespeople servicing customers in London.
Select comm from salespeople where snum in (select snum
from cust where city = "London");

-- 50. 	Find all customers whose cnum is 1000 above the snum of serres.
Select cnum, cname from cust where cnum > ( select snum+1000 
from salespeople where sname = 'Serres');

-- 51. 	Count the customers with rating  above San Jose’s average.
Select cnum, rating from cust where rating > ( select avg(rating) 
from cust where city = 'San Jose');

-- 52.	Obtain all orders for the customer named Cisnerous. (Assume you don’t know his customer no. (cnum)).
select * from orders 
where cnum = (select cnum from cust where cname = 'cisnerous');

-- 53.	Produce the names and rating of all customers who have above average orders.
select c.cname, c.rating from cust c join orders o on 
c.cnum = o.cnum group by c.cnum, c.cname, c.rating 
having avg(o.amt) > (select avg(amt) from orders);

-- 54.	Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
select s.snum, s.sname, sum(o.amt) as total_sales from salespeople s 
join orders o on s.snum = o.snum group by s.snum, s.sname
having sum(o.amt) > (select max(amt) from orders);

-- 55.	Find all customers with order on 3rd Oct.
select distinct c.* from cust c join orders o on c.cnum = o.cnum
where o.odate = '1994-10-03';

-- 56.	Find names and numbers of all salesperson who have more than one customer.
select s.snum, s.sname from salespeople s join cust c on s.snum = c.snum
group by s.snum, s.sname having count(distinct c.cnum) > 1;

-- 57.	Check if the correct salesperson was credited with each sale.
select o.onum, o.snum, c.snum from orders o 
join cust c on o.cnum = c.cnum where o.snum <> c.snum;

-- 58.	Find all orders with above average amounts for their customers.
select * from orders o where o.amt > 
(select avg(amt) from orders where cnum = o.cnum);

-- 59.	Find the sums of the amounts from order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount.
select odate, sum(amt) as total_amt from orders group by 
odate having sum(amt) >= (select max(amt) from orders) + 2000;

-- 60.	Find names and numbers of all customers with ratings equal to the maximum for their city.
select cnum, cname, city, rating 
from cust 
where rating = (select max(rating) from cust c2 where c2.city = cust.city);

-- 61.	Find all salespeople who have customers in their cities who they don’t service. ( Both way using Join and Correlated subquery.)
-- using join
select distinct s.snum, s.sname from salespeople s
join cust c on s.city = c.city and s.snum <> c.snum;
-- using correlated subquery
select * from salespeople s where exists (select 1 from cust c 
where c.city = s.city and c.snum <> s.snum);

-- 62.	Extract cnum,cname and city from customer table if and only if one or more of the customers in the table are located in San Jose.
select cnum, cname, city 
from cust 
where exists (select 1 from cust where city = 'san jose');

-- 63.	Find salespeople no. who have multiple customers.
select snum from cust group by snum having count(*) > 1;

-- 64.	Find salespeople number, name and city who have multiple customers.
select s.snum, s.sname, s.city from salespeople s 
where s.snum in (select snum from cust group by snum having count(*) > 1);

-- 65.	Find salespeople who serve only one customer.
select s.snum, s.sname from salespeople s 
where s.snum in (select snum from cust group by snum having count(*) = 1);

-- 66.	Extract rows of all salespeople with more than one current order.
select snum from orders group by snum having count(*) > 1;

-- 67.	Find all salespeople who have customers with a rating of 300. (use EXISTS)
select * from salespeople s where exists 
(select 1 from cust c where c.snum = s.snum and c.rating = 300);

-- 68.	Find all salespeople who have customers with a rating of 300. (use Join).
select distinct s.* from salespeople s join cust c on s.snum = c.snum 
where c.rating = 300;

-- 69.	Select all salespeople with customers located in their cities who are not assigned to them. (use EXISTS).
select * from salespeople s where exists (select 1 from 
cust c where c.city = s.city and c.snum <> s.snum);

-- 70.	Extract from customers table every customer assigned the a salesperson who currently has at least one other customer ( besides the customer being selected) with orders in order table.
select c.* from cust c where exists (select 1 from cust c2 join orders 
o on c2.cnum = o.cnum where c2.snum = c.snum and c2.cnum <> c.cnum);

-- 71.	Find salespeople with customers located in their cities ( using both ANY and IN).
-- using any 
select * from salespeople where city = any (select city from cust);
-- using in
select * from salespeople where city in (select city from cust);

-- 72.	Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
select * from salespeople s 
where s.sname < any (select cname from cust);

select * from salespeople s 
where exists (select 1 from cust c where c.cname > s.sname);

-- 73.	Select customers who have a greater rating than any customer in rome.
select * from cust where rating > any 
(select rating from cust where city = 'rome');

-- 74.	Select all orders that had amounts that were greater that atleast one of the orders from Oct 6th.
select * from orders where amt > any 
(select amt from orders where odate = '1994-10-06');

-- 75.	Find all orders with amounts smaller than any amount for a customer in San Jose. (Both using ANY and without ANY)
-- using any 
select * from orders where amt < any (select amt from orders 
where cnum in (select cnum from cust where city = 'san jose'));
-- without any
select * from orders o where amt < (select min(amt) from orders 
where cnum in (select cnum from cust where city = 'san jose'));

-- 76.	Select those customers whose ratings are higher than every customer in Paris. ( Using both ALL and NOT EXISTS).
-- using all
select * from cust where rating > all 
(select rating from cust where city = 'paris');
-- using not exists
select * from cust c1 where not exists (select 1 from cust c2 
where c2.city = 'paris' and c1.rating <= c2.rating);

-- 77.	Select all customers whose ratings are equal to or greater than ANY of the Seeres.
select * from cust 
where rating >= any (select rating from cust where cname = 'seeres');

-- 78.	Find all salespeople who have no customers located in their city. ( Both using ANY and ALL)
-- using any
select * from salespeople where city <> any (select city from cust);
-- using all
select * from salespeople s where s.city <> all (select city from cust);

-- 79.	Find all orders for amounts greater than any for the customers in London.
select * from orders where amt > any (select amt from orders 
where cnum in (select cnum from cust where city = 'london'));

-- 80.	Find all salespeople and customers located in london.
(select 'salesperson' as type, s.snum as num, s.sname as name, s.city 
from salespeople s where s.city = 'london') 
union 
(select 'customer' as type, c.cnum as num, c.cname as name, c.city 
from cust c where c.city = 'london');

-- 81.	For every salesperson, dates on which highest and lowest orders were brought.
select o.snum, min(o.odate) as lowest_order_date, 
max(o.odate) as highest_order_date from orders o group by o.snum;

-- 82.	List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
select s.snum, s.sname, s.city, case 
when exists (select 1 from cust c where c.city = s.city) 
then 'has customers' else 'no customers' 
end as customer_status from salespeople s;

-- 83.	Append strings to the selected fields, indicating weather or not a given salesperson was matched to a customer in his city.
select s.snum, s.sname, s.city, case 
when exists (select 1 from cust c where c.city = s.city) 
then concat(s.sname, ' - matched') else concat(s.sname, ' - not matched') 
end as status from salespeople s;

-- 84.	Create a union of two queries that shows the names, cities and ratings of all customers. Those with a rating of 200 or greater will also have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
(select cname, city, rating, 'High Rating' as category 
 from cust where rating >= 200) union 
(select cname, city, rating, 'Low Rating' as category 
 from cust where rating < 200);

-- 85.	Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
(select s.snum as num, s.sname as name from salespeople s 
 where s.snum in (select snum from orders group by snum having count(*) > 1)) 
union (select c.cnum as num, c.cname as name from cust c where c.cnum in 
(select cnum from orders group by cnum having count(*) > 1)) order by name;

-- 86.	Form a union of three queries. Have the first select the snums of all salespeople in San Jose, then second the cnums of all customers in San Jose and the third the onums of all orders on Oct. 3. Retain duplicates between the last two queries, but eliminates and redundancies between either of them and the first.
(select snum from salespeople where city = 'san jose') union all 
(select cnum from cust where city = 'san jose') union 
(select onum from orders where odate = '1994-10-03');

-- 87.	Produce all the salesperson in London who had at least one customer there.
select * from salespeople s where s.city = 'london' 
and exists (select 1 from cust c where c.city = 'london' and c.snum = s.snum);

-- 88.	Produce all the salesperson in London who did not have customers there.
select * from salespeople s where s.city = 'london' 
and not exists (select 1 from cust c where c.city = 'london' and c.snum = s.snum);

-- 89.	We want to see salespeople matched to their customers without excluding those salesperson who were not currently assigned to any customers. (User OUTER join and UNION)
select s.snum, s.sname, s.city, c.cnum, c.cname 
from salespeople s left join cust c on s.snum = c.snum;

(select s.snum, s.sname, s.city, c.cnum, c.cname 
from salespeople s join cust c on s.snum = c.snum) 
union 
(select s.snum, s.sname, s.city, null as cnum, null as cname from salespeople s 
 where not exists (select 1 from cust c where c.snum = s.snum));
