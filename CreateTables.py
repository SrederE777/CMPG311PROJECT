import cx_Oracle
import os

def createTables():
    # Define the path to your SQL file
    absolute_path = os.path.dirname(__file__)
    relative_path = "CREATEDATABASEWITHDATA/create_table_statements.sql"
    full_path = os.path.join(absolute_path, relative_path)

    print(f"Full path: {full_path}")

    # Connect to your Oracle database
    con = cx_Oracle.connect(user="TESTUSER", password="cmpg311", dsn="localhost:1521/xe")

    try:
        cursor = con.cursor()

        # Read the SQL commands from the file
        with open(full_path, "r") as file:
            sql_commands = file.read()

        # Split the commands based on semicolons
        commands = sql_commands.split(";")

        # Execute each command
        for command in commands:
            if command.strip():  # Skip empty lines
                cursor.execute(command)
                print(f"Executed: {command.strip()}")

        # Commit the changes
        con.commit()
        print("All commands executed successfully!")
    except cx_Oracle.DatabaseError as e:
        print(f"Error executing SQL: {e}")
    finally:
        cursor.close()
        con.close()
