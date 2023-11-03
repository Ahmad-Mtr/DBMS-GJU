-- 1.
select max(SquareFeet), min(SquareFeet)
from warehouse;
-- 2.
select QuantityOnHand
from inventory
where QuantityOnHand > QuantityOnOrder;
-- 3.
select OrderNumber
from retail_order
where OrderYear = 2020;
-- 4.
select SKU_Description
from inventory
where WarehouseID in (select warehouse.WarehouseID from warehouse where Manager = 'Dave Jones');
-- 5.
select OrderNumber, SKU
from order_item
where Price between 130 AND 300;
-- 6
select SKU_Description
from inventory
where QuantityOnOrder > 0
  AND QuantityOnHand = 0;
-- 7.
select WarehouseCity, sum(QuantityOnOrder), sum(QuantityOnHand)
from inventory
         JOIN warehouse on inventory.WarehouseID = warehouse.WarehouseID
group by WarehouseCity;
-- 8.    // Results are 2 rows that have highest QuantityOO where there's a common SKU in inventory <--> order_item
select distinct SKU_Description
from inventory
         JOIN order_item on inventory.SKU = order_item.SKU
where QuantityOnOrder in (select MAX(QuantityOnOrder)
                          from inventory,
                               order_item
                          where order_item.SKU = inventory.SKU);

-- 9.
select SKU, SKU_Description, warehouse.WarehouseID, WarehouseCity, WarehouseState
from inventory
         JOIN warehouse
              on inventory.WarehouseID = warehouse.WarehouseID
where WarehouseCity != 'Atlanta'
  aND WarehouseCity != 'Bangor'
  aND WarehouseCity != 'Chicago'
;
-- 10.
select SKU, SKU_Description, WarehouseID
from inventory
where WarehouseID IN (select WarehouseID from warehouse where Manager = 'Dave Jones');
-- 11.
select SKU, SKU_Description, i.WarehouseID
from inventory as i
         JOIN warehouse
where i.WarehouseID = warehouse.WarehouseID
  AND i.WarehouseID IN (select WarehouseID from warehouse where Manager = 'Lucille Smith');
-- 12.
/*Write an SQL statement to show the SKU, SKU_Description, and WarehouseID for all items stored in a warehouse managed by ‘Lucille Smith’. Use a join using JOIN ON syntax. (8 rows). NOTE: The symbol for “not equal to” is <>.*/
select SKU, SKU_Description, i.WarehouseID
from inventory as i
         JOIN warehouse on i.WarehouseID = warehouse.WarehouseID
where i.WarehouseID IN (select WarehouseID from warehouse where Manager = 'Lucille Smith');
-- 13.
select (SKU_Description + ' is located in ' + WarehouseCity) as itemLocation
from inventory
         JOIN warehouse on inventory.WarehouseID = warehouse.WarehouseID
-- 14.
select WarehouseID, AVG(QuantityOnHand) as AverageQuantityOnHand
from inventory
where WarehouseID in (select WarehouseID from warehouse where Manager = 'Lucille Smith')
group by WarehouseID;
