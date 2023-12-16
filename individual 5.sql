create or replace procedure get_active_vehicle(v_zone_id varchar, v_vehicle_id int, v_num_vehicle  int)
is
v_count int;

begin
  select count(*) into v_count from parking_session where zone_id = v_zone_id;
  if v_count = 0 then 
    dbms_output.put_line('Invalid zone id');
else 
  select count(*) into v_num_vehicle
  from parking_session 
  where vehicle_id = v_vehicle_id;
  
end if;
end;
begin 
  declare
  v_num_vehicle int;
    get_active_vehicle (v_num_vehicle);
    if v_num_vehicle > 0 then 
      dbms_output.put_line('This vehicle is active:' || 'v_num_vehicle');
   end if;
   end;
  
  


/*list all vehicles with an active session at a parking zone. The input is a

parking zone ID and a current time. The feature does the following steps:

1) it first checks whether the zone ID is valid (there is a row in the parking_zone table

with the input zone ID). If not, print an error message 'Incorrect zone ID' and stop.

2) it then lists all vehicles with an active parking session in this zone. An active session

means that the input current time is between the session's start time and end time.

Please print out vehicle Id, customer ID, plate number, state, maker, model, and color*/


