package com.corso.mercury;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class news
 */
@WebServlet("/news")
public class news extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Email = "'"+request.getParameter("email")+"'";
		String Categoria = request.getParameter("Categoria");
		String Zona = request.getParameter("Zona");
		String Zona2 = "'"+request.getParameter("Zona2")+"'";
		String Frequenza = request.getParameter("Frequenza");
		
		try {
			if (!Email.equals("''") & Categoria!=null & Zona!=null & !Zona2.equals("") & Frequenza!=null)
			{
				AdminServer.query().execute("INSERT INTO newsletter (mail,preferenzazonak,preferenzatipok,cadenzaricezione) VALUES ("+Email+","+Integer.parseInt(Zona)+","+Integer.parseInt(Categoria)+","+Integer.parseInt(Frequenza)+")");
				request.setAttribute("operazione","Operazione completata, Ricompila il modulo per inserire un nuovo eventi");
				getServletContext().getRequestDispatcher("/newsletter.jsp").forward(request,response);
			}
			else {
				request.setAttribute("operazione","uno o più campi mancanti");
				getServletContext().getRequestDispatcher("/newsletter.jsp").forward(request,response);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
