-- 16. **Trigger Implementation**
--     1. Design a trigger to log an entry into a separate **`AuditLog`** table whenever a table get reserved. The **`AuditLog`** should capture `ResturantId`, `TableId`, `ReservationDate` and **`ChangeDate`**.

create table audit_log
(
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    rest_id INT,
    table_id INT,
    reservation_date DATETIME2,
    change_date DATETIME2 DEFAULT SYSDATETIME(),

    constraint fk_audit_rest
        foreign key (rest_id)
        references restaurant(rest_id),

    constraint fk_audit_table
        foreign key (table_id)
        references [table](table_id)
);
GO;
create TRIGGER trg_AfterTableReserved
on reservation 
after INSERT
as 
BEGIN
    SET NOCOUNT ON;
    insert into audit_log (
        rest_id,
        table_id,
        reservation_date
        ) select rest_id, table_id, [date] from inserted
end;

