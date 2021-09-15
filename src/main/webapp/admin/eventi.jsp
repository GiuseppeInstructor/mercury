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
	else if(request.getParameter("pagina").equals("Elenco Enti"))
	{
		getServletContext().getRequestDispatcher("/admin/enti.jsp").forward(request,response);
		
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
<form action="/mercury/admin/eventi.jsp" method="post">
<input type="submit" name="Esci" value="Esci">
<input type="hidden" name="risultato" value=<%=accesso%>>
<table border='3'>
  <tr>
  <td><input type="submit" name="pagina" value="Torna Alla Home"></td>
    <td><input type="submit" name="pagina" value="Elenco Enti"></td>
  </tr>
</table>
  <br>
<table border='3'>
  <tr>
    <td><input type="submit" name="nome" value="Elimina"></td>
    <td><input type="submit" name="nome" value="Ripristina"></td>
  </tr>
</table>
</form>
 <%
 String modalita = (String)request.getAttribute("modalita");
 String elimina="SELECT  E.data,E.immagini,E.nome,T.tipologia,P.nome,C.nome FROM eventi E INNER JOIN comune C ON E.comunek=C.pk INNER JOIN tipoevento T ON E.tipoevento_pk=T.pk INNER JOIN ente P ON E.ente_pk=P.pk WHERE E.eliminazione=0 AND P.eliminato=0 ORDER BY data ASC";
 String ripristina="SELECT E.data,E.immagini,E.nome,T.tipologia,P.nome,C.nome FROM eventi E INNER JOIN comune C ON E.comunek=C.pk INNER JOIN tipoevento T ON E.tipoevento_pk=T.pk INNER JOIN ente P ON E.ente_pk=P.pk WHERE E.eliminazione=1 AND P.eliminato=0 ORDER BY data ASC";
 if(modalita==null){
	 modalita=request.getParameter("nome");
 }
 %>
 <%

 if(modalita==null||modalita.equals("Elimina")){ 
 %>
<form action="/mercury/AdminServer" method="post">
<input type="hidden" name="risultato" value=<%=accesso%>>
<table border='3'>
 <tr><td>Immagine</td><td>Nome Evento</td><td>Tipo Evento</td><td>Ente</td><td>Comune</td><td>Data</td><td>Elimina</td></tr>
	
	<%
	 
	 ResultSet rst=AdminServer.query().executeQuery(elimina);
	 while(rst.next()){ 
	 %>
	
  	<tr>
  	<td style="width:120px; height:100px;"><img class=img src=<%= rst.getString("E.immagini")%> alt="Foto Evento"></td>
    <td><%= rst.getString("E.nome")%></td>
    <td><%= rst.getString("T.tipologia")%></td>
    <td><%= rst.getString("P.nome")%></td>
    <td><%= rst.getString("C.nome")%></td>
    <td><%= rst.getString("E.data")%></td>
    <td><input type="submit" name="<%= rst.getString("nome")%>" value="Elimina"></td>
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
    <input type="hidden" name="risultato" value=<%=accesso%>>
<table border='3'>
 <tr><td>Immagine</td><td>Nome Evento</td><td>Tipo Evento</td><td>Ente</td><td>Comune</td><td>Data</td><td>Ripristina</td></tr>
	
	<%
	 ResultSet rst=AdminServer.query().executeQuery(ripristina);
	 while(rst.next()){ 
	 %>
	
  	<tr>
  	<td style="width:120px; height:100px;"><img class=img src=<%= rst.getString("E.immagini")%> alt="Foto Evento"></td>
    <td><%= rst.getString("E.nome")%></td>
    <td><%= rst.getString("T.tipologia")%></td>
    <td><%= rst.getString("P.nome")%></td>
    <td><%= rst.getString("C.nome")%></td>
    <td><%= rst.getString("E.data")%></td>
    <td><input type="submit" name="<%= rst.getString("nome")%>" value="Ripristina"></td>
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