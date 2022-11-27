<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	
	<div align="center">
		<H1>
			<b> INSERIR NOTA </b>
		</H1>
		<form action="notas" method="post">
			<table>
				<tr>
					<td colspan="1">
						<select name="ra" id="ra">
							<option value="0"> Aluno </option>
							<option value="11101"> Freddy Krueger </option>
							<option value="11102"> Jason Voorhees </option>
							<option value="11103"> Michael Myers </option>
							<option value="11104"> Pennywise </option>
							<option value="11105"> Chucky </option>
							<option value="11106"> Jigsaw </option>
							<option value="11107"> Annabelle </option>
							<option value="11108"> Samara </option>
							<option value="11109"> Carrie </option>
							<option value="11110"> Sadako </option>
							<option value="11111"> Regan McNeil </option>
						</select>
					</td>
					<td colspan="1">
						<select name="disciplina" id="disciplina">
							<option value="0"> Disciplina </option>
							<option value="4203-010"> AOC (T) </option>
							<option value="4203-020"> AOC (N) </option>
							<option value="4208-010"> LH (T) </option>
							<option value="4213-003"> SOI (T) </option>
							<option value="4213-013"> SOI(N) </option>
							<option value="4226-004"> BD (N) </option>
							<option value="4233-005"> LBD (T) </option>
							<option value="5005-220"> MPC (M) </option>					
						</select>		
					</td>
				</tr>
				</tr>
					<td colspan="1">
						<select name="avaliacao" id="avaliacao">
							<option value="0"> Avaliacao </option>
							<option value="1"> P1 </option>
							<option value="2"> P2 </option>
							<option value="3"> P3 </option>
							<option value="4"> P4 </option>
							<option value="5"> Pre P3 </option>
							<option value="6"> Trabalho </option>
						</select>
					</td>
					<td colspan="1">
						<input class="input_id" type="number" id="nota" name="nota" placeholder="nota">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" id="botao" name="botao" value="Inserir">
					</td>
				</tr>
			</table>
		</form>
		
	</div>
	
	<div align="center">
		<c:if test="${not empty erro }">
			<H2>
				<c:out value="${erro }" />
			</H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida }">
			<H3>
				<c:out value="${saida }" />
			</H3>
		</c:if>
	</div>
	
</body>
</html>