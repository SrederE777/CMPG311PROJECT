--Vendor Attendence
BEGIN
  FOR i IN 1..88 LOOP
    FOR j IN 1..7 LOOP
      DECLARE
        v_vendor_id NUMBER;
      BEGIN
        LOOP
          v_vendor_id := ROUND(DBMS_RANDOM.VALUE(1, 50));
          BEGIN
            INSERT INTO VENDOR_ATTENDANCE(EVENT_ID, VENDOR_ID)
            VALUES(i, v_vendor_id);
            EXIT; -- Exit the loop if insertion is successful
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              CONTINUE; -- Continue to generate a new random number
          END;
        END LOOP;
      END;
    END LOOP;
  END LOOP;
END;
/
