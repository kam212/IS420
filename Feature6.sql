//Group Feature 6
SET SERVEROUTPUT ON;
//*two parameters, join, check*//
-- Create the procedure
create or replace procedure start_session(v_customer_id varchar)
as
v_count int; 

cursor c1 is 
select address,hours,start_time, end_time 
from customer c, parking_session ps
where c.customer_id = v_customer_id
and c.customer_id = ps.customer_id and c.customer_id = 1
group by ps.zone_id;

begin 
select count(*) into v_count from customer where customer_id =  v_customer_id;
if v_count=0 then 
    dbms_output.put_line('Invalid');
    else
    for r in c1 loop dbms_output.put_line('Information: ' || r.address || 'at' || r.start_time || 'to' || r.end_time ||
    'for a total of' || r.hours);
        end loop;
end if;
end;
/
  
  
