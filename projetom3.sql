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
(123456, "abcd1234");

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

-- Status_maquina(id, nome)
-- DROP TABLE Status_maquina;
CREATE TABLE Status_maquina (
    id INT PRIMARY KEY auto_increment,
    nome VARCHAR(30) NOT NULL UNIQUE
);

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