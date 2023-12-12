//Group Feature 6

CREATE OR REPLACE PACKAGE c_package AS
  PROCEDURE startSession(p_customer_id,
  p_zone_id,
  p_vehicle_id,
  start_time,
  hours
  v_num_session out INT)
IS 
  p_count INT;
BEGIN
  select(*) into p_count from customer where customer_id = p_customer_id;
  if p_count = 0 then 
  dbms.output.put_line('Invalid customer ID');
  else
  select count(*) into v_num_session 
  from parking_session
  where customer_id = p_customer_id;
end if;
end;
  
  
