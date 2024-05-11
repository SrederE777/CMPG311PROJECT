-- Master Script (master_script.sql)

-- Run other SQL create table scripts
@DROP_TABLES_SQL.sql;
@create_table_statements.sql;

-- Run other SQL create trigger scripts
--@DROP_TRIGGERS_SQL.sql;
--@CREATE_EVENT_PK_INC_TRIGGER.sql

-- Run other SQL scripts with relative paths
@ADDRESS_DATA.sql;
@BRANCH_DATA.sql;
@COWORK_SPACE_DATA.sql
@SUPPLIER_DATA.sql;
@EQUIPMENT_MANUFACTUER_DATA.sql;
@MENU_ITEM_DATA.sql;
@EQUIPMENT_DATA.sql;
@EVENT_DATA.sql;
@STOCK_DATA.sql;
@VENDOR_DATA.sql;
@VENDOR_ATTENDENCE_DATA.sql;
@COWORK_SPACE_EQUIPMENT_DATA.sql;
@EMPLOYEE_CONTRACT_DATA.sql;
@EMPLOYEE_DATA.sql;
@CUSTOMER_DATA.sql;
@TRANSACTIONS_DATA.sql;
@CAFE_TRANSACTION_DATA.sql;
@COWORK_TRANSACTION_DATA.sql;
@PRODUCTION_DATA.sql;
@ORDERS_DATA.sql;
@EVENT_TRANSACTION_DATA.sql;

