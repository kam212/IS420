/*Feature 4*/
SQL> exec get_vehicles
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
    DBMS_OUTPUT.PUT_LINE('Zone ID: '  session_rec.session_id);
    DBMS_OUTPUT.PUT_LINE('Start Time: '  session_rec.start_time);
    DBMS_OUTPUT.PUT_LINE('End Time: '  session_rec.end_time);
    DBMS_OUTPUT.PUT_LINE('Zone ID: '  session_rec.zone_id);
    DBMS_OUTPUT.PUT_LINE('Vehicle ID: '  session_rec.vehicle_id);
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
SELECT customer_id, license_PL, stat_v, maker_V, color
FROM vehicle
WHERE customer_id = '1234'
AND start_time >= TIMESTAMP '2021-05-01 00:00:00'
AND end_time <= TIMESTAMP '2021-05-04 23:59:59';
