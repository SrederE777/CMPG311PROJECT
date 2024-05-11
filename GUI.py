import customtkinter as ctk
from tkinter import messagebox
import sqlite3

# Function to execute SQL query
def execute_query(query):
    try:
        # Connect to your database
        connection = sqlite3.connect(r'queries.sql')
        cursor = connection.cursor()

        # Execute the query
        cursor.execute(query)

        # Fetch results if any
        results = cursor.fetchall()

        # Commit the transaction
        connection.commit()

        # Close the cursor and connection
        cursor.close()
        connection.close()

        return results

    except Exception as e:
        return str(e)

# Function to handle button click event
def execute_button_click():
    query = query_text.get("1.0", ctk.END)
    results = execute_query(query)

    if isinstance(results, str):
        messagebox.showerror("Error", results)
    else:
        messagebox.showinfo("Results", "Query executed successfully!")


# Create the main window
root = ctk.CTk()
root.title("SQL Query Executor")

# Create a text box for entering SQL queries
query_text = ctk.CTkTextbox(root, width=350, height=100)
query_text.pack(pady=10,padx=10)

# Create a button to execute the query
execute_button = ctk.CTkButton(root, text="Execute Query", command=execute_button_click)
execute_button.pack(pady=10,padx=10)

# Start the GUI main loop
root.mainloop()

