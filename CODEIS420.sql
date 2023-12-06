Drop table customer cascade constraints;
Drop table vehicle cascade constraints;
Drop table parking_session cascade constraints;
Drop table payment_transaction cascade constraints;
Drop table message cascade constraints;

CREATE TABLE customer (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    address VARCHAR(255),
    state VARCHAR(50),
    zip VARCHAR(10),
    email VARCHAR(255),
   payment_card VARCHAR(20)
);

CREATE TABLE vehicle (
    vehicle_id INT PRIMARY KEY,
    state_V VARCHAR(15),
    maker VARCHAR(15),
    model_V VARCHAR(15),
    year_V VARCHAR(4),
    color VARCHAR(10),
    license_PL VARCHAR(10)
    
);

 create table parking_session (
  session_id NUMBER primary key,
  start_time timestamp,
  end_time timestamp,
  vehicle_id INT,
  customer_id NUMBER,
  zone_id VARCHAR(30),
  total_charge float,
  foreign key (customer_id) references customer(customer_id),
  foreign key (vehicle_id) references vehicle(vehicle_id)
);

Create table payment_transaction (
  payment_id NUMBER, 
  pay_amount NUMBER,
  hours int,
  pay_time int, 
  session_id NUMBER,
   foreign key (session_id) references parking_session(session_id));

create table message (
  message_id NUMBER primary key,
  message_body varchar(200),
  message_time timestamp, 
  customer_id NUMBER,
  foreign key (customer_id) references customer(customer_id)); 


//*inserting data*//
INSERT INTO customer (customer_id, name, phone_number, address, state, zip, email, payment_card)
VALUES
 ('1234','Chris Neang', '240-123-4567', '123 Main St', 'MD', '20906', 'cneang@gmail.com', '1234-5678-9012-3456');
   INSERT INTO customer (customer_id, name, phone_number, address, state, zip, email, payment_card)
VALUES
 ('3678','Seth Yook', '252-123-4567', '123 Second St', 'NC', '27610', 'syook@gmail.com', '1111-2222-3333-4444');
   INSERT INTO customer (customer_id, name, phone_number, address, state, zip, email, payment_card)
VALUES
 ('8981','Paul Chhay', '301-123-4567', '123 Third St', 'CA', '90001', 'pchhay@gmail.com', '2222-2222-2222-2222');

//*inserting vehicle data*//

INSERT INTO Vehicle (vehicle_id, state_V, maker, model_V, year_V, color, license_PL)
VALUES
('7878', 'Maryland', 'Tesla', 'model S', '2020', 'White', '9EX 889');
INSERT INTO Vehicle (vehicle_id, state_V, maker, model_V, year_V, color, license_PL)
VALUES
('9000', 'NewYork', 'Toyota', 'Land Cruiser', '2022', 'Black', '999 MDX');
INSERT INTO Vehicle (vehicle_id, state_V, maker, model_V, year_V, color, license_PL)
VALUES
('2343', 'California', 'Porsche', 'Cayenne', '2018', 'Red', '2MK 9YU');

//*inserting parking session data*//
INSERT INTO parking_session (customer_id, start_time, end_time, session_id, vehicle_id, zone_id, total_charge)
  VALUES
  (1234,  timestamp'2021-05-01 10:00:00', timestamp'2021-05-01 14:00:00', 3, '7878', 'Zone A', 8.50);
  
  INSERT INTO parking_session (customer_id, start_time, end_time, session_id, vehicle_id, zone_id, total_charge)
  VALUES
  (3678,  timestamp'2021-05-02 11:30:00', timestamp'2021-05-02 13:30:00', 2, '9000', 'Zone B', 5.75);

  INSERT INTO parking_session (customer_id, start_time, end_time, session_id, vehicle_id, zone_id, total_charge)
  VALUES
  (8981,  timestamp'2021-05-04 13:00:00', timestamp'2021-05-04 16:00:00', 4, '2343', 'Zone D', 12.50);
//*transaction data insertion*//
insert into message (message_id, message_body, message_time, customer_id)
 VALUES
 (1, 'Found parking very quickly, efficient system overall!', '01-May-21 12:00:00', 1234);
 insert into message (message_id, message_body, message_time, customer_id)
 VALUES
 (2, 'Spacious, no difficulties.', '05-April-21 01:45:32', 3678);
 insert into message (message_id, message_body, message_time, customer_id)
 VALUES
 (3, 'A bit of trouble finding my way around. Got the hang of it.', '07-February-21',8981);

//individual feature fahad*//

Drop table add_vehicle cascade constraints;

-- Member 2: Feature 2 - Add a vehicle
CREATE TABLE add_vehicles (
  license_plate VARCHAR2(10),
  state VARCHAR2(2),
  customer_id NUMBER,
  maker VARCHAR2(20),
  model VARCHAR2(20), 
  year NUMBER,
  color VARCHAR2(10)
);

INSERT INTO add_vehicles VALUES ('XYZ987','NY',1002, 'Ford', 'F-150',2022,'Blue');
INSERT INTO add_vehicles  VALUES ('LVN123','NV',1003,'Tesla','Model 3' ,2021, 'BLACK');
INSERT INTO add_vehicles VALUES ( 'ABC123', 'CA', 1001,'Toyota','Camry',2020, 'Red');


//*Group Feature 6*//
DECLARE
  v_customer_id NUMBER;
  v_vehicle_id VARCHAR2(30);
  v_zone_id NUMBER;
BEGIN
  -- Assign the values to be checked
  v_customer_id := 2; -- Replace with the desired customer ID
  v_vehicle_id := 'MD9000'; -- Replace with the desired vehicle ID
  v_zone_id := 2; -- Replace with the desired zone ID

  -- Check if customer ID is valid
  SELECT COUNT(*)
  INTO v_customer_id
  FROM customer
  WHERE customer_id = v_customer_id;
  
  -- Print customer ID information
  IF v_customer_id > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Customer ID ' || v_customer_id || ' is valid.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error: Invalid customer ID detected - ' || v_customer_id);
  END IF;

  -- Check if vehicle ID is valid
  SELECT COUNT(*)
  INTO v_vehicle_id
  FROM vehicle
  WHERE vehicle_id = v_vehicle_id;
  
  -- Print vehicle ID information
  IF v_vehicle_id > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Vehicle ID ' || v_vehicle_id || ' is valid.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error: Invalid vehicle ID detected - ' || v_vehicle_id);
  END IF;

  -- Check if zone ID is valid
  SELECT COUNT(*)
  INTO v_zone_id
  FROM parking_session
  WHERE zone_id = v_zone_id;
  
  -- Print zone ID information
 IF v_zone_id > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Zone ID ' || v_zone_id || ' is valid.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error: Invalid zone ID detected - ' || v_zone_id);
  END IF;
  
  -- If all IDs are valid
  IF v_customer_id > 0 AND v_vehicle_id > 0 AND v_zone_id > 0 THEN
    DBMS_OUTPUT.PUT_LINE('All IDs are valid.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

//*group feature 8*//


 





