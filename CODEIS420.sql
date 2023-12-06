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


