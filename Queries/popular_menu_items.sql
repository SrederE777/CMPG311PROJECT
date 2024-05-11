SELECT m.menu_item_name, SUM(ca.MENU_ITEM_AMOUNT*m.menu_item_price) AS TotalRevenuePerItem
FROM menu_item m
JOIN cafe_transaction ca ON m.MENU_ITEM_ID = ca.MENU_ITEM_ID
GROUP BY m.MENU_ITEM_NAME;
