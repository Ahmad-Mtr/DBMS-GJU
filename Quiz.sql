/*Get the CatalogID, SKU_Description, and DateOnWebSite from the CATALOG_SKU_2021 table,
  and the QuantityOnHand from the INVENTORY table
  for items with positive quantities on hand.*/

  select CatalogID, i.SKU_Description, DateOnWebSite, QuantityOnHand from catalog_sku_2021 as Ctlg JOIN inventory as i on i.SKU = Ctlg.SKU
  where  i.QuantityOnHand > 0;