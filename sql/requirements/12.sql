-- 12. **Database Function - Calculate Employees Salary**:
--     - **Function Name**: **`fn_CalculateEmployeeSalary`**
--     - **Purpose**: Compute the salary for a given employee.
--     - **Parameter**: `EmployeeId`
--     - **Implementation**: Salary is defined as: 
          -- # number of orders made by specific employee * employee rank.
--         - Employee’s rank based on position: 
          -- Position = `VIPOrdersWaiter` = 5, `StandardWaiter` = 4, `AssistantWaiter`  = 3.
--     - **Return**: salary for the `EmployeeId`.

create function fn_CalculateEmployeeSalary(@EmployeeId int)
returns decimal(10, 2)
begin
    return (
        select 
            case 
                when employee.position = 'VIPOrdersWaiter' then count([order].order_id) * 5 
                when employee.position = 'StandardWaiter' then count([order].order_id) * 4 
                when employee.position = 'AssistantWaiter' then count([order].order_id) * 3 
            end as Salary
        from [order]
        join employee on employee.emp_id = [order].emp_id
        GROUP by employee.emp_id, employee.position
        having employee.emp_id = @EmployeeId
    );
end;