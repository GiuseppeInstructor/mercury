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
		int Index = 0;// 1=Elimina (eventi) 2=Ripristina (eventi) 3=Blocca (enti) 4=Riammetti (Enti) 5=Ridireziona
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
						Index=5;
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
				request.setAttribute("risultato",request.getParameter("risultato"));
				getServletContext().getRequestDispatcher("/admin/eventi.jsp").forward(request,response);
			}
			else if(Nome!=null&& Index==2) {
				AdminServer.query().execute("UPDATE eventi SET eliminazione = 0 WHERE nome ="+Nome);
				request.setAttribute("risultato",request.getParameter("risultato"));
				getServletContext().getRequestDispatcher("/admin/eventi.jsp").forward(request,response);
			}
			else if(Nome!=null&& Index==3) {
				AdminServer.query().execute("UPDATE ente P,accesso A SET P.eliminato = 1 , P.motivazione="+"'"+New_MotivoBan+"'"+", A.tipo=3 WHERE P.nome ="+Nome+" AND P.pk=A.ente_pk;");
				request.setAttribute("risultato",request.getParameter("risultato"));
				getServletContext().getRequestDispatcher("/admin/enti.jsp").forward(request,response);
			}
			else if(Nome!=null&& Index==4) {
				AdminServer.query().execute("UPDATE ente P,accesso A SET P.eliminato = 0 , P.motivazione=NULL, A.tipo=2 WHERE P.nome ="+Nome+" AND P.pk=A.ente_pk;");
				request.setAttribute("risultato",request.getParameter("risultato"));
				getServletContext().getRequestDispatcher("/admin/enti.jsp").forward(request,response);
			}
			else if(Index==5)
			{
				getServletContext().getRequestDispatcher("/admin/moduloban.jsp").forward(request,response);
			}
			//login
			else if(Nome==null&& Index==0) {
				String email=request.getParameter("Lemail");
				String password=request.getParameter("Lpass");
				String[] data= AdminServer.login(email,password);
				
				if(Integer.parseInt(data[0])==0)
				{
					request.setAttribute("risultato","Email o Password Errati");
					getServletContext().getRequestDispatcher("/admin/login.jsp").forward(request,response);
				}
				else if(Integer.parseInt(data[0])==1)
				{
					
					request.setAttribute("risultato",data[1]);
					getServletContext().getRequestDispatcher("/admin/eventi.jsp").forward(request,response);
				}
				else if(Integer.parseInt(data[0])==2)
				{
					request.setAttribute("risultato",data[1]);
					getServletContext().getRequestDispatcher("/admin/InserireEventi.jsp").forward(request,response);
				}
				else if(Integer.parseInt(data[0])==3)
				{
					request.setAttribute("risultato","Questo account è stato SOSPESO Motivazione= "+data[2]);
					getServletContext().getRequestDispatcher("/admin/login.jsp").forward(request,response);
				}
				
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

public static String[] login(String email, String password) {
		String[] data = {"0",null,null};
		if (email.equals("admin")&& password.equals("123"))
		{
			data[0]="1";
			data[1]="Admin";
		}
		else {
			try {
				ResultSet rst3=AdminServer.query().executeQuery("SELECT P.motivazione,P.nome,A.tipo,A.emailk,A.password,tipo FROM accesso A INNER JOIN ente P ON p.pk=A.ente_pk");
				while(rst3.next()) {
					if (rst3.getString("A.emailk").equals(email) && rst3.getString("A.password").equals(password) && rst3.getString("A.tipo").equals("3")) {
						data[0]=rst3.getString("A.tipo");
						data[1]=rst3.getString("P.nome");
						data[2]=rst3.getString("P.motivazione");
					}
					else if (rst3.getString("A.emailk").equals(email) && rst3.getString("A.password").equals(password)) {
						data[0]=rst3.getString("A.tipo");
						data[1]=rst3.getString("P.nome");
					}

				
				}

			} 
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return data;
	}
}
