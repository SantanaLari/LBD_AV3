<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Avaliação</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	
	<div align="center">
		<H1>
			<b> Visualizar notas </b>
		</H1>
		<form action="avaliacao" method="post">
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
		<c:if test="${not empty listaNota }">
			<table class="table_round">
				<thead>
					<tr>
						<th> RA </th>
						<th> Nome </th>
						<th> Nota1 </th>
						<th> Nota2 </th>
						<th> Nota3 </th>
						<th> Nota4 </th>
						<th> Exame </th>
						<th> Media </th>
						<th> Situação </th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${listaNota }" var="dp">
					<tr>
						<td><c:out value="${dp.ra_aluno.ra }" /></td>
						<td><c:out value="${dp.nome_aluno.nome }" /></td>
						<td><c:out value="${dp.nota1 }" /></td>
						<td><c:out value="${dp.nota2 }" /></td>
						<td><c:out value="${dp.nota3 }" /></td>
						<td><c:out value="${dp.nota4 }" /></td>
						<td><c:out value="${dp.exame }" /></td>
						<td><c:out value="${dp.media_final }" /></td>
						<td><c:out value="${dp.situacao }" /></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	
	
</body>
</html>