-- List of Ordered Menu Items: Lists the menu items ordered by a specific reservation.
SELECT
    menu_item.item_id,
    menu_item.name AS menu_item,
    order_item.qty,
    menu_item.price
    FROM reservation
JOIN [order]
    ON reservation.res_id = [order].res_id
JOIN order_item
    ON [order].order_id = order_item.order_id
JOIN menu_item
    ON order_item.item_id = menu_item.item_id
WHERE reservation.res_id = 4
ORDER BY menu_item.price, menu_item.name;