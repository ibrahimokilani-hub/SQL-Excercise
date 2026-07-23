-- 14. **Stored Procedure - Add New Order**:
--     - **Procedure Name**: **`sp_AddNewOrder`**
--     - **Purpose**: Streamline the process of adding a new order.
--     - **Parameters**: **`ReservationId`**, **`EmployeeId`**, **`OrderDate`**, and **`TotalAmount`**.
--     - **Implementation**: Check if the specified reservation and employee exist, if not,
--     -   return an error message, if existing, add new order.
--     - **Return**: The new **`BorrowerID`** or an error message.

drop PROCEDURE IF EXISTS  sp_AddNewOrder;
GO
create PROCEDURE sp_AddNewOrder (
    @ReservationId int,
    @EmployeeId int, 
    @OrderDate DATETIME2,
    @TotalAmount DECIMAL(10, 2),
    @OrderId INT OUTPUT
) as BEGIN
        SET NOCOUNT ON; -- to not get the (1 row affected message)
        if not EXISTS (
            select 1 from reservation where res_id = @ReservationId
            )
            THROW 50001, 'Reservation not found.', 1;

        if not exists (
            SELECT 1 from employee where emp_id = @EmployeeId
            )
            THROW 50002, 'Employee not found.', 1;

        insert into [order] (
            res_id,
            emp_id,
            [date],
            total
        ) VALUEs (
            @ReservationId,
            @EmployeeId,
            @OrderDate,
            @TotalAmount
        )
        SET @OrderId = SCOPE_IDENTITY();
        SELECT @OrderId AS OrderId; 
     END;
