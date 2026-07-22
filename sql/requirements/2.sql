-- List of Managers: Retrieve all employees holding Manager position.
select emp_id as ID, first_name + ' ' + last_name as [Full Name], [position]
from employee
where [position] = 'Manager';