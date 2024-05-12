import cx_Oracle
import tkinter as tk
from tkinter import Listbox, Button, ttk

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
con = cx_Oracle.Connection(user="TESTUSER", password="cmpg311", dsn ="localhost:1521/xe")

# Create a cursor
cur = con.cursor()

# Execute the query to get table names
cur.execute("SELECT table_name FROM user_tables")

# Fetch all table names
table_names = [row[0] for row in cur.fetchall()]
table_names_cleared = [x.replace("_", " ") for x in table_names]
# Close the connection
con.close()

# Now you have a list of table names in the 'table_names' variable
print("Available tables:")
for table_name in table_names_cleared:
    print(table_name)




def show_data():
    selected_table = table_listbox.get(tk.ACTIVE)
    # Retrieve data from the selected table and display it
    # You'll need to implement this part based on your requirements
    print(f"Showing data for table: {selected_table}")


root = tk.Tk()
root.title("Table Viewer")
# Calculate the desired window height based on the number of items in the list
window_height = len(table_names) * 20  # Adjust the multiplier as needed

# Set the window size
root.geometry(f"300x{window_height}")

table_listbox = Listbox(root, selectmode=tk.SINGLE, height=len(table_names))
for table_name in table_names_cleared:
    table_listbox.insert(tk.END, table_name)
table_listbox.pack()

def show_selected_item():
    selected_indices = table_listbox.curselection()
    if selected_indices:
        selected_index = selected_indices[0]
        selected_item = table_listbox.get(selected_index)
        print(f"Selected item: {selected_item}")
    else:
        print("No item selected.")
    fetch_data(selected_item)

#show_data_button = Button(root, text="Show Data", command=fetch_data("EMPLOYEE"))
#show_data_button.pack()
show_selected_button = tk.Button(root, text="Show Selected Item", command=show_selected_item)
show_selected_button.pack()

root.mainloop()

