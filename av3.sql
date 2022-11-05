CREATE DATABASE sistemaAcademico
go
USE sistemaAcademico

CREATE TABLE aluno
(
ra        INT                NOT NULL,
nome    VARCHAR(100)    NOT NULL
PRIMARY KEY(ra)
)

--INSERT ALUNO
INSERT INTO aluno VALUES
(11101, 'Freddy Krueger'),
(11102, 'Jason Voorhees'),
(11103, 'Michael Myers'),
(11104, 'Pennywise'),
(11105, 'Chucky'),
(11106, 'Jigsaw'),
(11107, 'Annabelle'),
(11108, 'Samara'),
(11109, 'Carrie'),
(11110, 'Sadako'),
(11111, 'Regan McNeil')

CREATE TABLE disciplina
(
codigo       VARCHAR(10)        NOT NULL,
nome		 VARCHAR(100)		NOT NULL,
sigla        CHAR(3)            NOT NULL,
turno        VARCHAR(1)         NOT NULL,
num_aulas    INT                NOT NULL
PRIMARY KEY(codigo)
)

INSERT INTO disciplina VALUES
('4203-010', 'Arquitetura e Organização de Computadores', 'AOC', 'T', 80),
('4203-020', 'Arquitetura e Organização de Computadores', 'AOC', 'N', 80),
('4208-010', 'Laboratório de Hardware', 'LH', 'T', 40),
('4226-004', 'Banco de Dados', 'BD', 'T', 80),
('4213-003', 'Sistemas Operacionais I', 'SOI', 'T', 80),
('4213-013', 'Sistemas Operacionais I', 'SOI', 'N', 80),
('4233-005', 'Laboratório de Banco de Dados', 'LBD', 'T', 80),
('5005-220', 'Métodos Para a Produção do Conhecimento', 'MPC', 'M', 40)


CREATE TABLE avaliacao
(
codigo				INT            NOT NULL,
tipo				VARCHAR(10)    NOT NULL
PRIMARY KEY(codigo)
)

INSERT INTO avaliacao VALUES
(1, 'P1'),
(2, 'P2'),
(3, 'P3'),
(4, 'P4'),
(5, 'PRE P3'),
(6, 'T')

CREATE TABLE notas
(
ra_aluno            INT				NOT NULL,
codigo_disciplina   VARCHAR(10)		NOT NULL,
codigo_avaliacao    INT				NOT NULL,
nota                DECIMAL(7,2)    NOT NULL
PRIMARY KEY(ra_aluno, codigo_disciplina, codigo_avaliacao),
FOREIGN KEY(ra_aluno) REFERENCES aluno(ra),
FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo),
FOREIGN KEY(codigo_avaliacao) REFERENCES avaliacao(codigo)
)

CREATE TABLE faltas
(
ra_aluno            INT				NOT NULL,
codigo_disciplina   VARCHAR(10)    NOT NULL,
datas               DATE			NOT NULL,
presenca            INT				NOT NULL
PRIMARY KEY(ra_aluno, codigo_disciplina, datas)
FOREIGN KEY(ra_aluno) REFERENCES aluno(ra),
FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo)
)

SELECT * FROM disciplina
SELECT * FROM aluno
SELECT * FROM avaliacao
SELECT * FROM faltas
SELECT * FROM notas


