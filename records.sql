SET SERVEROUTPUT ON;

DECLARE
/*
+ Creating record 'my_record_table; based on row of table user-objects.
+ Using %ROWTYPE – attribute provides a record type that represents a row in a database table
*/
      my_record_table user_objects%rowtype;
BEGIN
    SELECT
        *
    INTO my_record_table
    FROM
        user_objects
    WHERE
        object_name = 'DUAL';

    dbms_output.put_line('OBJECT_TYPE : ' || my_record_table.object_type);
END;
/

DECLARE
/*Creating record 'my_record_cursor' based on row of explicit cursor. */
      CURSOR my_cursor IS
    SELECT
        *
    FROM
        user_objects
    WHERE
        object_name = 'DUAL';

    my_record_cursor my_cursor%rowtype;
BEGIN
    OPEN my_cursor;
    FETCH my_cursor INTO my_record_cursor;
    dbms_output.put_line('OBJECT_TYPE : ' || my_record_cursor.object_type);
    CLOSE my_cursor;
END;
/

DECLARE
/*
Defining a rcords using TYPE & Records statement. Later on creating instance of that type. my_record

TYPE type_name IS RECORD
   (field1 data_type1 [NOT NULL] := [DEFAULT VALUE],
    field2 data_type2 [NOT NULL] := [DEFAULT VALUE],
    field3 data_type3 [NOT NULL] := [DEFAULT VALUE]
    ...
    );
*/
    TYPE my_rec_type IS RECORD (
        object_type  user_objects.object_type%TYPE,
        created      user_objects.created%TYPE
    );
    my_record my_rec_type;
BEGIN
    SELECT
        object_type,
        created
    INTO my_record
    FROM
        user_objects
    WHERE
        object_name = 'DUAL';

    dbms_output.put_line('OBJECT_TYPE : ' || my_record.object_type);
    dbms_output.put_line('CREATED : ' || my_record.created);
END;
/

/* Creating Record Type at Database Level */

CREATE TYPE obj_type AS OBJECT (
    object_name  VARCHAR2(128),
    object_type  VARCHAR2(23),
    created      DATE
);
/
