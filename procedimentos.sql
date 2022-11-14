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

---------------------------------------------------- FUNCTION NOTAS [Completo POREM SEM MUITO TESTE] ----------------------------------------------
CREATE FUNCTION fn_notas2(@codDisciplina VARCHAR(10))
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
			@P3 INT,
			@tipo INT,
			@faltas VARCHAR(15)
	SET @media = 0
	SET @P3 = 0


	DECLARE c CURSOR FOR
		SELECT DISTINCT ra_aluno FROM notas WHERE codigo_disciplina = @codDisciplina
	OPEN c
	FETCH NEXT FROM c INTO @ra
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @nome = (SELECT nome from aluno WHERE ra = @ra)
		INSERT INTO @tabela VALUES(@ra, @nome, 0, 0, 0, 0, NULL, 0, NULL)
		
    ---------------------------------- VERIFICA SE NÃO REPROVOU POR FALTA
		SET @faltas = (SELECT dbo.verificaFalta(@ra, @codDisciplina))
	--------------------------------------------------------------------------------------
		DECLARE c1 CURSOR FOR
			SELECT codigo_avaliacao, nota FROM notas WHERE codigo_disciplina = @codDisciplina AND ra_aluno = @ra
		OPEN c1
		FETCH NEXT FROM c1 INTO @avaliacao, @nota
		WHILE @@FETCH_STATUS = 0
		BEGIN
	--Separa materias que tem o mesmo peso nas avaliações por tipos
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
	----------------------------------------------------------FIM 
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
		-------------------------------------------EXAME
		IF((@avaliacao = 3) AND (@tipo != 3) OR (@avaliacao = 4))
		BEGIN
			IF(@tipo = 1) or (@tipo = 3)
			BEGIN
				UPDATE @tabela
				SET exame = @nota, media_final = ((media_final + @nota)/4) + media_final
				WHERE ra_aluno = @ra
			END
			ELSE
			IF(@tipo = 2)
			BEGIN
				UPDATE @tabela 
				SET exame = @nota, media_final = ((media_final + @nota)/5) + media_final
				WHERE ra_aluno = @ra
			END
			ELSE
			IF(@tipo = 4)
			BEGIN
				UPDATE @tabela
				SET exame = @nota, media_final = ((media_final + @nota)/3) + media_final
				WHERE ra_aluno = @ra
			END
		END
		-------------------------------------------EXCEÇÕES
		--P3 DE LBD
		IF ((@avaliacao = 3) AND (@tipo = 3))
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
	------------------------------------------------SITUAÇÃO
		SET @P3 = (SELECT COUNT(exame) FROM @tabela WHERE ra_aluno = @ra)

		SET @media = (SELECT media_final FROM @tabela WHERE ra_aluno = @ra)

		IF(@media >= 6)
		BEGIN
			IF(@faltas = 'Reprovado')
			BEGIN
				UPDATE @tabela
				SET situacao = 'Reprovado por falta'
				WHERE ra_aluno = @ra
			END
			ELSE
			BEGIN
				UPDATE @tabela
				SET situacao = 'Aprovado'
				WHERE ra_aluno = @ra
			END
		END
		ELSE
		IF (@media < 6)
		BEGIN
			IF(@faltas = 'Aprovado')
			BEGIN
				IF((@media > 3) AND (@P3 = 0))
				BEGIN
					UPDATE @tabela
					SET situacao = 'Exame'
					WHERE ra_aluno = @ra
				END
				ELSE
				IF((@media < 3) OR (@P3 = 1))
				BEGIN
					UPDATE @tabela
					SET situacao = 'Reprovado por nota'
					WHERE ra_aluno = @ra
				END
			END
			IF(@faltas = 'Reprovado')
			BEGIN
				IF((@media > 3) AND (@P3 = 0))
				BEGIN
					UPDATE @tabela
					SET situacao = 'Reprovado por falta'
					WHERE ra_aluno = @ra
				END
				ELSE
				IF((@media < 3) OR (@P3 = 1))
				BEGIN
					UPDATE @tabela
					SET situacao = 'Reprovado por nota e falta'
					WHERE ra_aluno = @ra
				END
			END
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
	RETURN(@calcNota)
END

---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- FUNCTION FALTAS
---------------------------------------------------------- FUNCTION QUE CONVERTE FALTA EM LETRA
CREATE FUNCTION fn_conversorFalta(@presenca INT, @tipo INT)
RETURNS VARCHAR(4)
AS
BEGIN
	DECLARE @faltas VARCHAR(4)
	IF(@presenca = 0)
	BEGIN
		IF (@tipo = 80)
		BEGIN
			SET @faltas = 'PPPP'
		END
		ELSE
		BEGIN
			SET @faltas = 'PP'
		END
	END
	IF(@presenca = 1)
	BEGIN
		IF (@tipo = 80)
		BEGIN
			SET @faltas = 'PPPF'
		END
		ELSE
		BEGIN
			SET @faltas = 'PF'
		END
	END
	IF(@presenca = 2)
	BEGIN
		IF (@tipo = 80)
		BEGIN
			SET @faltas = 'PPFF'
		END
		ELSE
		BEGIN
			SET @faltas = 'FF'
		END
	END
	IF(@presenca = 3)
	BEGIN
		SET @faltas = 'PFFF'
	END
	IF(@presenca = 4)
	BEGIN
		SET @faltas = 'FFFF'
	END
	RETURN(@faltas)
END
------------------------------------------------------------------------ FUNCTION DE FALTAS

ALTER FUNCTION fn_faltas(@codDisciplina VARCHAR(10))
RETURNS @tabela TABLE(
ra_aluno INT,
nome_aluno VARCHAR(20),
semana1 VARCHAR(4),
semana2 VARCHAR(4),
semana3 VARCHAR(4),
semana4 VARCHAR(4),
semana5 VARCHAR(4),
semana6 VARCHAR(4),
semana7 VARCHAR(4),
semana8 VARCHAR(4),
semana9 VARCHAR(4),
semana10 VARCHAR(4),
semana11 VARCHAR(4),
semana12 VARCHAR(4),
semana13 VARCHAR(4),
semana14 VARCHAR(4),
semana15 VARCHAR(4),
semana16 VARCHAR(4),
semana17 VARCHAR(4),
semana18 VARCHAR(4),
semana19 VARCHAR(4),
semana20 VARCHAR(4),
total_faltas INT
)
AS
BEGIN
	DECLARE @nome VARCHAR(20),
			@ra INT,
			@datas DATE,
			@presenca INT,
			@tipo INT,
			@cont INT

	SET @tipo = (SELECT num_aulas FROM disciplina WHERE codigo = @codDisciplina)
	SET @cont = 0
	DECLARE c CURSOR FOR
		SELECT DISTINCT ra_aluno FROM faltas WHERE codigo_disciplina = @codDisciplina
	OPEN c
	FETCH NEXT FROM c INTO @ra
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @nome = (SELECT nome FROM aluno WHERE ra = @ra)
		INSERT INTO @tabela VALUES (@ra, @nome, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    ------------------------------------------------------------------------------------
		DECLARE c1 CURSOR FOR
			SELECT datas, presenca FROM faltas WHERE codigo_disciplina = @codDisciplina AND ra_aluno = @ra ORDER BY datas
		OPEN c1
		FETCH NEXT FROM c1 INTO @datas, @presenca
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @cont = @cont + 1

			IF (@cont = 1)
			BEGIN
				UPDATE @tabela
				SET semana1 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 2)
			BEGIN
				UPDATE @tabela
				SET semana2 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 3)
			BEGIN
				UPDATE @tabela
				SET semana3 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 4)
			BEGIN
				UPDATE @tabela
				SET semana4 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 5)
			BEGIN
				UPDATE @tabela
				SET semana5 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 6)
			BEGIN
				UPDATE @tabela
				SET semana6 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 7)
			BEGIN
				UPDATE @tabela
				SET semana7 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 8)
			BEGIN
				UPDATE @tabela
				SET semana8 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 9)
			BEGIN
				UPDATE @tabela
				SET semana9 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 10)
			BEGIN
				UPDATE @tabela
				SET semana10 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 11)
			BEGIN
				UPDATE @tabela
				SET semana11 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 12)
			BEGIN
				UPDATE @tabela
				SET semana12 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 13)
			BEGIN
				UPDATE @tabela
				SET semana13 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 14)
			BEGIN
				UPDATE @tabela
				SET semana14 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 15)
			BEGIN
				UPDATE @tabela
				SET semana15 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 16)
			BEGIN
				UPDATE @tabela
				SET semana16 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 17)
			BEGIN
				UPDATE @tabela
				SET semana17 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 18)
			BEGIN
				UPDATE @tabela
				SET semana18 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 19)
			BEGIN
				UPDATE @tabela
				SET semana19 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END
			ELSE
			IF (@cont = 20)
			BEGIN
				UPDATE @tabela
				SET semana20 = dbo.fn_conversorFalta(@presenca, @tipo), total_faltas = @presenca + total_faltas
				WHERE ra_aluno = @ra
			END

		FETCH NEXT FROM c1 INTO @datas, @presenca
		END
		CLOSE c1
		DEALLOCATE c1
		SET @cont = 0
	------------------------------------------------------------------------------------
	FETCH NEXT FROM c INTO @ra
	END
	CLOSE c
	DEALLOCATE c
	RETURN
END


/*
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
*/

