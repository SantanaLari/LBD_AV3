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

---------------------------------------------------- FUNCTION NOTAS [incompleto] ----------------------------------------------
ALTER FUNCTION fn_notas(@codDisciplina VARCHAR(10))
RETURNS @tabela TABLE(
ra_aluno INT,
nome_aluno VARCHAR(20),
nota1 DECIMAL(7,2), --P1
nota2 DECIMAL(7,2), --P2
nota3 DECIMAL(7,2), --Trabalho / P3(LBD)
nota4 DECIMAL(7,2), --PRE P3 (SOI)
exame DECIMAL(7,2), --EXAME
media_final DECIMAL(7,2),
situacao VARCHAR(20)
)
AS 
BEGIN
	DECLARE @ra INT,
			@avaliacao INT,
			@nota DECIMAL(7,2),
			@nome VARCHAR(20),
			@media DECIMAL(7,2),
			@situacao VARCHAR(20),
			@P3 DECIMAL(7,2),
			@tipo INT,
			@exame DECIMAL(7,2)
	SET @media = 0
	SET @P3 = 0


	DECLARE c CURSOR FOR
		SELECT DISTINCT ra_aluno FROM notas WHERE codigo_disciplina = @codDisciplina
	OPEN c
	FETCH NEXT FROM c INTO @ra
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @nome = (SELECT nome from aluno WHERE ra = @ra)
		INSERT INTO @tabela VALUES(@ra, @nome, 0, 0, 0, 0, 0, 0, NULL)
		
	--------------------------------------------------------------------------------------
		DECLARE c1 CURSOR FOR
			SELECT codigo_avaliacao, nota FROM notas WHERE codigo_disciplina = @codDisciplina AND ra_aluno = @ra
		OPEN c1
		FETCH NEXT FROM c1 INTO @avaliacao, @nota
		WHILE @@FETCH_STATUS = 0
		BEGIN

		IF((@codDisciplina = '4203-010') OR (@codDisciplina = '4203-020') OR (@codDisciplina = '4208-010') OR (@codDisciplina = '4226-004')) 
		BEGIN
			SET @tipo = 1
		END
		ELSE 
		IF ((@codDisciplina = '4213-003') OR (@codDisciplina = '4213-013'))
		BEGIN
			SET @tipo = 2
		END
		IF(@codDisciplina = '4233-005')
		BEGIN
			SET @tipo = 3
		END
		ELSE
		IF(@codDisciplina = '5005-220')
		BEGIN
			SET @tipo = 4
		END
		
		IF (@avaliacao = 1) -- P1
		BEGIN
			UPDATE @tabela
			SET nota1 = @nota, media_final = (SELECT dbo.calculaNota(@avaliacao, @nota, @tipo)) + media_final
			WHERE ra_aluno = @ra
		END
		IF (@avaliacao = 2) -- P2
		BEGIN
			UPDATE @tabela
			SET nota2 = @nota, media_final = (SELECT dbo.calculaNota(@avaliacao, @nota, @tipo)) + media_final
			WHERE ra_aluno = @ra
		END
		IF (@avaliacao = 6) -- TRABALHO
		BEGIN
			UPDATE @tabela
			SET nota3 = @nota, media_final = (SELECT dbo.calculaNota(@avaliacao, @nota, @tipo)) + media_final
			WHERE ra_aluno = @ra
		END
		-------------------------------------------EXCEÇÕES
		--P3 DE LBD
		IF (@avaliacao = 3) AND (@tipo = 3)
		BEGIN
			UPDATE @tabela
			SET nota3 = @nota, media_final = (@nota * 0.333) + media_final
			WHERE ra_aluno = @ra
		END
		--PRE P3 DE SOI
		IF(@avaliacao = 5) AND (@tipo = 2)
		BEGIN
			UPDATE @tabela
			SET nota4 = @nota, media_final = (@nota * 0.2) + media_final
			WHERE ra_aluno = @ra
		END
		
		FETCH NEXT FROM c1 INTO @avaliacao, @nota
		END
		CLOSE c1
		DEALLOCATE c1
	--------------------------------------------------------------------------------------
		SET @media = (SELECT media_final FROM @tabela WHERE ra_aluno = @ra)
		IF(@media >= 6)
		BEGIN
			UPDATE @tabela
			SET situacao = 'Aprovado'
			WHERE ra_aluno = @ra
		END
		ELSE
		IF (@media < 6)
		BEGIN
			UPDATE @tabela
			SET situacao = 'Analise'
			WHERE ra_aluno = @ra
		END
	
	FETCH NEXT FROM c INTO @ra
	END
	CLOSE c
	DEALLOCATE c
	RETURN
END
---------------------------------------------- FUNCTION QUE CALCULA NOTA
ALTER FUNCTION calculaNota(@avaliacao INT, @nota DECIMAL(7,2), @tipo INT)
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @calcNota DECIMAL(7,2)
	
------------------------------------- P1
	IF(@avaliacao = 1)
	BEGIN
		IF(@tipo = 1)
		BEGIN
			SET @calcNota = @nota * 0.3
		END
		ELSE 
		IF (@tipo = 2)
		BEGIN 
			SET @calcNota = @nota * 0.35
		END
		ELSE
		IF (@tipo = 3)
		BEGIN
			SET @calcNota = @nota * 0.333
		END
		ELSE
		IF(@tipo = 4)
		BEGIN
			SET @calcNota = @nota * 0.8
		END
	END

------------------------------------- P2
	IF(@avaliacao = 2)
	BEGIN
		IF(@tipo = 1)
		BEGIN
			SET @calcNota = @nota * 0.5
		END
		ELSE 
		IF (@tipo = 2)
		BEGIN 
			SET @calcNota = @nota * 0.35
		END
		ELSE
		IF (@tipo = 3)
		BEGIN
			SET @calcNota = @nota * 0.333
		END
		ELSE
		IF(@tipo = 4)
		BEGIN
			SET @calcNota = @nota * 0.2
		END
	END

------------------------------------- TRABALHO
	IF(@avaliacao = 6)
	BEGIN
		IF(@tipo = 1)
		BEGIN
			SET @calcNota = @nota * 0.2
		END
		ELSE 
		IF (@tipo = 2)
		BEGIN 
			SET @calcNota = @nota * 0.3
		END
	END

------------------------------------- EXAME = P3 (Todos, menos LBD), P4 (apenas LBD)
--ESSA PARTE AINDA NÃO FOI FEITA

	RETURN(@calcNota)
END


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


