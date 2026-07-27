-- 18. Indexing: Make Tech-Lib Faster
--     1. Create the needed Indexes to the Tech-Lib project you built earlier.

------------ RESERVATION -------------
create INDEX idx_res_rest_id
on reservation (rest_id);

create INDEX idx_res_cust_id
on reservation (cust_id);

------------ ORDER -------------
create INDEX idx_order_res_id
on [order] (res_id);

create INDEX idx_order_date
on [order] ([date]);

create INDEX idx_order_emp_id
on  [order] (emp_id);


------------ EMPLOYEE -------------
create INDEX idx_emp_rest_id
on employee (rest_id);



