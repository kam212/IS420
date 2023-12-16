-- Create or replace procedure for generating reminders
CREATE OR REPLACE PROCEDURE generate_session_reminders AS
    v_session_id NUMBER;
    v_customer_id NUMBER;
    v_end_time TIMESTAMP;
    v_minutes_until_expiry NUMBER;
    v_message_body VARCHAR2(200);
BEGIN
    -- Iterate over sessions within the next 15 minutes
    FOR session_rec IN (
        SELECT session_id, customer_id, end_time
        FROM parking_session
        WHERE end_time BETWEEN SYSTIMESTAMP AND SYSTIMESTAMP + INTERVAL '15' MINUTE
    ) LOOP
        v_session_id := session_rec.session_id;
        v_customer_id := session_rec.customer_id;
        v_end_time := session_rec.end_time;

        -- Calculates how many minutes until it expires
        v_minutes_until_expiry :=
            EXTRACT(HOUR FROM (v_end_time - SYSTIMESTAMP)) * 60 +
            EXTRACT(MINUTE FROM (v_end_time - SYSTIMESTAMP));

        -- expiring message
        v_message_body :=
            'Session ' || v_session_id || ' will expire in ' || v_minutes_until_expiry || ' minutes, please extend it if necessary.';

        -- Insert message into the message table
        INSERT INTO message (message_id, message_body, message_time, customer_id)
        VALUES (message_seq.NEXTVAL, v_message_body, SYSTIMESTAMP, v_customer_id);

        -- Print message to console
        DBMS_OUTPUT.PUT_LINE('Message generated for session ' || v_session_id);
    END LOOP;

    -- Print a final message to indicate the end of the procedure
    DBMS_OUTPUT.PUT_LINE('Session reminders generation completed.');
END generate_session_reminders;
/

-- Test generate_session_reminders procedure

DECLARE
    v_current_time TIMESTAMP := SYSTIMESTAMP;
BEGIN
    generate_session_reminders;
END;
/

-- Display data from the tables
SELECT * FROM customer;
SELECT * FROM vehicle;
SELECT * FROM parking_session;
SELECT * FROM payment_transaction;
SELECT * FROM message;

