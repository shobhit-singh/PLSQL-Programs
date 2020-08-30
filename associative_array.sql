DECLARE
/*
+ Similar to hash tables in other programming languages. Dictionary in Python, like Key-Value pair. 
+ Index-by tables, also known as associative arrays
+ Associative arrays are set of Key-Value pair. Each key is unique & locate to use corresponding value in the array.
+ Key - String/PLS_Integer.  Value can be any PL/SQL datatype like Varchar2, Integer. (Check Oracle Documentation for restrictions if any )
+ It can be dense or sparse - i.e. no consecutive index order.
*/

        TYPE direction IS
        TABLE OF VARCHAR2(15) INDEX BY VARCHAR2(2);
    TYPE error_code IS
        TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    TYPE state_info IS RECORD (
        state_code  CHAR(2),
        state_name  VARCHAR2(20)
    );
    TYPE states IS
        TABLE OF state_info INDEX BY PLS_INTEGER;
    lv_direction_dict   direction;
    lv_error_code_dict  error_code;
    lv_states           states;
    ln_index            VARCHAR2(2);
BEGIN
/* TABLE OF VARCHAR2(10) INDEX BY VARCHAR2(2) */
        lv_direction_dict('N') := 'North';
    lv_direction_dict('S') := 'South';
    lv_direction_dict('E') := 'East';
    lv_direction_dict('W') := 'West';
    lv_direction_dict('NE') := 'North-East';
    dbms_output.put_line(lv_direction_dict('N')); -- Accessing Single Value
  --dbms_output.put_line(lv_direction_dict('E')); -- Accessing Single Value
    
        ln_index := lv_direction_dict.first;
/*Iteration*/
    WHILE ln_index IS NOT NULL LOOP
        dbms_output.put_line(ln_index
                             || ':'
                             || lv_direction_dict(ln_index));
        ln_index := lv_direction_dict.next(ln_index);
    END LOOP;

    dbms_output.put_line('*************************************************'); 
    /* TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER */
    
        lv_error_code_dict(100) := 'Continue';
    lv_error_code_dict(200) := 'Ok';
    lv_error_code_dict(400) := 'Non-Authorized';
    lv_error_code_dict(203) := 'Bad Request';
    dbms_output.put_line('Error Code 200 Description :' || lv_error_code_dict(200)); -- Accessing Signle Value
        dbms_output.put_line('Error Code 400 Description :' ||
    lv_error_code_dict(400)); -- Accessing Signle Value
    
    /* TABLE OF Composite Datatype INDEX BY PLS_INTEGER */
        dbms_output.put_line('*************************************************');
    lv_states(1).state_code := 'JK';
    lv_states(1).state_name := 'Jammu & Kashmir';
    lv_states(2).state_code := 'HP';
    lv_states(2).state_name := 'Himachal Pradesh';
    lv_states(3).state_code := 'PB';
    lv_states(3).state_name := 'Punjab';
    lv_states(7).state_code := 'DL';
    lv_states(7).state_name := 'Delhi';
    lv_states(9).state_code := 'UP';
    lv_states(9).state_name := 'Uttar Pradesh';
    lv_states(29).state_code := 'KA';
    lv_states(29).state_name := 'Karnataka';
    lv_states(32).state_code := 'KL';
    lv_states(32).state_name := 'Kerala';
    FOR i IN 1..37 LOOP
        BEGIN
            dbms_output.put_line(lv_states(i).state_code
                                 || ':'
                                 || lv_states(i).state_name);

        EXCEPTION
            WHEN OTHERS THEN
                NULL;--key not available
            END;
    END LOOP;

END;
/
