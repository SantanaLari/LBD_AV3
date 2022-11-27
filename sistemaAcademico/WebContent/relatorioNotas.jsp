<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Relatorio - Notas</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	
	<div align="center">
		<H1>
			<b> Relatório - Notas </b>
		</H1>
		<form action="relatorioNotas" method="post">
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