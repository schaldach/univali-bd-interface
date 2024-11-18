print("Hello World")

import mysql.connector

# Define connection details
connection = mysql.connector.connect(
    host="localhost",      # Hostname or IP address of your MySQL server
    user=input("Nome do usuário MySQL (admin): "),  # Your MySQL username
    password=input("Senha do usuário MySQL: "), # Your MySQL password
    database="controle_lius"  # Database name to connect to (optional)
)

if connection.is_connected():
    print("Connected to MySQL database!")

try:
    # precisaremos documentar cada comando feito pelo cursor em MySQL...
    cursor = connection.cursor()

    # Execute a query
    cursor.execute("SELECT * FROM Tecnico;")
    
    # Fetch results
    results = cursor.fetchall()
    for row in results:
        print(row)

finally:
    # Close cursor and connection
    cursor.close()
    connection.close()