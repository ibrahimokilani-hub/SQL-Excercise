-- Restaurant Popularity using Aggregation: Rank restaurants by the reservation frequency.

select restaurant.rest_id as RestaurantID, restaurant.name as [Restaurant Name],
COUNT(reservation.res_id) as Reservations
from restaurant
JOIN reservation on reservation.rest_id = restaurant.rest_id
GROUP BY restaurant.rest_id, restaurant.name
ORDER BY Reservations desc;