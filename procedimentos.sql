use sistemaAcademico

---------------------------------------------------- INSERE NOTA ----------------------------------------------
ALTER PROCEDURE pc_insereNota(@ra INT, @disciplina VARCHAR(10), @avaliacao INT, @nota DECIMAL(7,2))
AS
	DECLARE @verificaAluno INT

	SET @verificaAluno = (SELECT COUNT(*) FROM notas WHERE ra_aluno = @ra 
													 AND codigo_disciplina = @disciplina
													 AND codigo_avaliacao = @avaliacao)
	
	--A procedure vai verificar se esse aluno já teve nota na avaliacao dessa disciplina
	--Se sim, o prof pode fazer um UPDATE e atualizar a nota
	--Se não, ele faz um INSERT
	IF(@verificaAluno = 1)
	BEGIN
		UPDATE notas
		SET nota = @nota
		WHERE ra_aluno = @ra 
			  AND codigo_disciplina = @disciplina
			  AND codigo_avaliacao = @avaliacao
	END
	ELSE 
	BEGIN
		INSERT INTO notas VALUES
		(@ra, @disciplina, @avaliacao, @nota)
	END

---------------------------------------------------- INSERE FALTAS ----------------------------------------------
ALTER PROCEDURE pc_insereFalta(@ra INT, @disciplina VARCHAR(10), @datas DATE, @presenca INT)
AS
	DECLARE @verificaDisciplina INT, 
			@verificaAluno INT

	--Verifica se a quantidade de @presenca é valida para a @disciplina
	SET @verificaDisciplina = (SELECT num_aulas FROM disciplina WHERE codigo = @disciplina) / 20
	--Verifica se o aluno já teve faltas nesse dia (UPDATE) ou não (INSERT)
	SET @verificaAluno = (SELECT COUNT(*) FROM faltas WHERE ra_aluno = @ra
												      AND codigo_disciplina = @disciplina
													  AND datas = @datas)
	IF(@presenca > @verificaDisciplina)
	BEGIN
		RAISERROR ('Você ultrapassou o limite de faltas/presenças permitidas por dia',16,1)
	END
	ELSE
	BEGIN
		PRINT 'Faltas/presenças permitidas'
		IF(@verificaAluno = 1)
		BEGIN
			PRINT 'UPDATE'
		UPDATE faltas
		SET presenca = @presenca
		WHERE ra_aluno = @ra
			  AND codigo_disciplina = @disciplina
			  AND datas = @datas
		END
		ELSE
		BEGIN
			PRINT 'INSERT'
			INSERT INTO faltas VALUES
			(@ra, @disciplina, @datas, @presenca)
		END
	END

---------------------------------------------------- FUNCTION NOTAS  ----------------------------------------------
--APRESENTAR EM TELA, A SAIDA DE UMA UDF, COM CURSOR, QUE APRESENTA UM QUADRO COM AS NOTAS DA TURMA:
--(RA_Aluno, nome_aluno, nota1, nota2, Media final, situação)
CREATE FUNCTION fn_notas()
RETURNS @tabela TABLE(
ra_aluno INT,
nome_aluno VARCHAR(100),
nota1
nota2
nota3



--teste insere falta
exec pc_insereFalta @ra = 11101, @disciplina = '4203-010', @datas = '02/11/2022', @presenca = 2
exec pc_insereFalta @ra = 11101, @disciplina = '4203-010', @datas = '03/11/2022', @presenca = 4

select * from faltas
delete faltas

SELECT SUM(presenca) 
FROM faltas
WHERE ra_aluno = 11101
	 AND codigo_disciplina = '4203-010'

--teste insere nota
exec pc_insereNota @ra = 11101, @disciplina = '4203-010', @avaliacao = 1, @nota = 8

select * from notas
delete notas


