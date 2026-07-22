-- 10. Popular Menu Item Analysis using Joins and Window Functions: 
-- Identify the most popular menu item for each restaurant for a given month.

  WITH MenuPopularity AS
(
    SELECT 
        restaurant.rest_id AS RestaurantID,
        restaurant.name AS [Restaurant Name],
        menu_item.name AS [Menu Item],
        SUM(order_item.qty) AS [Total Ordered],
        ROW_NUMBER() OVER
        (
            PARTITION BY restaurant.rest_id
            ORDER BY SUM(order_item.qty) DESC
        ) AS rn
    FROM restaurant
    JOIN reservation 
        ON reservation.rest_id = restaurant.rest_id
    JOIN [order] 
        ON [order].res_id = reservation.res_id
    JOIN order_item 
        ON order_item.order_id = [order].order_id
    JOIN menu_item 
        ON order_item.item_id = menu_item.item_id
    WHERE [order].date >= '2026-07-01'
      AND [order].date < '2026-08-01'
    GROUP BY 
        restaurant.rest_id,
        restaurant.name,
        menu_item.name
)

SELECT 
    RestaurantID,
    [Restaurant Name],
    [Menu Item],
    [Total Ordered]
FROM MenuPopularity
WHERE rn = 1;