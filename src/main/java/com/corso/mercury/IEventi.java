package com.corso.mercury;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class IEventi
 */
@WebServlet("/IEventi")
public class IEventi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Immagine = "'"+request.getParameter("Img")+"'";
		String NomeEv = "'"+request.getParameter("Nevento")+"'";
		String Desc = "'"+request.getParameter("Devento")+"'";
		String Data = "'"+request.getParameter("data")+"'";
		String Citta =  request.getParameter("Ecomune");
		String TipoEv =  request.getParameter("Tevento");
		String EntePk =  request.getParameter("pk");
		String risultato= request.getParameter("risultato");
		try {
			if (!Immagine.equals("''") & !NomeEv.equals("''") & !Desc.equals("''") & !Data.equals("''") & !Citta.equals("null") & !TipoEv.equals("null") & EntePk!=null)
			{
				AdminServer.query().execute("INSERT INTO eventi (immagini,nome,descrizione,data,comune_pk,tipoevento_pk,ente_pk) VALUES ("+Immagine+","+NomeEv+","+Desc+","+Data+","+Citta+","+TipoEv+","+EntePk+")");
				request.setAttribute("operazione","Operazione completata, Ricompila il modulo per inserire un nuovo eventi");
				request.setAttribute("risultato",risultato);
				getServletContext().getRequestDispatcher("/admin/InserireEventi.jsp").forward(request,response);
			}
			else {
				request.setAttribute("operazione","uno o più campi mancanti");
				request.setAttribute("risultato",risultato);
				getServletContext().getRequestDispatcher("/admin/InserireEventi.jsp").forward(request,response);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
