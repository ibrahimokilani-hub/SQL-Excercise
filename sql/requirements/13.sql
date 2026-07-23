-- 13. **Stored Procedure - Borrowed Books Report**:
--     - **Procedure Name**: **`sp_ResrvedTablesReport`**
--     - **Purpose**: Generate a report of tables reserved within a specified date range.
--     - **Parameters**: **`StartDate`**, **`EndDate`**
--     - **Implementation**: Retrieve all tables reserved within the given range,
--     -   with details like reservation date, party size and restaurant details.
--     - **Return**: Tabulated report of reserved tables

drop PROCEDURE IF EXISTS sp_ResrvedTablesReport;
GO
CREATE PROCEDURE sp_ResrvedTablesReport (@StartDate DATE, @EndDate DATE)
as BEGIN
    select reservation.date as [Reservation Date], 
    reservation.party_size as [Party Size], [table].table_id as [Table Id],
    restaurant.name as [Restaurant Name], restaurant.opening_hours as [Rest Opening Hours]
    from reservation 
    JOIN [table] on [table].table_id = reservation.table_id
    JOIN restaurant on restaurant.rest_id = [table].rest_id
 WHERE 
        reservation.[date] >= @StartDate 
        AND reservation.[date] < DATEADD(day, 1, @EndDate);
END;

EXEC sp_ResrvedTablesReport '2006-07-13', '2006-07-15';