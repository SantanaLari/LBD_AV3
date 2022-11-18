<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<b> GERAR PERCENTUAL DE PRESENÇA </b>
		</H1>
		<form action="presenca" method="post">
			<table>
				<tr>
					<td colspan="3"><input class="input_data" type="text"
						id="disciplina" name="disciplina" placeholder="Disciplina"></td>
				</tr>
				<tr>
					<td><input type="submit" id="botao" name="botao" value="Gerar"></td>
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