SET SERVEROUTPUT ON;

DECLARE
/*
+ Array in other languages - VARRAY in PL/SQL: Collection of items of same datatype & has a maximum size. 
+ When defining a VARRAY type, you must specify its maximum size. So fixed upper bound. Subscript is integer (i.e. index) starts from 1
+ VARRAY is always dense (consecutive subscript). You cannot delete an item in middle, but we can trim elements from end. 
+ VARRAY is preferred when no. of elements known & accessed using sequence i.e. index.
*/
    TYPE va_int_type IS
        VARRAY(5) OF NUMBER;
    v1 va_int_type := va_int_type();  -- initialize varray in declaration using constructor
BEGIN
    v1.extend(4);
    v1(1) := 100;
    v1(2) := 200;
    v1(3) := 203;
    v1(4) := 206;
    dbms_output.put_line('Iterating varray v1');
    FOR i IN 1..v1.count LOOP
        dbms_output.put_line('Index : '
                             || i
                             || ' and Value : '
                             || v1(i));
    END LOOP;
    
     
    -- TRIM removes last element and TRIM(n) removes n elements from the array.
    -- trim last 2 elements.
                v1.trim(2);
    dbms_output.put_line('Iterating varray v1 again, after doing triming last 2');
    FOR i IN 1..v1.count LOOP
        dbms_output.put_line('Index : '
                             || i
                             || ' and Value : '
                             || v1(i));
    END LOOP;
    
    -- adding elements again 
                v1.extend(3);
    v1(3) := 300;
    v1(4) := 303;
    v1(5) := 306;
    --v1(6):= 400; --{'Subscript outside of limit' exception occured if value assiged for 6th index. You cannot do that, as array size is fixed for 5}
    
                    dbms_output.put_line('Iterating varray v1 again, after adding new elements');
    FOR i IN 1..v1.count LOOP
        dbms_output.put_line('Index : '
                             || i
                             || ' and Value : '
                             || v1(i));
    END LOOP;

    dbms_output.put_line('Deleteing varray v1. It will delete all elements of varray');
    --Varrays are dense, so you cannot delete their individual elements
            v1.DELETE;
    dbms_output.put_line('Count of varray v1: ' || v1.count);
END;
/
