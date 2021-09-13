package com.corso.mercury;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminServer")
public class AdminServer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String Nome = null;
		String MotivoBan = null;
		String New_MotivoBan = null;
		int Index = 0;// 1=Elimina (eventi) 2=Ripristina (eventi) 3=Blocca (enti) 4=Riammetti (Enti)
		RequestDispatcher rd=null;
		//eventi
		try {
		ResultSet rst=AdminServer.query().executeQuery("SELECT nome FROM eventi"); //imposto una query per ottenere i titoli degli eventi
		 // Controllo Eventi
			while(rst.next()){ //verifico il bottone premuto confrontando il nome dell' bottone (che contiene il nome dell evento) con gli eventi
				 if(request.getParameter(rst.getString("nome")) != null && request.getParameter(rst.getString("nome")).equals("Elimina")) {
					Nome="'"+rst.getString("nome")+"'";//immagazino il nome più le apici 'mario' per mandarlo nella query dopo
					Index=1;//imposto l'indice
					request.setAttribute("modalita","Elimina");//rimando la modalità alla pagina (serve per rimanere sulla sezione elimina)
					break;//interrompo il ciclo while
				 }
				 //stessa cosa per ripristinare
				 else if(request.getParameter(rst.getString("nome")) != null && request.getParameter(rst.getString("nome")).equals("Ripristina")) {
						Nome="'"+rst.getString("nome")+"'";
						Index=2;
						request.setAttribute("modalita","Ripristina");
						break;
				 }
			}
			//Controllo Enti
			if(Nome==null) {
				ResultSet rst2=AdminServer.query().executeQuery("SELECT nome FROM ente");//imposto la query per i nomi degli enti
			 
				while(rst2.next()){ //faccio scorrere la query finche non trovo il nome corretto
					if(request.getParameter(rst2.getString("nome")) != null && request.getParameter(rst2.getString("nome")).equals("Blocca")) {
						request.setAttribute("EnteDaBloccare",rst2.getString("nome"));
						getServletContext().getRequestDispatcher("/admin/moduloban.jsp").forward(request,response);
					}
					else if(request.getParameter(rst2.getString("nome")) != null && request.getParameter(rst2.getString("nome")).equals("Sospendi")) {
						Nome="'"+rst2.getString("nome")+"'"; //stessa cosa per gli eventi
						MotivoBan=request.getParameter("motivo");
						New_MotivoBan=MotivoBan.replace("'", "&#39");
						Index=3;//imposto l'index nella modalità corretta
						request.setAttribute("modalita","Blocca"); //mando la modalità indietro
						break;//interrompo
					}
					//come sopra
					else if(request.getParameter(rst2.getString("nome")) != null && request.getParameter(rst2.getString("nome")).equals("Riammetti")) {
						Nome="'"+rst2.getString("nome")+"'";
						Index=4;
						request.setAttribute("modalita","Riammetti");
						break;
					}
					
				}
			}
			
			// eseguo la query in base alla situazione
			if(Nome!=null&& Index==1) {
				AdminServer.query().execute("UPDATE eventi SET eliminazione = 1 WHERE nome ="+Nome);
				getServletContext().getRequestDispatcher("/admin/eventi.jsp").forward(request,response);
			}
			else if(Nome!=null&& Index==2) {
				AdminServer.query().execute("UPDATE eventi SET eliminazione = 0 WHERE nome ="+Nome);
				getServletContext().getRequestDispatcher("/admin/eventi.jsp").forward(request,response);
			}
			else if(Nome!=null&& Index==3) {
				AdminServer.query().execute("UPDATE ente SET eliminato = 1 , motivazione="+"'"+New_MotivoBan+"'"+" WHERE nome ="+Nome);
				getServletContext().getRequestDispatcher("/admin/enti.jsp").forward(request,response);
			}
			else if(Nome!=null&& Index==4) {
				AdminServer.query().execute("UPDATE ente SET eliminato = 0 , motivazione=NULL WHERE nome ="+Nome);
				getServletContext().getRequestDispatcher("/admin/enti.jsp").forward(request,response);
			}
			else out.println("Errore");
		}
		catch (SQLException e) {
				e.printStackTrace();
		}
		

	}
	
	
public static Statement query() {	
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/mydb?user=root&password=123789");
			Statement st=conn.createStatement();
			return st;
		}
		catch(Exception e){
			System.out.println("PROBLEMA");
			e.printStackTrace();
			return null;
		}
		
	}


}
