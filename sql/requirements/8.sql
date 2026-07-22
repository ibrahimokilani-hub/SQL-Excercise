-- Reservation’s Order with CTEs: Identify reservations which have 2 or more orders using CTEs.

with cte_reservation as (
    select reservation.res_id as ReservationId,
    reservation.date as [Reservation Date],
    COUNT([order].order_id) as OrderCount

    from reservation JOIN [order] on reservation.res_id = [order].res_id
    GROUP by reservation.res_id, reservation.date
    having COUNT([order].order_id) > 1
)

select * from cte_reservation;