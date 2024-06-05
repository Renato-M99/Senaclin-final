/*Criar a o banco, tabelas e relacionar as tableas - DDL*/
CREATE DATABASE senaclin;
USE senaclin;

CREATE TABLE pacientes(
idPaciente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nomePaciente VARCHAR(60) NOT NULL,
cpf VARCHAR(11) NOT NULL UNIQUE, 
tipoLogradouro VARCHAR(200) NOT NULL,
nomeLogradouro VARCHAR (200) NOT NULL,
numero CHAR(4) NOT NULL,
complemento CHAR(5) NOT NULL,
telefone VARCHAR(11) NOT NULL
);

CREATE TABLE dentistas(
idDentista INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
cro VARCHAR(8) NOT NULL UNIQUE, 
especialidade VARCHAR(30) NOT NULL DEFAULT 'geral', 
telefone VARCHAR(11) NOT NULL,
celular VARCHAR(11) NOT NULL,
CONSTRAINT ch_especialidades CHECK (especialidade='ortodontia' OR especialidade='periodontia' 
OR especialidade='implantodontia')
);

CREATE TABLE consultas(
idConsulta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
dataConsulta DATE NOT NULL,
horaConsulta TIME NOT NULL,
tipoConsulta VARCHAR(30) NOT NULL,
idDentista INT NOT NULL,
idPaciente INT NOT NULL,
CONSTRAINT fk_consulta_dentista FOREIGN KEY (idDentista) REFERENCES dentistas(idDentista),
CONSTRAINT fk_consulta_paciente FOREIGN KEY (idPaciente) REFERENCES pacientes(idPaciente)
);

/*1 - Adicionar a coluna cidade na tabela pacientes*/
ALTER TABLE pacientes ADD COLUMN cidade VARCHAR(20) NOT NULL;

/*2 - Adicionar 6 pacientes, sendo 3 de Santos, 1 de Guarujá e 2 de São Vicente.*/
INSERT INTO pacientes(nomePaciente, cpf, tipoLogradouro, nomeLogradouro, numero, complemento, telefone, cidade) 
VALUES ('Jango Fett', '89417261827', 'rua', 'Carvalho de Mendonça', '712', '2', '1325395449', 'Santos'), 
		 ('Padme Amidala', '01685465153', 'avenida', 'Conselheiro Nébias', '304', '12', '1325284879', 'Santos'),
		 ('Anakin Skywalker', '47624927799', 'rua', 'Rio de Janeiro', '102', '8', '1335050651', 'Santos'),
		 ('Sheev Palpatine', '86747319613', 'rua', 'Chile', '314', '21', '1326646877', 'Guarujá'),
		 ('Jabba the Hutts', '97023871837', 'avenida', 'Presidente Wilson', '233', '1', '1334584118', 'São Vicente'),
		 ('Rey Palpatine', '02159983918', 'avenida', 'Presidente Wilson', '233', '1', '1325436561', 'São Vicente');
		 

