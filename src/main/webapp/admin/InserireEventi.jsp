<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>Modulo inserimento eventi</title>
</head>
<body>
<%

String pk = null;
String accesso = (String)request.getAttribute("risultato"); 
if (accesso == null){
	accesso=request.getParameter("risultato");
	if (accesso == null){
		response.sendRedirect("/mercury/admin/login.jsp");
	}
}
else{
ResultSet getentepk=AdminServer.query().executeQuery("SELECT pk FROM ente WHERE nome="+"'"+accesso+"';"); 
getentepk.next();
pk=getentepk.getString("pk");
}

%>
<form action="/mercury/IEventi" method="post">
<br>
<br>
<p class=button style="font-size: 18pt;">Modulo inserimento eventi</p><br>
<p class=titolo>Benvenuto <%=accesso%></p>
<input type="hidden" name=pk value="<%=pk%>">
<input type="hidden" name=risultato value="<%=accesso%>">
<table>
<tr><td>Immagine </td> <td><input type="text" name="Img"></td></tr>
<tr><td>Nome Evento </td> <td><input type="text" name="Nevento"></td></tr>
<tr><td>Descrizione Evento <p style="font-size: 10pt;">(massimo 250 caratteri)</p> </td> <td> <textarea rows = "5" cols = "50" maxlength="200" name = "Devento"></textarea><br></td></tr>
<tr><td>Data</td> <td><input type="date" name="data"></td></tr>

<tr><td>Citta </td> <td>
                <select name="Ecomune">
                <option value="null">--Lista Comuni--</option>
                <%
                ResultSet controllocomuni=AdminServer.query().executeQuery("SELECT pk,nome FROM comune"); 
                while(controllocomuni.next()){
                %>
                <option value="<%=controllocomuni.getString("pk") %>"><%=controllocomuni.getString("nome") %></option>
                <%} %>
                
                </select><br/></td></tr>
<tr><td>Tipo Evento </td> <td>
                <select name="Tevento">
                <option value="null">--Lista Eventi--</option>
                <%
                ResultSet controllotipo=AdminServer.query().executeQuery("SELECT pk,tipologia FROM tipoevento"); 
                while(controllotipo.next()){
                %>
                <option value="<%=controllotipo.getString("pk") %>"><%=controllotipo.getString("tipologia") %></option>
                <%} %>
                
                </select><br/></td></tr>

</table>
<input class=button type="submit" name=Evento value="Inserisci Evento">
</form>

<p class=titolo>${operazione}</p>
</body>
</html>