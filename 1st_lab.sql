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
where  SKU_Description LIKE '__d%';

-- 3.
select COUNT(QuantityOnHand) as Quantity,MIN(QuantityOnHand) as MIN, MAX(QuantityOnHand) as MAX, SUM(QuantityOnHand) as SUM,
       AVG(QuantityOnHand) as AVG
    from inventory;

-- 4.
# ALTER TABLE order_item ADD Total_Price_Product int;       # this used to to create a new column in which every row is quantity of product * price
# update order_item set order_item.Total_Price_Product = Quantity * Price;
select COUNT(Quantity) as Quantity_of_Orders, SUM(Total_Price_Product) as Total_Price_All   #Count is used to count the number of rows for a single column, while SUM() return the summation of the values in the selected column
from order_item;


-- 5.
select WarehouseID, SUM(QuantityOnHand) as TotalitemsonHandLT3 from inventory # select W..ID, SUM(Q_onHand) as TIHLT3
where QuantityOnHand < 3    # Omit items Q_Hand >= 3
group by WarehouseID    # group W_ID
having TotalitemsonHandLT3 < 2  # show TIHLT3 < 2
order by TotalitemsonHandLT3 DESC;

