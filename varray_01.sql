DECLARE
    TYPE va_char_type IS
        VARRAY(4) OF VARCHAR(15);
    v1  va_char_type := va_char_type('East', 'West', 'North', 'South');  -- initialize varray in declaration using constructor
    v2  va_char_type; -- Not initialized, hence this null
    v3  va_char_type := va_char_type(); -- initialize empty varray 
BEGIN

       v2 := va_char_type('North-East', 'South-East'); -- initialize varray here using constructor
    
        dbms_output.put_line('Iterating varray v1');
    FOR i IN 1..v1.count LOOP
        dbms_output.put_line('Index : '
                             || i
                             || ' and Value : '
                             || v1(i));
    END LOOP;

    dbms_output.put_line('Iterating varray v2');
    FOR i IN 1..v2.count LOOP
        dbms_output.put_line('Index : '
                             || i
                             || ' and Value : '
                             || v2(i));
    END LOOP;
    
    -- in case of v3, first lets extend (Assigning Null Values to Varray)
    v3.extend(1);
    v3(1) := 'Hello';
    v3.extend(1);
    v3(2) := 'Hello Again!';
    
        dbms_output.put_line('Iterating varray v3');
    FOR i IN 1..v3.count LOOP
        dbms_output.put_line('Index : '
                             || i
                             || ' and Value : '
                             || v3(i));
    END LOOP;

END;
/