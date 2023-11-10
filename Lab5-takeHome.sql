use mdc_ch02;
-- 1. Show the LastName, FirstName, Phone, and TotalAmount of all customer orders that included an Item named “Dress Shirt”.
-- Also show the LastName, FirstName, and Phone of all other customers. Present results sorted by TotalAmount in ascending order,
-- then LastName in ascending order, and then FirstName in descending order.
select a.LastName, a.FirstName, a.Phone, b.TotalAmount
from customer a
         left join invoice b on a.CustomerID = b.CustomerID
where b.InvoiceNumber in (select InvoiceNumber
                          from invoice_item
                          where item = 'Dress Shirt') or b.InvoiceNumber in (select InvoiceNumber
                          from invoice_item
                          where item != 'Dress Shirt')
order by b.TotalAmount asc, a.LastName asc, a.FirstName DESC
;

-- Write an SQL statement to join WAREHOUSE and INVENTORY and include all rows of WAREHOUSE in your answer, regardless of whether they have any INVENTORY.
-- Include all columns of both tables, but do not repeat the join columns.
select w.WarehouseID
     , WarehouseCity
     , WarehouseState
     , Manager
     , SquareFeet
     , SKU
     , SKU_Description
     , QuantityOnHand
     , QuantityOnOrder
from warehouse w
         left join inventory i on w.WarehouseID = i.WarehouseID;
-- 3. 3. Write an SQL statement to display the SKU, SKU_Description, and Department of all SKUs that appear in either the Cape Codd 2019 Catalog
--    (either in the printed catalog or on the Web site)
--   or the Cape Codd 2020 catalog (either in the printed catalog or on the Web site) or both.
select SKU, SKU_Description, Department, DateOnWebSite
from catalog_sku_2019
where CatalogPage != null or DateOnWebSite LIKE ('2019-__-__')
UNION
select SKU, SKU_Description, Department,DateOnWebSite
from catalog_sku_2020 where CatalogPage != null or DateOnWebSite LIKE ('2020-__-__');

