import cx_Oracle

def clearTables():
    try:
        con = cx_Oracle.Connection(user="TESTUSER", password="cmpg311", dsn ="localhost:1521/xe")
        print("Database version:", con.version)
        cursor = con.cursor()

        # Retrieve all user tables
        cursor.execute("SELECT table_name FROM user_tables")
        tables = cursor.fetchall()

        # Generate and execute DROP TABLE statements
        for table in tables:
            table_name = table[0]
            cursor.execute(f"DROP TABLE {table_name} CASCADE CONSTRAINTS")
            print(f"Dropped table: {table_name}")
        con.commit()
    except cx_Oracle.DatabaseError as e:
        print(f"Error executing SQL: {e}")
    finally:
        cursor.close()
        con.close()