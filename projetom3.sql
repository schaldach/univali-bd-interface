CREATE SCHEMA controle_lius;
use controle_lius;
SET SQL_SAFE_UPDATES = 0;
-- DROP SCHEMA controle_lius;

-- Tecnico(id, cracha, senha)
-- DROP TABLE Tecnico;
CREATE TABLE Tecnico (
    id INT PRIMARY KEY auto_increment,    
    cracha INT(6) NOT NULL UNIQUE,
	senha VARCHAR(8) NOT NULL
);

INSERT INTO Tecnico (cracha, senha) VALUES 
(123456, "abcd1234"),
(100100, "efgh5678"),
(500, "efgh1234"),
(4000, "abcd5678");

SELECT * FROM Tecnico;

-- Troca(id, id_tecnico, motivo, protocolo, data_troca)
-- DROP TABLE Troca;
CREATE TABLE Troca (
    id INT PRIMARY KEY auto_increment,
	id_tecnico INT NOT NULL,
    motivo VARCHAR(200),
    protocolo VARCHAR(32) NOT NULL,
	data_troca DATE NOT NULL,
	FOREIGN KEY (id_tecnico) REFERENCES Tecnico (id)
);

INSERT INTO Troca (id_tecnico, motivo, protocolo, data_troca) VALUES 
(1, NULL, "abcdefgh124", "2024-11-18"),
(2, "Não funcionou", "abcdefgh125", "2024-11-19");

SELECT * FROM Troca;

-- Status_maquina(id, nome)
-- DROP TABLE Status_maquina;
CREATE TABLE Status_maquina (
    id INT PRIMARY KEY auto_increment,
    nome VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO Status_maquina (nome) VALUES 
("Funcionando"),
("Trocado"),
("Esperando troca"),
("Não recebido");

SELECT * FROM Status_maquina;

-- Maquina(id, id_troca, id_status, numero_serie, numero_logico, modelo, data_recebimento)
-- DROP TABLE Maquina;
CREATE TABLE Maquina (
    id INT PRIMARY KEY auto_increment,
	id_troca INT,
    id_status INT NOT NULL,
    numero_serie VARCHAR(9) NOT NULL UNIQUE,
    numero_logico INT(9) NOT NULL UNIQUE,
    modelo VARCHAR(32) NOT NULL UNIQUE,
    data_recebimento DATE NOT NULL,
    FOREIGN KEY (id_troca) REFERENCES Troca(id), 
    FOREIGN KEY (id_status) REFERENCES Status_maquina(id) 
);

INSERT INTO Maquina (id_troca, id_status, numero_serie, numero_logico, modelo, data_recebimento) VALUES 
(NULL, 1, "123abc", 1234, "modelo123", "2024-11-07"),
(1, 2, "123abd", 1235, "modelo124", "2024-11-10"),
(2, 3, "123abe", 1236, "modelo125", "2024-11-11"),
(2, 3, "123abf", 1237, "modelo126", "2024-11-12");

SELECT * FROM Maquina;