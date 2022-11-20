<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
						<input class="input_id" type="text" id="disciplina" name="disciplina" placeholder="disciplina">
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
						<th> Semana 1 </th>
						<th> Semana 2 </th>
						<th> Semana 3 </th>
						<th> Semana 4 </th>
						<th> Semana 5 </th>
						<th> Semana 6 </th>
						<th> Semana 7 </th>
						<th> Semana 8 </th>
						<th> Semana 9 </th>
						<th> Semana 10 </th>
						<th> Semana 11 </th>
						<th> Semana 12 </th>
						<th> Semana 13 </th>
						<th> Semana 14 </th>
						<th> Semana 15 </th>
						<th> Semana 16 </th>
						<th> Semana 17 </th>
						<th> Semana 18 </th>
						<th> Semana 19 </th>
						<th> Semana 20 </th>
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