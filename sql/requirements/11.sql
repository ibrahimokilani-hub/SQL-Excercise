-- 11. **Database Function - Calculate Restaurant Revenue**:
    -- **Function Name**: **`fn_CalculateRevenue`**
    -- **Purpose**: Compute revenue made by a specific restaurant.
    -- **Parameter**: `RestaurantId`
    -- **Return**: total revenue amount for the `RestaurantId` .

create FUNCTION fn_CalculateRevenue (@RestaurantId int)
returns decimal(10, 2) as
begin
    return
    (
        select ISNULL(SUM([order].total), 0) as [Total]
        from [ORDER] 
            join reservation on reservation.res_id = [order].res_id
            join restaurant on restaurant.rest_id = reservation.rest_id
        GROUP BY restaurant.rest_id 
            having restaurant.rest_id = @RestaurantId
    );
end;
