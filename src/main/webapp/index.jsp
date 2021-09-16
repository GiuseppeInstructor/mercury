<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>MERCURY HOME PAGE</title>
</head>
<body>
            	 <%
            	 	String query = "SELECT * FROM eventi E INNER JOIN comune C ON E.comune_pk=C.pk INNER JOIN tipoevento T ON E.tipoevento_pk=T.pk INNER JOIN ente K ON E.ente_pk=K.pk INNER JOIN provincia P ON C.provincia_pk=P.pk INNER JOIN regione R ON P.regione_pk=R.pk WHERE E.eliminazione=0 AND K.eliminato=0 ORDER BY data ASC";
            	 	ResultSet regioni= null;
            	 	ResultSet province= null;
            	 	ResultSet comuni= null;
        			regioni=AdminServer.query().executeQuery("SELECT * FROM regione");
               	 %>
<table>
<tr>
<td><a href="/mercury/index.jsp" ><img style="width:100; height:50px;" class=img src="https://cdn.freelogovectors.net/wp-content/uploads/2016/11/mercury-logo.jpg" alt="Foto Evento"></a></td>

<td><a href="/mercury/admin/login.jsp" style="	margin-left :50px;">Login</a></td>
<td><a href="/mercury/admin/register.jsp" style="	margin-left :50px;">Sei un ente? Registrati e aggiungi i tuoi eventi</a></td>
<td><a href="/mercury/newsletter.jsp" style="	margin-left :50px;">Iscriviti alla NewsLetter</a></td>
</tr>
</table>
          <form id="ricerca" action="Ricerca" method="post">
         <%  
         if(request.getAttribute("provincia_pk")==null && request.getAttribute("regione_pk")==null && request.getAttribute("comune_pk")==null ){
         %>
                <span>Regione :</span>
                <select name="regione">
                <option value="def">--TUTTE LE REGIONI--</option>
                <%
                while(regioni.next())
                	{
                %>
                <option value="<%=regioni.getString("pk")%>"><%=regioni.getString("nome")%></option>
                <% } %>
                </select>
                               
                <%
                }
         else if(request.getAttribute("regione_pk")!=null && request.getAttribute("comune_pk")==null )
                {
        			province=AdminServer.query().executeQuery("SELECT * FROM provincia P INNER JOIN regione R ON P.regione_pk=R.pk WHERE P.regione_pk="+request.getAttribute("regione_pk"));
                	query="SELECT * FROM eventi E INNER JOIN comune C ON E.comune_pk=C.pk INNER JOIN tipoevento T ON E.tipoevento_pk=T.pk INNER JOIN ente K ON E.ente_pk=K.pk INNER JOIN provincia P ON C.provincia_pk=P.pk INNER JOIN regione R ON P.regione_pk=R.pk WHERE E.eliminazione=0 AND K.eliminato=0 AND P.regione_pk="+request.getAttribute("regione_pk")+" ORDER BY data ASC";
                	
               	 %>
                <span>Provincia :</span>
                <select name="provincia">
                <option value="def">--TUTTE LE PROVINCE--</option>
                
                <%while(province.next()){%>
                    <option value="<%=province.getString("pk")%>"><%=province.getString("nome")%></option>
                <%} %>
                
                </select>
                                
                <%
                }
             else if(request.getAttribute("provincia_pk")!=null && request.getAttribute("regione_pk")==null )
                {
        			comuni=AdminServer.query().executeQuery("SELECT * FROM comune C INNER JOIN provincia P ON C.provincia_pk=P.pk WHERE C.provincia_pk="+request.getAttribute("provincia_pk"));
                	query="SELECT * FROM eventi E INNER JOIN comune C ON E.comune_pk=C.pk INNER JOIN tipoevento T ON E.tipoevento_pk=T.pk INNER JOIN ente K ON E.ente_pk=K.pk INNER JOIN provincia P ON C.provincia_pk=P.pk INNER JOIN regione R ON P.regione_pk=R.pk WHERE E.eliminazione=0 AND K.eliminato=0 AND C.provincia_pk="+request.getAttribute("provincia_pk")+" ORDER BY data ASC";
               	 
               	 %>
                <span>Comune :</span>
                <select name="comune">
                <option value="def">--TUTTI I COMUNE--</option>
                
                <%while(comuni.next()){%>
                    <option value="<%=comuni.getString("pk")%>"><%=comuni.getString("nome") %></option>
                <%} %>
                
                </select>
                <%}//if comune %>
                
                <%if(request.getAttribute("regione_pk")==null && request.getAttribute("provincia_pk")==null && request.getAttribute("comune_pk")==null){ %>
                <input type="submit" name="1" value="Cerca per regione">
                <%}
                
                else if(request.getAttribute("regione_pk")!=null){ %>
                <input type="submit" name="2" value="Cerca per provincia">
                <%}
         
                else if(request.getAttribute("provincia_pk")!=null){ %>
                <input type="submit" name="3" value="Cerca per comune">
                <%}
                else{
                query="SELECT * FROM eventi E INNER JOIN comune C ON E.comune_pk=C.pk INNER JOIN tipoevento T ON E.tipoevento_pk=T.pk INNER JOIN ente K ON E.ente_pk=K.pk INNER JOIN provincia P ON C.provincia_pk=P.pk INNER JOIN regione R ON P.regione_pk=R.pk WHERE E.eliminazione=0 AND K.eliminato=0 AND C.pk="+request.getAttribute("comune_pk")+" ORDER BY data ASC";%>
                
                	<input type="submit" name="4" value="Azzera ricerca">
                <%} %>
                
            </form>
            
            <form action="/mercury/dettaglioEvento.jsp" method="post">
            <table border='3'>
 <tr><td>Immagine</td><td>Nome Evento</td><td>Tipo Evento</td><td>Ente</td><td>Comune</td><td>Provincia</td><td>Regione</td><td>Data</td><td>DETTAGLI</td></tr>
	
	<%
	 
	 ResultSet rst=AdminServer.query().executeQuery(query);
	 while(rst.next()){ 
	 %>
	
  	<tr>
  	<td style="width:120px; height:100px;"><img class=img src="<%= rst.getString("E.immagini")%>" alt="Foto Evento"></td>
    <td><%= rst.getString("E.nome")%></td>
    <td><%= rst.getString("T.tipologia")%></td>
    <td><%= rst.getString("K.nome")%></td>
    <td><%= rst.getString("C.nome")%></td>
    <td><%= rst.getString("P.nome")%></td>
    <td><%= rst.getString("R.nome")%></td>
    <td><%= rst.getString("E.data")%></td>
    <td><input type="submit" name="<%= rst.getString("pk")%>" value="Dettagli"></td>
  	</tr>
  	
  	<%
  	}
	 %>
</table>
</form>
</body>
</html>