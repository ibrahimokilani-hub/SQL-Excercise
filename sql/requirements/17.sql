-- 17. Query Plans Part1:
--     1. Select 5 complex queries from the above queries and check their query plans.

-- HOW? => 
-----------------------------------------
--  SET SHOWPLAN_TEXT ON;
--  GO
----
--  GO
--  SET SHOWPLAN_TEXT OFF;
-------------------------------------------

SET SHOWPLAN_TEXT ON;
GO
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

GO
SET SHOWPLAN_TEXT OFF;

--------------------------------------------------------------------------

SET SHOWPLAN_TEXT ON;
GO
select employee.emp_id as EmployeeID,
employee.first_name + ' ' + employee.last_name as [Employee Name],
employee.[position] as [Employee Position],
restaurant.name as [Restaurant],
restaurant.address + ', ' + restaurant.phone as [Address, Phone],
restaurant.opening_hours as [Restaurant opening hours]

from employee JOIN restaurant on employee.rest_id = restaurant.rest_id 

GO
SET SHOWPLAN_TEXT OFF;

----------------------------------------------------------------

SET SHOWPLAN_TEXT ON;
GO
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
GO
SET SHOWPLAN_TEXT OFF;

-----------------------------------------------------------------------

SET SHOWPLAN_TEXT ON;
GO
select employee.emp_id, employee.first_name + ' ' + employee.last_name as 'Employee name', 
avg([order].total) as 'Average amount by employee'
from [order] join employee on [order].emp_id = employee.emp_id
GROUP by employee.emp_id, employee.first_name, employee.last_name;
GO
SET SHOWPLAN_TEXT OFF;

---------------------------------------------------------------------------

SET SHOWPLAN_TEXT ON;
GO
SELECT reservation.res_id AS ReservationID,
reservation.[date] AS [Reservation Date],
reservation.party_size AS [Party Size],
restaurant.name AS [Restaurant],
restaurant.address AS [Address],
restaurant.phone AS [Restaurant Contact],
restaurant.opening_hours AS [Restaurant Opening hrs],
customer.first_name + ' ' + customer.last_name AS [Customer Name],
customer.email AS [Customer Email],
customer.phone AS [Customer Phone]

FROM reservation 
JOIN restaurant ON reservation.rest_id = restaurant.rest_id
JOIN customer ON reservation.cust_id = customer.cust_id
GO
SET SHOWPLAN_TEXT OFF;