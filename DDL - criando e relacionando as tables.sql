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
		 
/*3.	Inserir 4 dentistas de forma explícita, sendo 1 de cada especialidade*/

INSERT INTO dentistas(especialidade, cro, telefone, celular, nomeDentista) VALUES
('ortodontia', '12345678', '1438671432', '1996883224', 'Chirs Taub');
INSERT INTO dentistas(especialidade, cro, telefone, celular, nomeDentista) VALUES
('periodontia', '23456780', '1135273071', '1137607653', 'Gregory House');
INSERT INTO dentistas(especialidade, cro, telefone, celular, nomeDentista) VALUES
('implantodontia', '08764521', '1834384025', '1823572516', 'Robert Chase');
INSERT INTO dentistas(especialidade, cro, telefone, celular, nomeDentista) VALUES
('geral', '87654321', '1629588345', '1298737730', 'Mike Kutner');


/*4 - Inserir 3 consultas, sendo 1 para o dentista que cuida de Ortodontia e 2 para o dentista cuja especialidade é Geral. O tipo de todas elas será Avaliação.*/

/*inserir observações (esqueci)*/
ALTER TABLE consultas ADD COLUMN observacao TEXT(500);

INSERT INTO consultas(dataConsulta, horaConsulta, tipoConsulta, idDentista, idPaciente)
VALUES ('2024-03-01','10:30:00','Avaliação' , 4, 1); 
INSERT INTO consultas(dataConsulta, horaConsulta, tipoConsulta, idDentista, idPaciente)
VALUES ('2024-03-02','04:30:00','Avaliação' , 4, 2); 
INSERT INTO consultas(dataConsulta, horaConsulta, tipoConsulta, idDentista, idPaciente)
VALUES ('2024-05-12','07:34:00','Avaliação' , 1, 4); 

/*5.	Atualizar todos os dados, exceto nome e cro, do dentista que cuida de implantodontia, mudando sua especialidade para Geral;*/

UPDATE dentistas SET telefone = '1321562335', celular = '1220336736', especialidade = 'geral' WHERE idDentista = 3;

/*6. Atualizar a data e hora de uma consulta marcada com um dentista cuja especialidade é Geral;*/

UPDATE consultas SET dataConsulta = '2024-03-14', horaConsulta = '08:40:00' WHERE idPaciente = 2; 

/*7.	Atualizar a consulta do dentista de especialidade ortodontia, mudando o tipo de consulta para Tratamento e 
inserindo uma observação do dentista com o seguinte texto: “Tratamento será realizado em 10 consultas. 
Prioridade: Moderada. Remédio aplicado: Ponstan, caso sinta dores”*/

UPDATE consultas SET observacao = 'Tratamento será realizado em 10 consultas. 
Prioridade: Moderada. Remédio aplicado: Ponstan, caso sinta dores', consultas.tipoConsulta = 'tratamento' WHERE idDentista = 1;

/*8.	Selecionar nome e telefone de todo os pacientes que residem em Santos, em ordem alfabética;*/

SELECT pacientes.nomePaciente, pacientes.telefone FROM pacientes ORDER BY nomePaciente;

/*9 - Selecionar o nome dos dentistas, a datas da consulta, o nome do paciente e seu telefone, APENAS dos dentistas que possuem consultas*/

SELECT dentistas.nomeDentista, consultas.dataConsulta, pacientes.nomePaciente, pacientes.telefone FROM consultas
INNER JOIN dentistas ON dentistas.idDentista = consultas.idDentista
INNER JOIN pacientes ON pacientes.idPaciente = consultas.idPaciente WHERE consultas.idDentista > 0;

/*10.	Selecionar o nome do dentista, a data da consulta e o tipo da consulta, MESMO quando os dentistas não possuam consultas; */

SELECT dentistas.nomeDentista, consultas.dataConsulta, consultas.tipoConsulta FROM dentistas
LEFT JOIN consultas ON consultas.idConsulta = dentistas.idDentista WHERE dentistas.idDentista > 0;

