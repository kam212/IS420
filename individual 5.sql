SQL> exec get_vehicle
SET SERVEROUTPUT ON;

-- Create the procedure
CREATE OR REPLACE PROCEDURE get_vehicle(
  p_zone_id IN parking_zone.zone_id%TYPE,
  p_start_date IN DATE,
  p_end_date IN DATE
)
IS
BEGIN
  FOR session_id IN (
    SELECT *
    FROM parking_session
    WHERE zone_id = p_zone_id
    AND start_time >= p_start_date
    AND end_time <= p_end_date
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Zone ID: '  parking_session.session_id);
    DBMS_OUTPUT.PUT_LINE('Start Time: '  parking_session.start_time);
    DBMS_OUTPUT.PUT_LINE('End Time: '  parking_session.end_time);
    DBMS_OUTPUT.PUT_LINE('Zone ID: '  parking_session.zone_id);
    DBMS_OUTPUT.PUT_LINE('Vehicle ID: '  parking_session.vehicle_id);
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

-- Query to get the vehicle info
SELECT license_PL, state_V, maker,model_V, color
FROM vehicle;
