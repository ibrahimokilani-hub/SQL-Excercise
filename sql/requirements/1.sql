-- List of Reservations: Retrieve all reservations for a specific customers
Select res.res_id as ReservationID, 
cust.first_name + ' ' + cust.last_name as [Customer Name],
res.date,
res.party_size
from reservation res join customer cust
on res.cust_id = cust.cust_id;