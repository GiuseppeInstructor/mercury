<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>LogIn Page</title>
</head>
<body>
<a href="/mercury/index.jsp" ><img style="width:100; height:50px;" class=img src="https://cdn.freelogovectors.net/wp-content/uploads/2016/11/mercury-logo.jpg" alt="Foto Evento"></a>
<form action="/mercury/AdminServer" method="post">
<br>
<br>
<p class=button style="font-size: 18pt;">Login</p><br>
<table>

<tr><td>Email </td> <td><input type="text" name="Lemail"></td></tr>
<tr><td>Password </td> <td><input type="password" name="Lpass"></td></tr>

</table>
<input class=button type="submit" name="accedi" value="Accedi">
</form>

<p class=titolo>${risultato}</p>
</body>
</html>