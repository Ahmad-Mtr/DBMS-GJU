-- Question 1
select *
from inventory;
select SKU, SKU_Description
from inventory;
select distinct WarehouseID
from inventory;
select WarehouseID, SKU, SKU_Description, QuantityOnHand, QuantityOnOrder
from inventory;

-- Question 2
-- 1.
select * from inventory
where QuantityOnOrder > 0;

-- 2.
select SKU, SKU_Description, WarehouseID from inventory
where QuantityOnHand = 0
order by WarehouseID DESC, SKU ASC;

-- 3.
select SKU,SKU_Description from inventory
where QuantityOnHand =0 OR QuantityOnOrder = 0;

-- 4.
 select SKU, SKU_Description from inventory
 inner join warehouse ON warehouse.WarehouseID = inventory.WarehouseID
 where  WarehouseCity IN ('Seattle','Chicago','New Jersey');

-- 5.
select SKU, SKU_Description from inventory
 inner join warehouse ON warehouse.WarehouseID = inventory.WarehouseID
 where  WarehouseCity NOT IN ('Seattle','Atlanta','New Jersey');

-- 6.
select SKU, SKU_Description, QuantityOnHand from inventory
 where  QuantityOnHand between 10 AND 50;

-- 7.
select SKU, SKU_Description from inventory
 where  SKU_Description LIKE 'Locking%';

-- Question 3.
-- 1.
select distinct SKU, SKU_Description from inventory
where  SKU_Description LIKE '%Climb%';

-- 2.
select distinct SKU, SKU_Description from inventory
where  SKU_Description LIKE '%__d%';

-- 3.
select COUNT(QuantityOnHand) as Quantity,MIN(QuantityOnHand) as MIN, MAX(QuantityOnHand) as MAX, SUM(QuantityOnHand) as SUM,
       AVG(QuantityOnHand) as AVG
    from inventory;

-- 4.
ALTER TABLE order_item ADD Total_Price_Product int;
update order_item set order_item.Total_Price_Product = Quantity * Price;
select COUNT(Quantity) as Quantity_of_Orders, SUM(Total_Price_Product) as Total_Price_All from order_item;


-- 5.
SELECT w.WarehouseID, SUM(i.QuantityOnHand) AS TotalItemsOnHandLT3
FROM warehouse w
JOIN inventory i ON w.WarehouseID = i.WarehouseID
WHERE i.SKU NOT IN (
   select i.SKU from inventory where QuantityOnHand >= 3
)
GROUP BY w.WarehouseID
HAVING COUNT(DISTINCT i.SKU) < 2
ORDER BY TotalItemsOnHandLT3 DESC;

/* TOTHANDLT3
Write an SQL statement to display the WarehouseID and the sum of QuantityOnHand grouped by
WarehouseID. Omit all SKU items that have three or more items on hand from the sum, and name
the sum TotalItemsOnHandLT3. Show the Warehouse ID only for warehouses having fewer than two
SKUs in their TotalItemsOnHandLT3. Display the results in descending order of
TotalItemsOnHandLT3.

 sum of QOHand
 omit SKU >= 3
 show warehouse iff num of sku s < 2
 display total DESC
 */