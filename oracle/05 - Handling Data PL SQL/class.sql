
SET SERVEROUTPUT ON;
SELECT VALUE FROM V$NLS_PARAMETERS WHERE PARAMETER = 'NLS_DATE_FORMAT'; --check system date format

--DECLARE
--    lv_test_date DATE := TO_DATE('02-FEB-2023');
--    lv_test_num CONSTANT NUMBER(3) := 10;
--    lv_test_txt VARCHAR2(10);
--BEGIN
--    lv_test_txt := 'Pinto';
--    DBMS_OUTPUT.PUT_LINE(lv_test_date);
--    DBMS_OUTPUT.PUT_LINE(lv_test_num);
--    DBMS_OUTPUT.PUT_LINE(lv_test_txt);
--END;



--DECLARE
--    lv_total_number NUMBER(6,2):= &VALUE;
--BEGIN
--    IF lv_total_number > 200 THEN
--        DBMS_OUTPUT.PUT_LINE('High');
--    ELSIF lv_total_number > 100 THEN
--        DBMS_OUTPUT.PUT_LINE('mid');
--    ELSE
--        DBMS_OUTPUT.PUT_LINE('low');
--    END IF;
--END;

DECLARE
    num1 NUMBER(6,2):= &VALUE;
    num2 NUMBER(6,2):= &VALUE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(num1 || ' + ' || num2 || ' = ' || (num1+num2));
    DBMS_OUTPUT.PUT_LINE(num2 || ' - ' || num1 || ' = ' || (num2-num1));
    DBMS_OUTPUT.PUT_LINE(num1 || ' * ' || num2 || ' = ' || (num1*num2));
END;

