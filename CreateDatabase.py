import cx_Oracle
import os

absolute_path = os.path.dirname(__file__)
relative_path = "CREATEDATABASEWITHDATA/DROP_TABLES_SQL.sql"
full_path = os.path.join(absolute_path, relative_path)

print(f"Full path: {full_path}")

with open(full_path, "r") as file:
    sql_commands = file.read()
my_list = sql_commands.splitlines()
non_empty_list = list(filter(None, my_list))
cleaned_statement = [item.replace(";", "") for item in non_empty_list]
try:
    con = cx_Oracle.Connection(user="TESTUSER", password="cmpg311", dsn ="localhost:1521/xe")
    print("Database version:", con.version)
    cursor = con.cursor();
    for x in cleaned_statement:
        print(x)
        cursor.execute(x)
        con.commit()
except cx_Oracle.DatabaseError as e:
    print(f"Error executing SQL: {e}")
finally:
    cursor.close()
    con.close()