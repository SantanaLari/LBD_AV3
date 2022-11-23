<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<H1>
			<b> Relatório - Notas </b>
		</H1>
		<form action="index" method="post" target="_blank">
			<table>
				<tr>
					<td colspan="3">
						<input class="input_id" type="text" id="disciplina" name="disciplina" placeholder="disciplina">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Exibir">
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
	
</body>
</html>