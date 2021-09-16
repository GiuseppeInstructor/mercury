<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>
<%
int k=0;
ResultSet rst=AdminServer.query().executeQuery("SELECT pk FROM eventi");

	while(rst.next()){
		 if(request.getParameter(rst.getString("pk")) != null && request.getParameter(rst.getString("pk")).equals("Dettagli")) {
			k=rst.getInt("pk");
			 break;
		 }
	}
				
            	 	ResultSet evento= null;
        			evento=AdminServer.query().executeQuery("SELECT * FROM eventi E INNER JOIN comune C ON E.comune_pk=C.pk INNER JOIN tipoevento T ON E.tipoevento_pk=T.pk INNER JOIN ente K ON E.ente_pk=K.pk INNER JOIN provincia P ON C.provincia_pk=P.pk INNER JOIN regione R ON P.regione_pk=R.pk WHERE E.pk="+k);
        			evento.next();
      %>
     <%=evento.getString("nome")%>   
</title>
</head>
<body>
 <table>
  <tr>
    <th>HOME PAGE</th>
    <th></th>
    <th></th>
  </tr>
  <tr>
    <td><%=evento.getString("E.immagini")%></td>
    <td><%=evento.getString("E.nome")%></td>
    <td><%=evento.getString("K.nome")%></td>
    <td><%=evento.getString("E.data")%></td>
    <td><%=evento.getString("C.nome")%>, <%=evento.getString("P.nome")%>, <%=evento.getString("R.nome")%></td>
  </tr>
  <tr>
    <td></td>
    <td><%=evento.getString("E.descrizione")%></td>

  </tr>
</table> 

</head>

</body>
</html>