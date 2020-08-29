PL/SQL-Programs

___

[PL/SQL Varray](https://github.com/shobhit-singh/PLSQL-Programs/blob/master/varray_01.sql)
<br>
Array of Integers A[7]
|Index|1|2|3|4|5|6|7|
|-|-|-|-|-|-|-|-|
|Value|21|34|44|45|77|78|99|
+ Array in other languages - VARRAY in PL/SQL: Collection of items of same datatype & has a maximum size. 
+ When defining a VARRAY type, you must specify its maximum size. So fixed upper bound. Subscript is integer (i.e. index) starts from 1
+ VARRAY is always dense (consecutive subscript). You cannot delete an item in middle, but we can trim elements from end. 
+ Preferred when no of elements known & accessed using  sequence i.e. index 
