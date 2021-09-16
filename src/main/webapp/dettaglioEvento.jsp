<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title><!-- %
            	 	ResultSet evento= null;
                	try {
        				evento=AdminServer.query().executeQuery("SELECT * FROM evento WHERE pk='"+request.getAttribute("dettagli")+"'");
        				} 
                	catch (SQLException e) {
        				e.printStackTrace();
        				}
                	
      %>
     <!--   evento.getString("nome")%>       	--> 
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
    <td>immagine evento</td>
    <td>nome evento</td>
    <td>ente</td>
    <td>data</td>
    <td>comune, provincia, regione</td>
  </tr>
  <tr>
    <td></td>
    <td>descrizione</td>

  </tr>
</table> 

</head>

</body>
</html>