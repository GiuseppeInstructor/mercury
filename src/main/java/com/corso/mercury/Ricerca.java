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
		boolean successo=true;
		
		if(request.getParameter("regione")!=null)
		{
			if(request.getParameter("regione").equals("def"))
			{
				successo=false;
			}
		}
		if(request.getParameter("provincia")!=null)
		{
			if(request.getParameter("provincia").equals("def")) {
				successo=false;
			}
		}
		if(request.getParameter("comune")!=null)
		{
			if(request.getParameter("comune").equals("def")) {
				successo=false;
			}
		}

		
		if(successo) {
		if(request.getParameter("1")!=null)
		{
			request.setAttribute("regione_pk",Regione);
			successo=true;
		}
		else if(request.getParameter("2")!=null) {
			request.setAttribute("provincia_pk",Provincia);
			successo=true;
		}
		else if(request.getParameter("3")!=null) {
			request.setAttribute("comune_pk",Comune);
			successo=true;
		}
		else if(request.getParameter("4")!=null){
			successo=true;
		}
		getServletContext().getRequestDispatcher("/index.jsp").forward(request,response);
		}
		
		if(!successo) {
			response.sendRedirect("index.jsp");
		}
		
	}

}
