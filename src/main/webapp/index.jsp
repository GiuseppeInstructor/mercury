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
            	 	ResultSet rst2= null;
                	try {
        				rst2=AdminServer.query().executeQuery("SELECT * FROM regione");
        				rst2.next();
        				} 
                	catch (SQLException e) {
        				e.printStackTrace();
        				}
                	
               	 %>
<img src="D:\Esercizi\mercury\mercury.png" width="100" height="50">

          <form id="ricerca">
                <span>Regione :</span>
                <select name="regione">
                <option value="0">--REGIONE--</option>
                <option value="1">Puglia </option>
            	<option value="2">--PROVINCE--</option>
           		<option value="3">BT</option>
                <option value="4">BA</option>
                <option value="5">FG</option>
                <option value="6">--Citta--</option>
                <option value="7">Bisceglie</option>
                <option value="8">Molfetta</option>
                <option value="9">Andria</option>
                <option value="10">Trani</option>
                <option value="11">Foggia</option>
                <option value="12">Bari</option>
                </select><br/>
                <span>Provincia :</span>
                <select name="provincia">
                    <option value=""></option>
                </select><br/>
                <span>Comune :</span>
                <select name="comune">
                    <option value=""></option>
                </select>
            </form>
</body>
</html>