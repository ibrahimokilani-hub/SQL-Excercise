-- 15. **SQL Stored Procedure with Temp Table**:
--     - Design a stored procedure that retrieves all tables which have future reservations. 
--     - Store these tables in a temporary table, 
--     - then join this temp table with the **`Restaurants`** table
--     - to list out the specific information about the associated restaurants.

drop PROCEDURE IF EXISTS  sp_AddNewOrder;
GO
create PROCEDURE sp_AddNewOrder as
    begin
        select [table].table_id,
               [table].rest_id,
               [table].[position],
               reservation.[date],
               reservation.party_size
        INTO #EmployeeTemp
        from [table] 
        join reservation on reservation.table_id = [table].table_id
        where reservation.[date] > SYSDATETIME();

        select *, restaurant.name as [Restaurant name], restaurant.opening_hours from #EmployeeTemp
        join restaurant on restaurant.rest_id = #EmployeeTemp.rest_id
    end;