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