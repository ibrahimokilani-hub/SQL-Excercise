-- ran
create table customer 
(
  cust_id int IDENTITY(1,1) primary key,
  first_name varchar(20),
  last_name varchar(20),
  email varchar(20),
  phone varchar(20)
)
-- ran
create table restaurant 
(
  rest_id int IDENTITY(1,1) primary key,
  name varchar(20),
  address varchar(20),
  opening_hours varchar(20),
  phone varchar(20)
)
-- ran
create table employee 
(
  emp_id int IDENTITY(1,1) primary key,
  first_name varchar(20),
  last_name varchar(20),
  rest_id int,
  position varchar(20),
  constraint fk_emp_rest
  foreign key (rest_id)
  references restaurant(rest_id)
)

  -- ran
create table [table]
(
  table_id int IDENTITY(1,1) primary key,
  capacity int,
  rest_id int,
  position varchar(20),
  constraint fk_restaurant
  foreign key (rest_id)
  references restaurant(rest_id)
)
----------------------------------------
create table menu_item (
  item_id int IDENTITY(1,1) primary key,
  rest_id int,
  name varchar(20),
  price DECIMAL(10, 2),
  constraint fk_item_rest
  foreign key (rest_id)
  references restaurant(rest_id)
)
-----------------------------------
create table [reservation]
(
  res_id int IDENTITY(1,1) primary key,
  cust_id int,
  rest_id int ,
  date timestamp,
  party_size int,
  constraint fk_res_rest
  foreign key (rest_id)
  references restaurant(rest_id),
  constraint fk_res_cust
  foreign key (cust_id)
  references customer(cust_id)
)

------------
  -- ran
create table [order]
(
  order_id int IDENTITY(1,1) primary key,
  res_id int,
  emp_id int ,
  date timestamp,
  total DECIMAL(10, 2),
  constraint fk_order_res
  foreign key (res_id)
  references reservation(res_id),
  constraint fk_order_emp
  foreign key (emp_id)
  references employee(emp_id)
)
---------------------
create table [order_item]
(
  order_id int,
  item_id int,
  qty int,
  primary key(order_id, item_id)
)