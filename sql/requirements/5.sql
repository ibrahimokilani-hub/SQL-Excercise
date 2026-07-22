-- Calculate Average Order Amount: Calculate the average order amount made through a specific employee.
select employee.emp_id, employee.first_name + ' ' + employee.last_name as 'Employee name', 
avg([order].total) as 'Average amount by employee'
from [order] join employee on [order].emp_id = employee.emp_id
GROUP by employee.emp_id, employee.first_name, employee.last_name;