-- Retrieve Employees details with Views: 
-- Use a view to list all employees information including their restaurants details
create VIEW [Employees_Details] as
select employee.emp_id as EmployeeID,
employee.first_name + ' ' + employee.last_name as [Employee Name],
employee.[position] as [Employee Position],
restaurant.name as [Restaurant],
restaurant.address + ', ' + restaurant.phone as [Address, Phone],
restaurant.opening_hours as [Restaurant opening hours]

from employee JOIN restaurant on employee.rest_id = restaurant.rest_id 
