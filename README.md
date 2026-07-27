# Restaurant Reservation Management System (RRMS)

## Project Overview

This project is a comprehensive SQL database solution for managing restaurant reservations, orders, employees, and customers. It demonstrates advanced SQL concepts including complex joins, window functions, CTEs, stored procedures, functions, triggers, views, and indexing strategies. The project is designed as both a functional system and an educational resource for SQL best practices.

**Database Name**: `RRMS`  
**Type**: SQL Server  
**Purpose**: Educational SQL learning project with real-world restaurant management scenarios

---

## Database Schema

### Entity-Relationship Diagram

The database consists of 9 core tables with relationships defining the restaurant operations:

<img src="https://uy72c4h5tn.ufs.sh/f/gJoKQO0MpkVvkNRhutOOUI6EGYn54rCiqj0RT7ga9X3ctKuM" alt="Entity-Relationship Diagram" />

```
Audit_Log (logging table for reservations)
```

### Core Tables

| Table | Purpose | Key Fields |
|-------|---------|-----------|
| **customer** | Stores customer information | cust_id (PK), first_name, last_name, email, phone |
| **restaurant** | Stores restaurant details | rest_id (PK), name, address, opening_hours, phone |
| **employee** | Stores employee information linked to restaurants | emp_id (PK), first_name, last_name, rest_id (FK), position |
| **table** | Stores dining table details per restaurant | table_id (PK), capacity, rest_id (FK), position |
| **reservation** | Core booking system linking customers to tables | res_id (PK), cust_id (FK), rest_id (FK), table_id (FK), date, party_size |
| **menu_item** | Stores menu items for each restaurant | item_id (PK), rest_id (FK), name, price |
| **order** | Captures orders placed for reservations | order_id (PK), res_id (FK), emp_id (FK), date, total |
| **order_item** | Junction table for items in orders | order_id (FK), item_id (FK), qty |
| **audit_log** | Audit trail for table reservations | log_id (PK), rest_id, table_id, reservation_date, change_date |

### Foreign Key Relationships

- `reservation.rest_id` → `restaurant.rest_id`
- `reservation.cust_id` → `customer.cust_id`
- `reservation.table_id` → `table.table_id`
- `order.res_id` → `reservation.res_id`
- `order.emp_id` → `employee.emp_id`
- `order_item.order_id` → `order.order_id`
- `order_item.item_id` → `menu_item.item_id`
- `menu_item.rest_id` → `restaurant.rest_id`
- `table.rest_id` → `restaurant.rest_id`
- `employee.rest_id` → `restaurant.rest_id`

---

## Project Structure

### `/sql/prepare/` - Database Initialization

Scripts that set up the database schema and seed data. **Execute in order**.

#### 1. **01_create_database.sql**
- **Purpose**: Creates the `RRMS` database
- **Rationale**: Foundation step that initializes the database instance
- **Contents**: Single CREATE DATABASE statement

#### 2. **02_create_tables.sql**
- **Purpose**: Defines all 8 core tables with primary keys, foreign keys, and constraints
- **Rationale**: Establishes the relational schema with proper integrity constraints
- **Key Features**:
  - IDENTITY columns for auto-incrementing primary keys
  - Foreign key constraints for referential integrity
  - Data type definitions optimized for restaurant data
  - Comments marking which statements have been executed

#### 3. **03_seed_data.sql**
- **Purpose**: Populates the database with 50 restaurant records for testing
- **Rationale**: Provides realistic test data without manual data entry
- **Contents**: 50 INSERT statements creating restaurants with varying addresses and phone numbers

---

### `/sql/requirements/` - Query Requirements

Contains 18 requirement files demonstrating various SQL concepts and business queries.

#### **1.sql** - Basic Customer Reservations
- **Query Type**: SELECT with JOIN
- **Purpose**: Retrieve all reservations with customer information
- **SQL Concepts**: JOIN (2-table join), String concatenation
- **Business Logic**: Lists reservation IDs, customer names, dates, and party sizes
- **Real-World Use**: Customer service viewing booking history

#### **2.sql** - Manager List
- **Query Type**: SELECT with WHERE clause
- **Purpose**: Filter employees holding the Manager position
- **SQL Concepts**: WHERE filtering, String concatenation
- **Business Logic**: Identifies all restaurant managers for staffing reports
- **Real-World Use**: Management roster and org chart

#### **3.sql** - Orders with Menu Items
- **Query Type**: SELECT with Multiple JOINs
- **Purpose**: Retrieve order details with associated menu items for a specific reservation
- **SQL Concepts**: 4-table JOIN, calculated fields (subtotal), ORDER BY
- **Business Logic**: Links orders → order_items → menu_items with pricing
- **Real-World Use**: Detailed receipt generation and order verification

#### **4.sql** - Menu Items by Reservation
- **Query Type**: SELECT with Multiple JOINs
- **Purpose**: List menu items ordered in a specific reservation
- **SQL Concepts**: 4-table JOIN, ORDER BY multiple columns
- **Business Logic**: Simpler view focusing on items without order details
- **Real-World Use**: Quick menu audit of what was ordered

#### **5.sql** - Average Order Amount by Employee
- **Query Type**: SELECT with GROUP BY and Aggregation
- **Purpose**: Calculate average order value per employee
- **SQL Concepts**: GROUP BY, AVG() aggregate function, JOIN
- **Business Logic**: Performance metric showing employee productivity
- **Real-World Use**: Sales analysis and employee performance tracking

#### **6.sql** - Reservation Report View
- **Query Type**: CREATE VIEW with Multiple JOINs
- **Purpose**: Creates a comprehensive view combining reservation, restaurant, and customer data
- **SQL Concepts**: VIEW creation, 3-table JOIN, String concatenation
- **Business Logic**: Single-query access to complete reservation details
- **Real-World Use**: Central reporting view used by multiple queries (see requirement 1)

#### **7.sql** - Employee Details View
- **Query Type**: CREATE VIEW with JOIN
- **Purpose**: Creates a view showing employee information with their restaurant assignments
- **SQL Concepts**: VIEW creation, 2-table JOIN, String concatenation
- **Business Logic**: Combines employee and restaurant data for staff listings
- **Real-World Use**: Staff directory and restaurant staffing reports

#### **8.sql** - Reservations with Multiple Orders (CTE)
- **Query Type**: SELECT with CTE and GROUP BY
- **Purpose**: Identify reservations that have 2 or more orders
- **SQL Concepts**: Common Table Expression (CTE), COUNT() aggregate, HAVING clause
- **Business Logic**: Finds customers who made repeat orders during same reservation
- **Real-World Use**: Customer behavior analysis and revenue tracking

#### **9.sql** - Restaurant Popularity Ranking
- **Query Type**: SELECT with GROUP BY and ORDER BY
- **Purpose**: Rank restaurants by reservation frequency
- **SQL Concepts**: GROUP BY, COUNT() aggregate, ORDER BY DESC
- **Business Logic**: Identifies which restaurants receive most bookings
- **Real-World Use**: Business analytics and marketing strategy

#### **10.sql** - Popular Menu Items with Window Functions
- **Query Type**: SELECT with CTE and Window Functions
- **Purpose**: Identify the most popular menu item per restaurant for July 2026
- **SQL Concepts**: CTE, ROW_NUMBER() window function, PARTITION BY, Multiple JOINs (5 tables), Date filtering
- **Business Logic**: Uses window functions to rank items within restaurant partitions, then filters top 1
- **Real-World Use**: Menu optimization and inventory planning

#### **11.sql** - Database Function: Calculate Restaurant Revenue
- **Function Type**: Scalar Function
- **Function Name**: `fn_CalculateRevenue`
- **Parameters**: `@RestaurantId (INT)`
- **Returns**: `DECIMAL(10,2)` - Total revenue for the restaurant
- **SQL Concepts**: Scalar function, SUM() aggregate, ISNULL() for null handling
- **Business Logic**: Sums all order totals for a specific restaurant across all reservations
- **Real-World Use**: Financial reporting and restaurant profitability analysis

#### **12.sql** - Database Function: Calculate Employee Salary
- **Function Type**: Scalar Function
- **Function Name**: `fn_CalculateEmployeeSalary`
- **Parameters**: `@EmployeeId (INT)`
- **Returns**: `DECIMAL(10,2)` - Calculated salary for the employee
- **SQL Concepts**: Scalar function, CASE statement, COUNT() aggregate, GROUP BY
- **Business Logic**: Salary = (Number of Orders × Position Rank)
  - Position ranks: VIPOrdersWaiter=5, StandardWaiter=4, AssistantWaiter=3
- **Real-World Use**: Payroll processing and performance-based compensation

#### **13.sql** - Stored Procedure: Reserved Tables Report
- **Procedure Type**: Stored Procedure
- **Procedure Name**: `sp_ResrvedTablesReport`
- **Parameters**: `@StartDate (DATE)`, `@EndDate (DATE)`
- **Returns**: Tabulated result set
- **SQL Concepts**: Stored procedure, Date range filtering, Multiple JOINs (3 tables)
- **Business Logic**: Generates report of all reserved tables within a date range with restaurant details
- **Real-World Use**: Historical booking reports and compliance auditing

#### **14.sql** - Stored Procedure: Add New Order with Validation
- **Procedure Type**: Stored Procedure with Error Handling
- **Procedure Name**: `sp_AddNewOrder`
- **Parameters**: 
  - `@ReservationId (INT)` - Target reservation
  - `@EmployeeId (INT)` - Handling employee
  - `@OrderDate (DATETIME2)` - Order timestamp
  - `@TotalAmount (DECIMAL(10,2))` - Order total
  - `@OrderId (INT OUTPUT)` - Returns new order ID
- **Returns**: New order ID or error code
- **SQL Concepts**: Stored procedure, EXISTS validation, THROW exception handling, OUTPUT parameter, SCOPE_IDENTITY()
- **Business Logic**: Validates reservation and employee exist before creating order, returns new ID on success
- **Real-World Use**: Order entry system with data validation and error reporting

#### **15.sql** - Stored Procedure: Future Table Reservations with Temp Table
- **Procedure Type**: Stored Procedure
- **Procedure Name**: `sp_AddNewOrder` (alias for tables with future reservations)
- **Uses**: Temporary table (#EmployeeTemp)
- **SQL Concepts**: Temporary table creation (SELECT INTO), SYSDATETIME() for current time, Multiple JOINs
- **Business Logic**: Creates temp table of all tables with future reservations, then joins with restaurant details
- **Real-World Use**: Real-time availability checking and table assignment for upcoming reservations

#### **16.sql** - Trigger and Audit Log
- **Object Type**: TABLE + TRIGGER
- **Table Name**: `audit_log`
- **Trigger Name**: `trg_AfterTableReserved`
- **Trigger Event**: AFTER INSERT on `reservation` table
- **SQL Concepts**: Table creation with DEFAULT constraint, TRIGGER, INSERTED pseudo-table, SYSDATE TIME()
- **Business Logic**: Automatically logs every reservation into audit_log table with timestamp
- **Audit Fields**: rest_id, table_id, reservation_date, change_date (system generated)
- **Real-World Use**: Compliance tracking, reservation audit trail, dispute resolution

#### **17.sql** - Query Plan Analysis
- **Purpose**: Demonstrates query execution plan analysis using SHOWPLAN_TEXT
- **SQL Concepts**: SHOWPLAN_TEXT ON/OFF, Query plan interpretation
- **Analyzed Queries**: 5 complex queries with performance analysis
  1. Ordered menu items for reservation (4-table join)
  2. Employee details view query (2-table join)
  3. Popular menu items with window functions (5-table join + CTE)
  4. Average order by employee (2-table join + aggregation)
  5. Complete reservation report (3-table join)
- **Real-World Use**: Query optimization and performance tuning

#### **18.sql** - Index Creation for Performance
- **Purpose**: Creates indexes to optimize query performance
- **SQL Concepts**: CREATE INDEX, Single-column indexes on foreign keys
- **Indexes Created**:
  - `idx_res_rest_id` on `reservation(rest_id)` - Optimize restaurant filtering
  - `idx_res_cust_id` on `reservation(cust_id)` - Optimize customer filtering
  - `idx_order_res_id` on `order(res_id)` - Optimize order lookup by reservation
  - `idx_order_date` on `order(date)` - Optimize date range queries
  - `idx_order_emp_id` on `order(emp_id)` - Optimize employee performance queries
  - `idx_emp_rest_id` on `employee(rest_id)` - Optimize staff queries by restaurant
- **Rationale**: Foreign key columns are frequently used in JOINs and WHERE clauses; date columns benefit from range queries
- **Real-World Use**: Production database performance tuning

---

### `/sql/test.sql` - Test Script

- **Purpose**: Executes the test view to verify setup
- **Contents**: `SELECT * FROM Reservation_Report`
- **Rationale**: Quick validation that all setup scripts executed successfully and database is ready for queries

---

## Usage Instructions

### Setup (One-time)

Execute scripts in this order:

```sql
-- 1. Create database
EXEC sql\prepare\01_create_database.sql

-- 2. Create tables and relationships
EXEC sql\prepare\02_create_tables.sql

-- 3. Seed initial data
EXEC sql\prepare\03_seed_data.sql

-- 4. Verify setup
EXEC sql\test.sql
```

### Learning Path

1. **Basics** (Req 1-5): Single joins, WHERE clauses, GROUP BY, aggregate functions
2. **Intermediate** (Req 6-9): Views, CTEs, window functions, complex aggregations
3. **Advanced** (Req 10-17): Functions, procedures, triggers, query optimization
4. **Performance** (Req 18): Indexing strategy

### Executing Requirements

Each requirement file is independent and can be executed after setup:

```sql
-- Example: Get restaurant popularity
EXEC sql\requirements\9.sql

-- Example: Calculate revenue for restaurant 1
SELECT dbo.fn_CalculateRevenue(1) AS TotalRevenue

-- Example: Generate reserved tables report
EXEC sql\requirements\13.sql '2026-07-01', '2026-07-31'
```

---

## SQL Concepts Demonstrated

| Concept | Requirements | Files |
|---------|-------------|-------|
| SELECT / JOIN | 1, 3, 4 | Basic queries |
| WHERE / ORDER BY | 2, 4 | Filtering |
| GROUP BY / HAVING | 5, 8, 9 | Aggregation |
| String Functions | 1, 2, 6, 7 | Text manipulation |
| Aggregate Functions | 5, 8, 9, 10 | SUM, COUNT, AVG |
| Views | 6, 7 | Virtual tables |
| CTEs | 8, 10 | Common Table Expressions |
| Window Functions | 10 | ROW_NUMBER, PARTITION BY |
| Scalar Functions | 11, 12 | Custom functions |
| Stored Procedures | 13, 14, 15 | T-SQL procedures |
| Triggers | 16 | Automated logging |
| Temporary Tables | 15 | Session-scoped tables |
| Error Handling | 14 | THROW, EXISTS validation |
| Indexes | 18 | Query optimization |
| Query Plans | 17 | Performance analysis |

---

## Key Design Decisions

1. **IDENTITY Columns**: Auto-incrementing PKs for easier data entry and ID generation
2. **Foreign Keys with Cascading**: Maintains referential integrity across the system
3. **Audit Trail**: Trigger automatically logs all reservations for compliance
4. **Calculated Salary**: Employee compensation tied to position rank and order volume (gamified performance metric)
5. **Window Functions**: ROW_NUMBER() enables ranking without subqueries
6. **Temporary Tables**: Efficient intermediate result storage in procedures
7. **Performance Indexes**: Strategic indexes on frequently joined/filtered columns

---

## Notes

- All timestamps use `DATETIME2` for precision
- Prices and amounts use `DECIMAL(10,2)` for financial accuracy
- String fields are `VARCHAR(20)` (consider increasing for production)
- Sample data includes 50 restaurants for variety in testing
- Stored procedures include parameter validation and error handling
- Audit log captures all reservation events automatically

