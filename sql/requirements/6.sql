-- Retrieve Reservations Report with Views:
-- Use a view to list all reservations information including restaurants and customers information.

CREATE VIEW Reservation_Report AS
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