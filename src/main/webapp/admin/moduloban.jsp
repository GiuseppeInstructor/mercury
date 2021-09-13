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
<p class=titolo>Modulo di Sospensione per ${EnteDaBloccare}</p>
<form action="/mercury/AdminServer" method="post">
<input type="text" name="motivo" style="width:300px; height:60px;"><br>
<a href="/mercury/admin/enti.jsp">Annulla</a>
<input class=button type="submit" name="${EnteDaBloccare}" value="Sospendi"><br>
</form>
</body>
</html>