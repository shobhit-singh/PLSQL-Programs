/* Creating Record Type at Database Level */
CREATE TYPE emails AS OBJECT (
    email_id       VARCHAR2(100),
    email_type     VARCHAR2(100),
    primary_email  CHAR(1)
);
/

--SELECT * FROM user_objects WHERE OBJECT_NAME='EMAILS' ;

/* Creating Varray */
CREATE OR REPLACE TYPE emaillist AS
    VARRAY(5) OF emails;
/

CREATE TABLE customers_emails (
    customer_id  NUMBER,
    full_name    VARCHAR2(100),
    email_ids    emaillist
);

DECLARE
    lv_email      emaillist;
    lv_full_name  customers_emails.full_name%TYPE;
    rec_emails    emails;
BEGIN
    DELETE FROM customers_emails;

    INSERT INTO customers_emails VALUES (
        286,
        'Wilfred Welch',
        emaillist(emails('wilfred.welch1@internalmail', 'Home', 'N'), emails('wilfred.welch2@internalmail', 'Home', 'N'),
                  emails('wilfred.welch3@internalmail', 'Office', 'Y'))
    );

    INSERT INTO customers_emails VALUES (
        287,
        'Kristina Nunez',
        emaillist(emails('kristina1.nunez@internalmail', 'Home', 'N'), emails('kristina3.nunez@internalmail', 'Home', 'N'),
                  emails('kristina2.nunez@internalmail', 'Office', 'Y'))
    );

    COMMIT;
    SELECT
        email_ids
    INTO lv_email
    FROM
        customers_emails
    WHERE
        customer_id = 286;

    SELECT
        emails(email_id, email_type, primary_email)
    INTO rec_emails
    FROM
        TABLE ( lv_email )
    WHERE
        primary_email = 'Y';

    dbms_output.put_line(rec_emails.email_id
                         || ' - '
                         || rec_emails.email_type
                         || ' - '
                         || rec_emails.primary_email);

END;
/