import cx_Oracle
import tkinter as tk
from tkinter import  Button, ttk
import os

def fetch_data(table):
    
    # Connect to Oracle database
    con = cx_Oracle.Connection(user="TESTUSER", password="cmpg311", dsn ="localhost:1521/xe")

    # Create a cursor
    cur = con.cursor()
    underscoreTable = table.replace(" ", "_")
    # Execute your query (replace with your actual query)
    cur.execute(f"SELECT * FROM {underscoreTable}")
    data = cur.fetchall()
    
    cur.execute(f"SELECT column_name FROM user_tab_columns WHERE table_name = '{underscoreTable}'")
    columnNames = cur.fetchall()
    for column in columnNames:
        print(column)
    # Close the connection
    con.close()

    # Create a new window for displaying the table
    table_window = tk.Toplevel(root)
    table_window.title("Oracle Data Table")

    # Create a Treeview widget in the new window
    table = ttk.Treeview(table_window, columns=columnNames, show = "headings")
    
    for n,column in enumerate(columnNames):
        table.heading(f"#{n+1}", text=column[0].replace("_", " "))
   
    # Insert data into the Treeview
    for i,row in enumerate(data):
        table.insert("", i, values=row)

    scrollbar = ttk.Scrollbar(table_window, orient="vertical", command=table.yview)
    table.configure(yscrollcommand=scrollbar.set)
    scrollbar.pack(side="right", fill="y")

    # Pack the Treeview
    table.pack(fill="both", expand=True)
    # Replace with your actual database connection details
def querry_data(path):
    # Connect to Oracle database
    con = cx_Oracle.Connection(user="TESTUSER", password="cmpg311", dsn="localhost:1521/xe")

    # Create a cursor
    cur = con.cursor()
    with open(path, "r") as file:
        sql_commands = file.read()
    sql = sql_commands.replace(";","").replace("\n", " ")
    # Execute your query (replace with your actual query)
    cur.execute(sql)
    data = cur.fetchall()
    column_names = [i[0] for i in cur.description]

    # Close the connection
    con.close()

    # Create a new window for displaying the table
    table_window = tk.Toplevel(root)
    table_window.title("Oracle Query Table")

    # Create a Treeview widget in the new window
    table = ttk.Treeview(table_window, columns=column_names, show="headings")

    # Set column headings
    for n,column in enumerate(column_names):
        table.heading(f"#{n+1}", text=column.replace("_", " "))

    # Insert data into the Treeview
    for i, row in enumerate(data):
        table.insert("", i, values=row)

    # Add a vertical scrollbar
    scrollbar = ttk.Scrollbar(table_window, orient="vertical", command=table.yview)
    table.configure(yscrollcommand=scrollbar.set)
    scrollbar.pack(side="right", fill="y")

    # Pack the Treeview
    table.pack(fill="both", expand=True)
def show_selected_item(cb):
    selected_item = cb.get()
    if selected_item:
        print(f"Selected item: {selected_item}")
        # Call your fetch_data function with the selected item
        return selected_item
    else:
        print("No item selected.")
con = cx_Oracle.Connection(user="TESTUSER", password="cmpg311", dsn ="localhost:1521/xe")
cur = con.cursor()
cur.execute("SELECT table_name FROM user_tables")

# Fetch all table names
table_names = [row[0] for row in cur.fetchall()]
table_names_cleared = [x.replace("_", " ") for x in table_names]
con.close()

#Fetch all query names
absolute_path = os.path.dirname(__file__)
relative_path = "Queries"
full_path = os.path.join(absolute_path, relative_path)
file_list = os.listdir(full_path)
querry_list_without_sql_and_ = [file.replace("_", " ").replace(".sql", "") for file in file_list]
querry_list_final = [file[0].upper() + file[1:] for file in querry_list_without_sql_and_]

print("Files in the folder:")
for filename in file_list:
    print(filename)

#Create windows
root = tk.Tk()
root.title("Table Viewer")
window_height = 200 
root.geometry(f"300x{window_height}")

#generate combobox components
combobox = ttk.Combobox(root, values=table_names_cleared, state= "readonly")
combobox.current(0)
query_list_combobox = ttk.Combobox(root,values = querry_list_final, state = "readonly")
query_list_combobox.current(0)

#button functions
def button1():
    fetch_data(show_selected_item(combobox))
def button2():
    QuerryFilePath = os.path.join(full_path,file_list[query_list_combobox.current()])
    querry_data(QuerryFilePath)

#generate button components
show_table_button = tk.Button(root, text="Show Table Item", command=button1)
show_querry_button = tk.Button(root, text="Show Query Item", command=button2)

#display all the functions
combobox.pack()
show_table_button.pack()
query_list_combobox.pack()
show_querry_button.pack()

root.mainloop()

