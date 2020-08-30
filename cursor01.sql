/* Example of Implicit Cursors */

BEGIN
  UPDATE CUSTOMERS SET FULL_NAME = 'Gregory Sanchez' WHERE CUSTOMER_ID=10;
  IF (sql%found) THEN
    dbms_output.put_line( 'Record updated');
    dbms_output.put_line( 'No Record affected: ' ||sql%rowcount  );
  COMMIT;
  END IF;
    IF (sql%isopen) THEN
    dbms_output.put_line( 'Implicit cursor is open.');
    else
    dbms_output.put_line( 'Implicit cursor is closed.');
  END IF;
END;
/

/* Example of Explicit Cursor */

DECLARE
CURSOR CUST IS select * from CUSTOMERS where CUSTOMER_ID<=10 order by 1 desc;
CUST_rec CUST%rowtype;
begin
open CUST;
LOOP
fetch CUST into CUST_rec;
dbms_output.put_line( CUST_rec.FULL_NAME || ', ' ||CUST_rec.EMAIL_ADDRESS);
EXIT WHEN CUST%NOTFOUND;
END LOOP;
close CUST;
end;
/

DECLARE
  CURSOR CUST
  IS
    SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID<=10;
  CUST_rec CUST%rowtype;
BEGIN
  OPEN CUST;
  FETCH CUST INTO CUST_rec;
  WHILE CUST%FOUND
  LOOP
    dbms_output.put_line( 'Customer Id: '|| CUST_rec.CUSTOMER_ID || ' ' || CUST_rec.FULL_NAME || ', ' ||CUST_rec.EMAIL_ADDRESS);
    FETCH CUST INTO CUST_rec;
  END LOOP;
  CLOSE CUST;
END;
/

/* 
Example of Parameterized Cursor
CURSOR cursor_name (
    parameter_name1 datatype := default_value, 
    parameter_name2 datatype := default_value, 
    parameter_name3 datatype := default_value, 
    ...
) IS SQL_Query;
*/

DECLARE
  CURSOR CUST (INPUT_CUST_ID IN NUMBER)
  IS
    SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID=INPUT_CUST_ID;
  CUST_rec CUST%rowtype;
BEGIN
  OPEN CUST(11);
  FETCH CUST INTO CUST_rec;
    dbms_output.put_line( 'Customer Id: '|| CUST_rec.CUSTOMER_ID || ' ' || CUST_rec.FULL_NAME || ', ' ||CUST_rec.EMAIL_ADDRESS);
  CLOSE CUST;
END;
/

/* Cursor For Loop */

DECLARE
  CURSOR CUST
  IS SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID<=10;
BEGIN
  for i in CUST
  LOOP
  if mod(i.CUSTOMER_ID,2)=0 then
    dbms_output.put_line( 'Customer Id: '|| i.CUSTOMER_ID || ' ' || i.FULL_NAME || ', ' ||i.EMAIL_ADDRESS);
    end if;
  END LOOP;
END;
/
