CREATE TABLE TRANSACTIONS (
  transaction_id INT PRIMARY KEY NOT NULL,
  transaction_date DATE,
  transaction_total_amount NUMBER(10,2),
  transaction_time TIMESTAMP,
  transaction_method NVARCHAR2(100),
  transaction_tab NUMBER(1),
  transaction_paid NUMBER(1),
  transaction_exclusive_vat NUMBER(10,2),
  branch_id INT,
  employee_id INT,
  equipment_id INT,
  customer_id INT
);

CREATE TABLE EVENT_TRANSACTION (
  transaction_id INT NOT NULL,
  event_id INT,
  event_person_paying VARCHAR2(255)
  PRIMARY KEY (transaction_id,event_id)
);


CREATE TABLE COWORK_TRANSACTION (
  transaction_id INT,
  cowork_space_id INT,
  cowork_rented_date DATE,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  PRIMARY KEY (TRANSACTION_ID,COWORK_SPACE_ID)
);

CREATE TABLE CAFE_TRANSACTION (
  menu_item_id INT NOT NULL,
  transaction_id INT NOT NULL,
  menu_item_amount INT,
  PRIMARY KEY (menu_item_id, transaction_id)
);

CREATE TABLE MENU_ITEM (
  menu_item_id INT PRIMARY KEY,
  menu_item_name VARCHAR2(100),
  menu_item_description VARCHAR2(255),
  menu_item_price NUMBER(10,2)
);

CREATE TABLE PRODUCTION (
  equipment_id INT NOT NULL,
  stock_id INT NOT NULL,
  menu_item_id INT NOT NULL,
  production_estimated_time NUMBER,
  PRIMARY KEY (EQUIPMENT_ID, stock_id, MENU_ITEM_ID)
);

CREATE TABLE STOCK (
  stock_id INT PRIMARY KEY,
  stock_name VARCHAR2(100),
  stock_amount INT,
  stock_purchase_price_per_item NUMBER(10,2),
  stock_description VARCHAR2(255),
  branch_id int
);

CREATE TABLE ORDERS (
  stock_id INT NOT NULL,
  supplier_id INT NOT NULL,
  order_id INT,
  order_date DATE,
  order_item_amount INT,
  PRIMARY KEY (stock_id, supplier_id, order_id)
);

CREATE TABLE SUPPLIER (
  supplier_id INT PRIMARY KEY,
  address_id INT,
  supplier_name VARCHAR(255),
  supplier_desc VARCHAR(255),
  supplier_email VARCHAR(255),
  supplier_contact_number VARCHAR(255)
);

CREATE TABLE BRANCH (
  branch_id INT PRIMARY KEY,
  branch_name NVARCHAR2(255),
  address_id INT,
  branch_cafe CHAR,
  branch_event CHAR,
  branch_cowork CHAR,
  branch_date_of_purchase DATE
);

CREATE TABLE EMPLOYEE (
  employee_id INT PRIMARY KEY,
  branch_id INT,
  employee_name VARCHAR2(255),
  employee_surname VARCHAR2(255),
  employee_manager_id INT,
  employee_date_of_employement DATE,
  employee_cell_num VARCHAR2(255),
  employee_email VARCHAR2(255),
  employee_contract_id INT
);

CREATE TABLE EMPLOYEE_CONTRACT (
  employee_contract_id INT PRIMARY KEY,
  contract_job_title VARCHAR2(255 BYTE),
  contract_salary NUMBER(10,2),
  contract_job_description VARCHAR2(255),
  contract_type VARCHAR2(255),
  contract_notice_period VARCHAR2(255),
  contract_paid_leave INT,
  contract_unpaid_leave INT
);

CREATE TABLE EVENT (
  event_id INT PRIMARY KEY,
  branch_id INT,
  event_entry CHAR DEFAULT 'n',
  event_name VARCHAR2(255),
  event_attendance INT,
  event_date DATE,
  event_time TIMESTAMP
);

CREATE TABLE VENDOR (
  vendor_id INT PRIMARY KEY,
  vendor_name VARCHAR2(255),
  vendor_service_provided VARCHAR2(255),
  vendor_cell_number VARCHAR2(255),
  vendor_email VARCHAR2(255)
);

CREATE TABLE VENDOR_ATTENDANCE (
    event_id INT,
    vendor_id INT,
    CONSTRAINT PK_Event_Vendor PRIMARY KEY (event_id, vendor_id)
);

CREATE TABLE ADDRESS (
  address_id INT PRIMARY KEY,
  province VARCHAR2(255),
  city VARCHAR2(255),
  address VARCHAR2(255)
);

CREATE TABLE EQUIPMENT_MANUFACTURER (
  manufacturer_id INT PRIMARY KEY,
  manufacturer_contact_num VARCHAR2(255),
  manufacturer_email_address VARCHAR2(255),
  address_id INT,
  manufacturer_name VARCHAR2(255)
);

CREATE TABLE EQUIPMENT (
  equipment_id INT PRIMARY KEY,
  equipment_name VARCHAR2(255),
  manufacturer_id INT,
  equipment_description VARCHAR2(255),
  branch_id INT,
  equipment_purchase_date DATE
);

CREATE TABLE COWORK_SPACE (
  cowork_space_id INT PRIMARY KEY,
  cowork_space_floor_size INT,
  cowork_space_occupancy_size INT,
  cowork_space_price NUMBER(10,2)
);

CREATE TABLE COWORK_SPACE_EQUIPMENT (
  cowork_spaces_equipment_id INT PRIMARY KEY,
  cowork_space_id INT,
  equipment_id INT
);

CREATE TABLE CUSTOMER (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR2(255),
  customer_surname VARCHAR2(255),
  customer_cel_num VARCHAR2(255),
  customer_email VARCHAR2(255),
  customer_date_of_birth DATE,
  customer_loyalty_points INT,
  customer_gender VARCHAR2(100)
);

-- TRANSACTIONS
ALTER TABLE TRANSACTIONS ADD FOREIGN KEY (branch_id) REFERENCES BRANCH (branch_id);
ALTER TABLE TRANSACTIONS ADD FOREIGN KEY (employee_id) REFERENCES EMPLOYEE (employee_id);
ALTER TABLE TRANSACTIONS ADD FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT (equipment_id);
ALTER TABLE TRANSACTIONS ADD FOREIGN KEY (customer_id) REFERENCES CUSTOMER (customer_id);

ALTER TABLE TRANSACTIONS ADD CONSTRAINT KASHORKAAT CHECK(transaction_method = 'cash' OR transaction_method='card');
ALTER TABLE TRANSACTIONS ADD CONSTRAINT TABORNOT CHECK(transaction_tab = 1 OR TRANSACTION_TAB=0);
ALTER TABLE TRANSACTIONS ADD CONSTRAINT PAIDORNOT CHECK(transaction_PAID = 1 OR TRANSACTION_PAID=0);

-- EVENT_TRANSACTION
ALTER TABLE EVENT_TRANSACTION ADD FOREIGN KEY (transaction_id) REFERENCES TRANSACTIONS (transaction_id);
ALTER TABLE EVENT_TRANSACTION ADD FOREIGN KEY (event_id) REFERENCES EVENT (event_id);

-- COWORK_TRANSACTION
ALTER TABLE COWORK_TRANSACTION ADD FOREIGN KEY (transaction_id) REFERENCES TRANSACTIONS (transaction_id);
ALTER TABLE COWORK_TRANSACTION ADD FOREIGN KEY (cowork_space_id) REFERENCES COWORK_SPACE (cowork_space_id);

-- CAFE_TRANSACTION
ALTER TABLE CAFE_TRANSACTION ADD FOREIGN KEY (menu_item_id) REFERENCES MENU_ITEM (menu_item_id);
ALTER TABLE CAFE_TRANSACTION ADD FOREIGN KEY (transaction_id) REFERENCES TRANSACTIONS (transaction_id);

-- PRODUCTION
ALTER TABLE PRODUCTION ADD FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT (equipment_id);
ALTER TABLE PRODUCTION ADD FOREIGN KEY (stock_id) REFERENCES STOCK (stock_id);
ALTER TABLE PRODUCTION ADD FOREIGN KEY (menu_item_id) REFERENCES MENU_ITEM (menu_item_id);

-- STOCK
ALTER TABLE STOCK ADD FOREIGN KEY (branch_id) REFERENCES BRANCH (branch_id);

-- ORDERS
ALTER TABLE ORDERS ADD FOREIGN KEY (stock_id) REFERENCES STOCK (stock_id);
ALTER TABLE ORDERS ADD FOREIGN KEY (supplier_id) REFERENCES SUPPLIER (supplier_id);

-- SUPPLIER
ALTER TABLE SUPPLIER ADD FOREIGN KEY (address_id) REFERENCES ADDRESS (address_id);

-- BRANCH
ALTER TABLE BRANCH ADD FOREIGN KEY (address_id) REFERENCES ADDRESS (address_id);

-- EMPLOYEE
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (branch_id) REFERENCES BRANCH (branch_id);
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (employee_manager_id) REFERENCES EMPLOYEE (employee_id);
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (employee_contract_id) REFERENCES EMPLOYEE_CONTRACT (employee_contract_id);

-- EVENT
ALTER TABLE EVENT ADD FOREIGN KEY (branch_id) REFERENCES BRANCH (branch_id);

-- EQUIPMENT_MANUFACTURER
ALTER TABLE EQUIPMENT_MANUFACTURER ADD FOREIGN KEY (address_id) REFERENCES ADDRESS (address_id);

-- EQUIPMENT
ALTER TABLE EQUIPMENT ADD FOREIGN KEY (manufacturer_id) REFERENCES EQUIPMENT_MANUFACTURER (manufacturer_id);
ALTER TABLE EQUIPMENT ADD FOREIGN KEY (branch_id) REFERENCES BRANCH (branch_id);

-- COWORK_SPACE_EQUIPMENT
ALTER TABLE COWORK_SPACE_EQUIPMENT ADD FOREIGN KEY (cowork_space_id) REFERENCES COWORK_SPACE (cowork_space_id);
ALTER TABLE COWORK_SPACE_EQUIPMENT ADD FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT (equipment_id);