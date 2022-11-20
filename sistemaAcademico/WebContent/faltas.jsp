<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Faltas</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	
	<div align="center">
		<H1>
			<b> INSERIR FALTAS </b>
		</H1>
		<form action="faltas" method="post">
			<table>
				<tr>
					<td colspan="1">
						<input class="input_id" type="number" id="ra" name="ra" placeholder="Ra">
					</td>
					<td colspan="1">
						<input class="input_id" type="text" id="disciplina" name="disciplina" placeholder="Disciplina">
					</td>
				</tr>
				</tr>
					<td colspan="1">
						<input class="input_id" type="text" id="data" name="data" placeholder="__/__/____">
					</td>
					<td colspan="1">
						<input class="input_id" type="number" id="presenca" name="presenca" placeholder="Presenca">
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