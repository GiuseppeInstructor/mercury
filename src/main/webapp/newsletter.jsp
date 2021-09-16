<%@ page language="java" import="java.sql.*, com.corso.mercury.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/mercury/admin/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>News Letter</title>
</head>
<body>
<a href="/mercury/index.jsp" ><img style="width:100; height:50px;" class=img src="https://cdn.freelogovectors.net/wp-content/uploads/2016/11/mercury-logo.jpg" alt="Foto Evento"></a>
<h2>REGISTRATI ALLA NEWS LETTER</h2>
	<hr>

	<p>Inserisci le tue credenziali e le tue preferenze sui prossimi eventi</p>
	<br>

	<form action="/mercury/news" method="post">

		<table>
		<tr><td>E-mail</td><td><input type="text" name="email"></td></tr>
		</table>
		<br>
		<p>Seleziona una categoria:</p> 
		<input type="radio" name="Categoria" value="0">Tutti
        <input type="radio" name="Categoria" value="1">Musica
        <input type="radio" name="Categoria" value="2">Cinema
		<input type="radio" name="Categoria" value="3">Teatro 
		<input type="radio" name="Categoria" value="4">Sagra 
		<br>
		<br>
		
<p>Seleziona la zona:</p>
		<input type="radio" name="Zona" value="1">Comune
        <input type="radio" name="Zona" value="2">Provincia
		<input type="radio" name="Zona" value="3">Regione
		<input type="text" name="Zona2" >Nome Regione/Provincia/Comune
		<br>
		<br>
		
<p>Seleziona la frequenza con cui desideri ricevere aggiornamenti sugli eventi disponibili</p>
		<input type="radio" name="Frequenza" value="1">Giornaliera
        <input type="radio" name="Frequenza" value="2">Settimanale
		<input type="radio" name="Frequenza" value="3">Mensile 
		<br>
		<br>
		<hr>
		
		<input type="submit" value="REGISTRATI"> <br>
	</form>
	<br>
 ${operazione}
</body>
</html>