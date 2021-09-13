<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>Admin Page</title>
</head>
<body>
<p class=titolo>Mercury Admin Page</p>
<br>
<br>
<table border='3'> 
  <tr>
    <td><a href="/mercury/index.jsp">Torna Alla Home</a></td>
    <td><a href="/mercury/admin/eventi.jsp">Elenco Eventi</a> </td>
    <td><a href="/mercury/admin/enti.jsp">Elenco Enti</a></td>
  </tr>
</table>
  <br>
  <br>
<form action="/mercury/admin/enti.jsp" method="post">
<table border='3'>
  <tr>
    <td><input type="submit" name="nome" value="Blocca"></td>
    <td><input type="submit" name="nome" value="Riammetti"></td>
  </tr>
</table>
</form>
 <%
 String modalita = (String)request.getAttribute("modalita");
 String blocca="SELECT P.logo,P.nome,P.nome_referente,P.iscrizione_cc,P.mail,C.nome FROM ente P INNER JOIN comune C ON p.comune_pk=C.pk WHERE eliminato=0";
 String riammetti="SELECT P.motivazione,P.logo,P.nome,P.nome_referente,P.iscrizione_cc,P.mail,C.nome FROM ente P INNER JOIN comune C ON p.comune_pk=C.pk WHERE eliminato=1";
 if(modalita==null){
	 modalita=request.getParameter("nome");
 }
 %>
 <%

 if(modalita==null||modalita.equals("Blocca")){ 
 %>
<form action="/mercury/AdminServer" method="post">
<table border='3'>
 <tr><td>Immagine</td><td>Nome Ente</td><td>Nome Referente</td><td>Iscrizione CC</td><td>E-mail</td><td>Comune</td><td>Blocca</td></tr>
	
	<%
	 
	 ResultSet rst=AdminServer.query().executeQuery(blocca);
	 while(rst.next()){ 
	 %>
	
  	<tr>
  	<td style="width:120px; height:100px;"><img class=img src=<%= rst.getString("P.logo")%> alt="Foto Ente"></td>
    <td><%= rst.getString("P.nome")%></td>
    <td><%= rst.getString("P.nome_referente")%></td>
    <td><%= rst.getString("P.iscrizione_cc")%></td>
    <td><%= rst.getString("P.mail")%></td>
    <td><%= rst.getString("C.nome")%></td>
    <td><input type="submit" name="<%= rst.getString("nome")%>" value="Blocca"></td>
  	</tr>
  	
  	<%
  	}
	 %>
</table>
</form>
    <%
    }
 else{
    %>
    <form action="/mercury/AdminServer" method="post">
<table border='3'>
 <tr><td>Immagine</td><td>Nome Ente</td><td>Nome Referente</td><td>Iscrizione CC</td><td>E-mail</td><td>Comune</td><td>Motivo</td><td>Riammetti</td></tr>
	
	<%
	 ResultSet rst=AdminServer.query().executeQuery(riammetti);
	 while(rst.next()){ 
	 %>
	
  	<tr>
  	<td style="width:120px; height:100px;"><img class=img src=<%= rst.getString("P.logo")%> alt="Foto Ente"></td>
    <td><%= rst.getString("P.nome")%></td>
    <td><%= rst.getString("P.nome_referente")%></td>
    <td><%= rst.getString("P.iscrizione_cc")%></td>
    <td><%= rst.getString("P.mail")%></td>
    <td><%= rst.getString("C.nome")%></td>
    <td><%= rst.getString("P.motivazione")%></td>
    <td><input type="submit" name="<%= rst.getString("nome")%>" value="Riammetti"></td>
  	</tr>
  	
  	<%
  	}
	 %>
</table>
</form>
    <%
    }
    %>
</body>
</html>