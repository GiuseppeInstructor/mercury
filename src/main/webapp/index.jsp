<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MERCURY HOME PAGE</title>
</head>
<body>
            	 <%
            	 	ResultSet regioni= null;
            	 	ResultSet province= null;
            	 	ResultSet comuni= null;
                	try {
        				regioni=AdminServer.query().executeQuery("SELECT * FROM regione");
        				} 
                	catch (SQLException e) {
        				e.printStackTrace();
        				}
                	
               	 %>
<img src="D:\Esercizi\mercury\mercury.png" width="100" height="50">

          <form id="ricerca" action="Ricerca" method="post">
          
                <span>Regione :</span>
                <select name="regione">
                <option value="">--TUTTE LE REGIONI--</option>
                <%while(regioni.next())
                	{
                %>
                <option value="<%=regioni.getString("nome")%>"><%=regioni.getString("nome")%></option>
                <%  } %>
                </select>
                               
                <%
                	if(request.getAttribute("region")!=null)
                	{
          
                %>
                <%
                	try {
        				province=AdminServer.query().executeQuery("SELECT * FROM provincia P INNER JOIN regione R WHERE P.regione_pk=R.pk AND R.nome='"+request.getAttribute("region")+"'");
        				} 
                	catch (SQLException e) {
        				e.printStackTrace();
        				}
                	
               	 %>
                <span>Provincia :</span>

                <select name="provincia">
                <option value="">--TUTTE LE PROVINCE--</option>
                <%while(province.next())
                {%>
                    <option value="<%=province.getString("nome")%>"><%=province.getString("nome")%></option>
                <%} %>
                </select>
                                
                <%
                	if(request.getAttribute("prov")!=null)
                	{
          
                %>
                <%
                	try {
        				comuni=AdminServer.query().executeQuery("SELECT * FROM comune C INNER JOIN provincia P WHERE C.provincia_pk=P.pk AND P.nome='"+request.getAttribute("prov")+"'");
        				} 
                	catch (SQLException e) {
        				e.printStackTrace();
        				}
                	
               	 %>
                <span>Comune :</span>
                <select name="comune">
                <option value="">--TUTTE LE COMUNE--</option>
                <%while(comuni.next())
                		{%>
                    <option value="<%=comuni.getString("nome")%>"><%=comuni.getString("nome") %></option>
                    <%} %>
                </select>
                <%}//if provincia %>
                <%}//if comune %>
                <input type="submit" name="1" value="RICERCA">
            </form>
</body>
</html>