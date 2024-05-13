import cx_Oracle
import os
def insertDataIntoTables():
    # Define the path to your SQL files directory
    absolute_path = os.path.dirname(__file__)
    relative_path = "CREATEDATABASEWITHDATA"
    full_path = os.path.join(absolute_path, relative_path)

    # Connect to your Oracle database
    con = cx_Oracle.connect(user="TESTUSER", password="cmpg311", dsn="localhost:1521/xe")
    error_list = []
    try:
        cursor = con.cursor()

        # Iterate through SQL files in the directory
        for filename in os.listdir(full_path):
            if filename.endswith("_DATA.sql"):
                filepath = os.path.join(full_path, filename)
                with open(filepath, "r") as file:
                    sql_commands = file.read()

                    # Split the commands based on semicolons
                    commands = sql_commands.split(";")

                    # Execute each command
                    for command in commands:
                        if command.strip():  # Skip empty lines
                            try:
                                cursor.execute(command)
                                print(f"Executed: {command.strip()}")
                            except cx_Oracle.DatabaseError as e:
                                error_list.append(f"Error executing SQL: {e} for command {command.strip()}")
            
        if error_list:
            print("\nErrors encountered:")
            for error in error_list:
                print(error)
        else:
            print("All SQL files executed successfully!")
        # Commit the changes
        con.commit()
        
    except cx_Oracle.DatabaseError as e:
        print(f"Error executing SQL: {e}")
    finally:
        cursor.close()
        con.close()
