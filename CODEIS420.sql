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
//*Individual Feature 4*//
    /*Feature 4*/
/*Feature 4*/
SQL> exec get_parking_sessions
SET SERVEROUTPUT ON;

-- Create the procedure
CREATE OR REPLACE PROCEDURE get_parking_sessions(
  p_customer_id IN customers.customer_id%TYPE,
  p_start_date IN DATE,
  p_end_date IN DATE
)
IS
BEGIN
  FOR session_id IN (
    SELECT *
    FROM parking_session
    WHERE customer_id = p_customer_id
    AND start_time >= p_start_date
    AND end_time <= p_end_date
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Session ID: '  parking_session.session_id);
    DBMS_OUTPUT.PUT_LINE('Start Time: '  parking_session.start_time);
    DBMS_OUTPUT.PUT_LINE('End Time: '  parking_session.end_time);
    DBMS_OUTPUT.PUT_LINE('Zone ID: ' parking_session.zone_id);
    DBMS_OUTPUT.PUT_LINE('Vehicle ID: '  parking_session.vehicle_id);
    DBMS_OUTPUT.PUT_LINE('Total Charge: '  parking_session.total_charge);
    DBMS_OUTPUT.PUT_LINE(''); END LOOP;
END;
/

-- Execute the procedure
DECLARE
  p_customer_id customers.customer_id%TYPE := 1;
  p_start_date DATE := TO_DATE('2021-05-01', 'YYYY-MM-DD'); 
  p_end_date DATE := TO_DATE('2021-05-04', 'YYYY-MM-DD'); 
  get_parking_sessions(p_customer_id, p_start_date, p_end_date); -- Call the procedure
END;
/

-- Query to get the total charge
SELECT SUM(total_charge) AS total_charge
FROM parking_session
WHERE customer_id = 1
AND start_time >= TIMESTAMP '2021-05-01 00:00:00'
AND end_time <= TIMESTAMP '2021-05-04 23:59:59';

//*Group Feature 6*//////////////
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

CREATE OR REPLACE PROCEDURE stop_session(
    p_session_id NUMBER,
    p_current_time TIMESTAMP
) AS
    v_session_exists NUMBER;
    v_customer_id NUMBER;

BEGIN
    -- Check if the session ID is valid
    SELECT COUNT(*) INTO v_session_exists FROM parking_session WHERE session_id = p_session_id;

    IF v_session_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid session ID');
        RETURN;
    END IF;

    -- Retrieve the customer ID associated with the session
    SELECT customer_id INTO v_customer_id FROM parking_session WHERE session_id = p_session_id;


    -- Check if the current time is after the end time of the session
    IF p_current_time > (SELECT end_time FROM parking_session WHERE session_id = p_session_id) THEN
        -- Insert a message for an expired session
        INSERT INTO message (message_id, customer_id, message_time, message_body)
        VALUES (message_seq.NEXTVAL, v_customer_id, p_current_time, 'Session ' || p_session_id || ' expired. You may get a ticket.');

        DBMS_OUTPUT.PUT_LINE('Session ' || p_session_id || ' expired. You may get a ticket.');
    ELSE


        -- Update the end time of the session
        UPDATE parking_session
        SET end_time = p_current_time
        WHERE session_id = p_session_id;


        -- Insert a message for the session ending
        INSERT INTO message (message_id, customer_id, message_time, message_body)
        VALUES (message_seq.NEXTVAL, v_customer_id, p_current_time, 'Session ' || p_session_id || ' ends at ' || TO_CHAR(p_current_time, 'DD-MON-YYYY HH24:MI:SS'));

        DBMS_OUTPUT.PUT_LINE('Session ' || p_session_id || ' ends at ' || TO_CHAR(p_current_time, 'DD-MON-YYYY HH24:MI:SS'));
    END IF;
END stop_session;
/
 





