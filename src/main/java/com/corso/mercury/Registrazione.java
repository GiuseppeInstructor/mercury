package com.corso.mercury;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Registrazione
 */
@WebServlet("/Registrazione")
public class Registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String NomeE = "'"+request.getParameter("Rnome")+"'";
		String Logo = "'"+request.getParameter("Rlogo")+"'";
		String NomeRef = "'"+request.getParameter("Rref")+"'";
		String Tel = "'"+request.getParameter("Rcell")+"'";
		String NICC = "'"+request.getParameter("RICC")+"'";
		String Email = "'"+request.getParameter("Remail")+"'";
		String Password = "'"+request.getParameter("Rpass")+"'";
		String Cda = "'"+request.getParameter("Rcomune")+"'";
		Boolean EmailVerifica=false;
		
		
		try {
			if (!NomeE.equals("''") & !Logo.equals("''") & !NomeRef.equals("''") & !Tel.equals("''") & !NICC.equals("''") & !Email.equals("''") & !Password.equals("''") & !Cda.equals("'null'"))
			{
				ResultSet Controllo=query().executeQuery("SELECT emailk FROM accesso WHERE emailk="+Email);				
				
				EmailVerifica=Controllo.first();
				
				if (EmailVerifica==false)
				{
					ResultSet Correzione=query().executeQuery("SELECT pk FROM comune WHERE nome="+Cda);
					Correzione.next();
					String Cda_pk=Correzione.getString("pk");
					query().execute("INSERT INTO ente (nome,logo,nome_referente,telefono,iscrizione_cc,mail,comune_pk,eliminato) VALUES ("+NomeE+","+Logo+","+NomeRef+","+Tel+","+NICC+","+Email+","+Cda_pk+","+0+")");
			
					ResultSet Correzione2=query().executeQuery("SELECT pk FROM ente WHERE nome="+NomeE);
					Correzione2.next();
					String NomeE_pk=Correzione2.getString("pk");
					query().execute("INSERT INTO accesso (emailk,password,tipo,ente_pk) VALUES ("+Email+","+Password+","+2+","+NomeE_pk+")");
					request.setAttribute("risultato","Registrazione avvenuta con successo");
					getServletContext().getRequestDispatcher("/admin/login.jsp").forward(request,response);
				}
				else if (EmailVerifica==true) {
					request.setAttribute("risultato","Email già usata");
					getServletContext().getRequestDispatcher("/admin/register.jsp").forward(request,response);
				}
				
			}
			else { 
				request.setAttribute("risultato","uno o più campi mancanti");
				getServletContext().getRequestDispatcher("/admin/register.jsp").forward(request,response);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
public static Statement query() {	
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/mydb?user=root&password=F1nestra");
			Statement st=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			return st;
		}
		catch(Exception e){
			System.out.println("PROBLEMA");
			e.printStackTrace();
			return null;
		}
		
	}
}
