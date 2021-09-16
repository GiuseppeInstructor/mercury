<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>Blocca Enti</title>
</head>
<body>
<a href="/mercury/index.jsp" ><img style="width:100; height:50px;" class=img src="https://cdn.freelogovectors.net/wp-content/uploads/2016/11/mercury-logo.jpg" alt="Foto Evento"></a>
<% 
String accesso = (String)request.getAttribute("risultato"); 
if (accesso == null)
{
	accesso=request.getParameter("risultato");
	if (accesso == null){
		response.sendRedirect("/mercury/admin/login.jsp");
	}
}
%>
<p class=titolo>Modulo di Sospensione per ${EnteDaBloccare}</p>
<form action="/mercury/AdminServer" method="post">
<input type="hidden" name="risultato" value="<%=accesso%>">
<p style="font-size: 15pt;">Inserire il motivo del blocco</p>
<input type="text" name="motivo" style="width:300px; height:60px;"><br>
<a href="/mercury/admin/enti.jsp">Annulla</a>
<input class=button type="submit" name="${EnteDaBloccare}" value="Sospendi"><br>
</form>
</body>
</html>