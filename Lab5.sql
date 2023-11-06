-- 1. List the Phone and FirstName of all customers order descending by REFERREDBY.
select Phone, FirstName
from customer
order by ReferredBy DESC;
-- 2. List the Phone and LastName for all customers with a FirstName of “Betsy”.
select Phone, LastName
from customer
where FirstName = 'Betsy';
-- 3. List the Phone, DateIn, and DateOut of all orders in excess of 50.
select Phone, DateIn, DateOut
from invoice
         JOIN customer as c on invoice.CustomerID = c.CustomerID
where TotalAmount > 50;
-- 4. List the Phone and FirstName of all customers whose last name starts with 'M'.
select Phone, FirstName
from customer
where LastName LIKE 'M%';
-- 5. List the Phone and FirstName of all customers whose last name includes the characters, 'cat'.
select Phone, FirstName
from customer
where LastName LIKE '%cat%';
-- 6. List the Phone, FirstName, and LastName for all customers whose fifth and sixth numbers of their phone number are 54.
select Phone, FirstName, LastName
from customer
where Phone LIKE '____54%';
-- 7. Determine the maximum and minimum TotalAmounts.
select MAX(TotalAmount), MIN(TotalAmount)
from invoice;
-- 8. Determine the average TotalAmount. Give me the output result only result two digits (ex:655.78).
select ROUND(AVG(TotalAmount), 2)
from invoice
;
-- 9. Count the number of customers.
select COUNT(CustomerID)
from customer;
-- 10. List CustomerID and minimum TotalAmount Group the customers by CustomerID.
select CustomerID, MIN(TotalAmount)
from invoice
group by CustomerID;
-- 11. List all invoicenumbers that DateIn occurred before ‘Oct-12-2021’.
select InvoiceNumber
from invoice
where DateIn < '2021-10-12';
-- 12. List all items that have been DateOut on ‘Oct-11-2021’.
select *
from invoice_item
         JOIN invoice i on invoice_item.InvoiceNumber = i.InvoiceNumber
where DateOut = '2021-10-11'
;
-- 13. Show the customerID, maximum and minimum TotalAmounts of the customers which having maximum TotalAmounts greater than 99.
select CustomerID, MAX(TotalAmount) as MAX_TA, min(TotalAmount) as MIN_TA
from invoice
group by CustomerID
HAVING MAX_TA > 99;
-- 14. Show the FirstName and LastName of all customers who have had an order with TotalAmount greater than 90. Use a subquery.
--     Present the results sorted by LastName in ascending order and then FirstName in descending order.
select FirstName, LastName
from customer
where CustomerID in (select CustomerID from invoice where TotalAmount > 90)
order by LastName ASC, FirstName DESC;
-- 15. Show the FirstName and LastName of all customers who have had an order with TotalAmount greater than 100. Use a join.
--     Present the results sorted by LastName in ascending order and then FirstName in descending order.
select FirstName, LastName
from customer
         JOIN invoice i on customer.CustomerID = i.CustomerID
where TotalAmount > 100
order by LastName ASC, FirstName DESC;
-- 16. Show the FirstName and LastName of all customers who have had an order with an Item named “Dress Shirt”.
-- Use a subquery. Present the results sorted by LastName in ascending order and then FirstName in descending order.
select FirstName, LastName
from customer
where CustomerID in (select CustomerID
                     from invoice
                     where InvoiceNumber in (select InvoiceNumber from invoice_item where Item = 'Dress Shirt'))
order by LastName ASC, FirstName DESC;

-- 17. Show the FirstName and LastName of all customers who have had an order with an Item named “Blouse”.
-- Use a join. Present the results sorted by LastName in ascending order and then FirstName in descending order.
select FirstName, LastName
from customer
         JOIN invoice i on customer.CustomerID = i.CustomerID JOIN invoice_item on i.InvoiceNumber = invoice_item.InvoiceNumber
where Item = 'Dress Shirt'
;

-- 18. Show the FirstName, LastName and TotalAmount of all customers who have had an order with an Item named “Dress Shirt”.
-- Use a join with a subquery. Present results sorted by LastName in ascending order and then FirstName in descending order.
select FirstName, LastName
from customer
         JOIN invoice i on customer.CustomerID = i.CustomerID
where i.InvoiceNumber in (select InvoiceNumber from invoice_item where Item = 'Dress Shirt');