<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Presença</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	
	<div align="center">
		<H1>
			<b> Visualizar Faltas </b>
		</H1>
		<form action="presenca" method="post">
			<table>
				<tr>
					<td colspan="3">
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
					<td>
						<input type="submit" id="botao" name="botao" value="Buscar">
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
	
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty listaFalta }">
			<table class="table_round">
				<thead>
					<tr>
						<th> RA </th>
						<th> Nome </th>
						<th> 10/08 | </th>
						<th> 17/08 | </th>
						<th> 24/08 | </th>
						<th> 31/08 |</th>
						<th> 07/09 |</th>
						<th> 14/09 |</th>
						<th> 21/09 |</th>
						<th> 28/09 |</th>
						<th> 05/10 |</th>
						<th> 12/10 |</th>
						<th> 19/10 |</th>
						<th> 26/10 |</th>
						<th> 02/11 |</th>
						<th> 09/11 |</th>
						<th> 16/11 |</th>
						<th> 23/11 |</th>
						<th> 30/11 |</th>
						<th> 07/12 |</th>
						<th> 14/12 |</th>
						<th> 21/12 |</th>
						<th> Total </th>
						
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${listaFalta }" var="dp">
					<tr>
						<td><c:out value="${dp.ra_aluno.ra }" /></td>
						<td><c:out value="${dp.nome_aluno.nome }" /></td>
						<td><c:out value="${dp.semana1 }" /></td>
						<td><c:out value="${dp.semana2 }" /></td>
						<td><c:out value="${dp.semana3 }" /></td>
						<td><c:out value="${dp.semana4 }" /></td>
						<td><c:out value="${dp.semana5 }" /></td>
						<td><c:out value="${dp.semana6 }" /></td>
						<td><c:out value="${dp.semana7 }" /></td>
						<td><c:out value="${dp.semana8 }" /></td>
						<td><c:out value="${dp.semana9 }" /></td>
						<td><c:out value="${dp.semana10 }" /></td>
						<td><c:out value="${dp.semana11 }" /></td>
						<td><c:out value="${dp.semana12 }" /></td>
						<td><c:out value="${dp.semana13 }" /></td>
						<td><c:out value="${dp.semana14 }" /></td>
						<td><c:out value="${dp.semana15 }" /></td>
						<td><c:out value="${dp.semana16 }" /></td>
						<td><c:out value="${dp.semana17 }" /></td>
						<td><c:out value="${dp.semana18 }" /></td>
						<td><c:out value="${dp.semana19 }" /></td>
						<td><c:out value="${dp.semana20 }" /></td>
						<td><c:out value="${dp.total_faltas }" /></td>
						
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	
</body>
</html>