SET SERVEROUTPUT ON;

/* Creating a array for storing 5 emails of each VARCHAR2(100)  */

CREATE OR REPLACE TYPE emaillist AS
    VARRAY(5) OF VARCHAR2(100);
/
/* Creating a database table having column that store varray. Each varray is VARCHAR2(100)  */

CREATE TABLE customers_emails (
    customer_id  NUMBER,
    full_name    VARCHAR2(100 BYTE),
    emails       emaillist
);

DECLARE
    lv_email      emaillist;
    lv_full_name  customers_emails.full_name%TYPE;
BEGIN
    DELETE FROM customers_emails;

    INSERT INTO customers_emails VALUES (
        286,
        'Wilfred Welch',
        emaillist('wilfred.welch1@internalmail', 'wilfred.welch2@internalmail')
    );

    INSERT INTO customers_emails VALUES (
        287,
        'Wilfred Welch',
        emaillist('kristina.nunez2@internalmail', 'kristina.nunez2@internalmail')
    );

    COMMIT;
    
    /* Retrieving vaaray values */
    SELECT
        full_name,
        emails
    INTO
        lv_full_name,
        lv_email
    FROM
        customers_emails
    WHERE
        customer_id = 286;

    FOR i IN 1..lv_email.count LOOP
        dbms_output.put_line(lv_full_name
                             || ' - '
                             || lv_email(i));
    END LOOP;

END;
/