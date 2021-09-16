package com.corso.mercury;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Ricerca
 */
@WebServlet("/Ricerca")
public class Ricerca extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String Regione = request.getParameter("regione");
		String Provincia = request.getParameter("provincia");
		String Comune = request.getParameter("comune");
		
		request.setAttribute("region",Regione);
		request.setAttribute("prov",Provincia);
		request.setAttribute("comun",Comune);
		getServletContext().getRequestDispatcher("/index.jsp").forward(request,response);
	}

}
