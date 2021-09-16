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
<%

String accesso = (String)request.getAttribute("risultato"); 
if (accesso == null)
{
	accesso=request.getParameter("risultato");
	if (accesso == null){
		response.sendRedirect("/mercury/admin/login.jsp");
	}
}
if(request.getParameter("pagina")!=null){
	if(request.getParameter("pagina").equals("Torna Alla Home"))
	{
		response.sendRedirect("/mercury/index.jsp");
	}
	else if(request.getParameter("pagina").equals("Elenco Eventi"))
	{
		getServletContext().getRequestDispatcher("/admin/eventi.jsp").forward(request,response);
		
	}
}
if(request.getParameter("Esci")!=null)
{
	response.sendRedirect("/mercury/admin/login.jsp");
}
%>
<p class=titolo>Mercury Admin Page</p>
<p class=titolo>Benvenuto <%=accesso %></p>
<br>
<br>
<form action="/mercury/admin/enti.jsp" method="post">
<input type="hidden" name="risultato" value="<%=accesso%>">
<table border='3'>
  <tr>
  <td><a href="/mercury/index.jsp" ><img style="width:100; height:50px;" class=img src="https://cdn.freelogovectors.net/wp-content/uploads/2016/11/mercury-logo.jpg" alt="Foto Evento"></a></td>
    <td><input type="submit" name="Esci" value="Esci"></td>
    <td><input type="submit" name="pagina" value="Elenco Eventi"></td>
  </tr>
</table>
  <br>
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
<input type="hidden" name="risultato" value="<%=accesso%>">
<table border='3'>
 <tr><td>Immagine</td><td>Nome Ente</td><td>Nome Referente</td><td>Iscrizione CC</td><td>E-mail</td><td>Comune</td><td>Blocca</td></tr>
	
	<%
	 
	 ResultSet rst=AdminServer.query().executeQuery(blocca);
	 while(rst.next()){ 
	 %>
	
  	<tr>
  	<td style="width:120px; height:100px;"><img class=img src="<%= rst.getString("P.logo")%>" alt="Foto Ente"></td>
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
    <input type="hidden" name="risultato" value="<%=accesso%>">
<table border='3'>
 <tr><td>Immagine</td><td>Nome Ente</td><td>Nome Referente</td><td>Iscrizione CC</td><td>E-mail</td><td>Comune</td><td>Motivo</td><td>Riammetti</td></tr>
	
	<%
	 ResultSet rst=AdminServer.query().executeQuery(riammetti);
	 while(rst.next()){ 
	 %>
	
  	<tr>
  	<td style="width:120px; height:100px;"><img class=img src="<%= rst.getString("P.logo")%>" alt="Foto Ente"></td>
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