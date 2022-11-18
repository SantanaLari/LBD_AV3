<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Notas</title>
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
					<td colspan="3"><input class="input_data_id" type="number"
						id="ra" name="ra" placeholder="RA"></td>
					<td colspan="3"><input class="input_data" type="text"
						id="disciplina" name="disciplina" placeholder="Disciplina"></td>
				</tr>
				<tr>
					<td colspan="3"><input class="input_data" type="text"
						id="avaliacao" name="avaliacao" placeholder="Avaliação"></td>
					<td colspan="3"><input class="input_data_id" type="number" min="0" step="0.10"
						id="nota" name="nota" placeholder="Nota"></td>
				</tr>
				<tr>
					<td><input type="submit" id="botao" name="botao"
						value="Inserir"></td>
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