<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>Registrazione nuovo Ente</title>
</head>
<body>
<a href="/mercury/index.jsp" ><img style="width:100; height:50px;" class=img src="https://cdn.freelogovectors.net/wp-content/uploads/2016/11/mercury-logo.jpg" alt="Foto Evento"></a>
<form action="/mercury/Registrazione" method="post">
<br>
<br>
<p class=button style="font-size: 18pt;">Registrazione nuovo Ente</p><br>
<table>
<tr><td>Nome Ente </td> <td><input type="text" name="Rnome"></td></tr>
<tr><td>Logo </td> <td><input type="text" name="Rlogo"></td></tr>
<tr><td>Nome Referente </td> <td><input type="text" name="Rref"></td></tr>
<tr><td>Numero di Telefono </td> <td><input type="text" name="Rcell"></td></tr>
<tr><td>Numero Iscrizione Camera Commercio </td> <td><input type="text" name="RICC"></td></tr>
<tr><td>Email </td> <td><input type="text" name="Remail"></td></tr>
<tr><td>Password </td> <td><input type="password" name="Rpass"></td></tr>
<tr><td>Comune di appartenenza </td> <td>
                <select name="Rcomune">
                <option value="null">--Lista Comuni--</option>
                <%
                ResultSet controllocomuni=AdminServer.query().executeQuery("SELECT nome FROM comune"); 
                while(controllocomuni.next()){
                %>
                <option value="<%=controllocomuni.getString("nome") %>"><%=controllocomuni.getString("nome") %></option>
                <%} %>
                </select><br/></td></tr>

</table>
<input class=button type="submit" name="accedi" value="Registrati">
</form>

<p class=titolo>${risultato}</p>
</body>
</html>