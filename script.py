print("Hello World")

import mysql.connector
from tabulate import tabulate

# Define connection details
connection = mysql.connector.connect(
    host="localhost",      # Hostname or IP address of your MySQL server
    user=input("Nome do usuário MySQL (admin): "),  # Your MySQL username
    password=input("Senha do usuário MySQL: "), # Your MySQL password
    database="controle_lius"  # Database name to connect to (optional)
)    

commands = [
    {
        "command":["SELECT * FROM "], 
        "required":["Digite o nome da tabela: "]
    },
    {
        "command":["SELECT * FROM ", " WHERE id = "], 
        "required":["Digite o nome da tabela: ", "Digite o id do registro: "]
    },
    {
        "command":["UPDATE "," SET ", " = "," WHERE id = "], 
        "required":["Digite o nome da tabela: ", "Digite o nome da coluna: ", "Digite o novo valor da coluna", "Digite o id do registro: "]
    },
    {
        "command":["DELETE FROM ", " WHERE id = "], 
        "required":["Digite o nome da tabela: ", "Digite o id do registro: "]
    },
    {
        "command":["INSERT INTO ", "(", ") VALUES "], 
        "required":["Digite o nome da tabela: ", "Digite o nome dos campos a serem preenchidos, separados por vírgula (,): ", "Digite os valores a serem preenchidos, começando e terminando com \nparênteses, e separados por vírgula para múltiplas linhas: "]
    }
]

def input_command_fields(choice_number):
    full_command = ""
    for index, command_text in enumerate(commands[choice_number]["command"]):
        full_command += command_text
        full_command += input(commands[choice_number]["required"][index])
    full_command += ";"
    return full_command

try:
    # o "cursor" neste caso não é equivalente ao cursor do MySQL, mas sim apenas uma abstração do Python
    # para interagir com o MySQL e executar comandos
    cursor = connection.cursor()

    while True:
        print("\n-------")
        print("Menu:")
        print("1. Selecionar todos de uma tabela")
        print("2. Selecionar linha de uma tabela")
        print("3. Atualizar um campo de uma linha de uma tabela")
        print("4. Deletar uma linha de uma tabela")
        print("5. Inserir linha(s) em uma tabela")
        print("6. Digitar comando SQL customizado")
        print("7. Sair")
        print("-------\n")
        choice = int(input("Escolha uma opção: "))
        

        # se a escolha está entre 1 e 6
        if choice in list(range(1,7)):
            # se for 6, pedimos o comando, senão, montamos ele de acordo com os comandos pré-determinados
            full_command = input_command_fields(choice-1) if choice<6 else input("Digite o comando SQL a ser executado: ")

            try:
                # executar comando retornado
                cursor.execute(full_command)
            except mysql.connector.Error as e:
                print(f"Ocorreu o seguinte erro: {e}")
                continue

            # se foi feito um select, mostrar os resultados (iremos detectar de forma automática)
            if full_command.strip().upper().startswith("SELECT"):
                # fetchall() irá pegar todas as linhas resultadas do último SELECT executado
                results = cursor.fetchall()
                print("\n"+tabulate(results, headers=[tup[0] for tup in cursor.description]))
                # o tabulate irá receber uma lista de tuplas e imprimir de forma organizada
                # cursor.description terá informações sobre cada uma das colunas, em tuplas, e o 1° item da tupla é o nome da coluna
            # senão, executar o comando
            else:
                # equivalente ao comando COMMIT; se estivesse em uma transação, o que irá 
                # efetivamente executar o comando e alterar os dados na base de dados
                connection.commit()
            print("\nComando executado com sucesso!")

        elif choice == 7:
            print("Saindo...")
            break

        else:
            print("Opção inválida, tente novamente")
        input("Digite Enter para continuar")

except mysql.connector.Error as e:
    print("Ocorreu o seguinte erro: "+e)

finally:
    cursor.close()
    connection.close()