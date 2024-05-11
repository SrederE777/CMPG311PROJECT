import getpass
import oracledb

#userDB = getpass.getuser("Enter user: ")
#pw = getpass.getpass("Enter password: ")

connection = oracledb.connect(
    user="TESTPROJECT",
    password="cmpg311",
    dsn="localhost/xe")

print("Successfully connected to Oracle Database")

cursor = connection.cursor()

# Create a table

