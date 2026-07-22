-- List of Orders and Menu Items: 
-- Lists the orders placed on a specific given reservation along with the associated menu items.
SELECT
    [order].order_id,
    [order].date AS order_date,
    menu_item.item_id,
    menu_item.name AS menu_item,
    order_item.qty,
    menu_item.price,
    (order_item.qty * menu_item.price) AS subtotal
FROM reservation
JOIN [order]
    ON reservation.res_id = [order].res_id
JOIN order_item
    ON [order].order_id = order_item.order_id
JOIN menu_item
    ON order_item.item_id = menu_item.item_id
WHERE reservation.res_id = 4
ORDER BY [order].order_id, menu_item.name;