/* --------------Example for Weak Type--------------- */

DECLARE
    TYPE cust_co IS REF CURSOR;
    cust_co_var   cust_co;
    cust_rec      customers%rowtype;
    orditems_rec  order_items%rowtype;
    ord_rec       orders%rowtype;
BEGIN
    OPEN cust_co_var FOR SELECT
                             *
                         FROM
                             customers;

    FETCH cust_co_var INTO cust_rec;
    dbms_output.put_line(cust_rec.customer_id
                         || ' '
                         || cust_rec.email_address
                         || ' - '
                         || cust_rec.full_name);

    OPEN cust_co_var FOR SELECT
                            *
                        FROM
                            order_items;

    FETCH cust_co_var INTO orditems_rec;
    dbms_output.put_line(orditems_rec.order_id
                         || ' '
                         || orditems_rec.product_id);
    OPEN cust_co_var FOR SELECT
                             *
                         FROM
                             orders;

    FETCH cust_co_var INTO ord_rec;
    dbms_output.put_line(ord_rec.order_id
                         || ' '
                         || ord_rec.customer_id
                         || ' '
                         || ord_rec.order_status);

    CLOSE cust_co_var;
END;
/

/* --------------Example for Sys RefCursor--------------- */

DECLARE
    cust_cursor  SYS_REFCURSOR;
    cust_rec     customers%rowtype;
    prdct_rec    products%rowtype;
BEGIN
    dbms_output.put_line('==============Customers==============');
    OPEN cust_cursor FOR SELECT
                             *
                         FROM
                             customers
                         WHERE
                             customer_id <= 5;

    LOOP
        FETCH cust_cursor INTO cust_rec;
        EXIT WHEN cust_cursor%notfound;
        dbms_output.put_line(cust_rec.customer_id
                             || ' '
                             || cust_rec.email_address
                             || ' - '
                             || cust_rec.full_name);

    END LOOP;

    dbms_output.put_line('==============Products==============');
    OPEN cust_cursor FOR SELECT
                             *
                         FROM
                             products
                         WHERE
                             product_id <= 5;

    LOOP
        FETCH cust_cursor INTO prdct_rec;
        EXIT WHEN cust_cursor%notfound;
        dbms_output.put_line(prdct_rec.product_id
                             || ' '
                             || prdct_rec.product_name
                             || ' - '
                             || prdct_rec.unit_price);

    END LOOP;

    CLOSE cust_cursor;
END;
/

/* --------------Example for Strong Type--------------- */

DECLARE
    TYPE cust_co IS REF CURSOR RETURN customers%rowtype;
    cust_co_var  cust_co;
    cust_rec     customers%rowtype;
BEGIN
    OPEN cust_co_var FOR SELECT
                             *
                         FROM
                             customers
                         WHERE
                             customer_id <= 10;

    LOOP
        FETCH cust_co_var INTO cust_rec;
        EXIT WHEN cust_co_var%notfound;
        dbms_output.put_line(cust_rec.customer_id
                             || ' '
                             || cust_rec.email_address
                             || ' - '
                             || cust_rec.full_name);

    END LOOP;

    CLOSE cust_co_var;
END;
/

/* --------------SYS_REFCURSOR as Argument in PL/SQL Subprogram--------------- */

CREATE OR REPLACE PROCEDURE get_customer_orders (
    p_cust_id     IN   customers.customer_id%TYPE,
    p_out_cursor  OUT  SYS_REFCURSOR
) AS
BEGIN
    OPEN p_out_cursor FOR SELECT
                              customers.full_name,
                              customers.email_address,
                              products.product_name
                          FROM
                                   orders
                              JOIN order_items ON orders.order_id = order_items.order_id
                              JOIN products ON order_items.product_id = products.product_id
                              JOIN customers ON orders.customer_id = customers.customer_id
                          WHERE
                              orders.customer_id = p_cust_id;

END get_customer_orders;
/

DECLARE
    lc_cursor       SYS_REFCURSOR;
    lv_custname     customers.full_name%TYPE;
    lv_custemail    customers.email_address%TYPE;
    lv_prodcutname  products.product_name%TYPE;
BEGIN
    get_customer_orders(5, lc_cursor);
    LOOP
        FETCH lc_cursor INTO
            lv_custname,
            lv_custemail,
            lv_prodcutname;
        EXIT WHEN lc_cursor%notfound;
        dbms_output.put_line(lv_custname
                             || ' - '
                             || lv_custemail
                             || ' - '
                             || lv_prodcutname);

    END LOOP;

    CLOSE lc_cursor;
END;
