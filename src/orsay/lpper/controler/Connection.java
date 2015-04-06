package orsay.lpper.controler;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import orsay.lpper.model.Model_Connexion;

/**
 * Servlet implementation class Connection
 */
@WebServlet("/Connection")
public class Connection extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Model_Connexion _model;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Connection() {
        super();
        _model = new Model_Connexion();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String login = request.getParameter("login");
		String mdp = request.getParameter("mdp");
		ResultSet rs = _model.connection(login, mdp);
		
		try {
			
			if(rs.wasNull())
			{
				String page = "/PageConnection.jsp";
				
				HttpSession s = request.getSession();
				
				s.getServletContext().getRequestDispatcher(page).forward(request, response);
			}
			else
			{
				if (rs.next()) 
				{
					int type = rs.getInt(2);
					
					// Set the person in session
					
					String prenom = rs.getString(5);
					String nom = rs.getString(6);
					String page = "/AccueilEleve.jsp";
					
					if(type == 1)
					{
						page = "/AccueilProf.jsp";
					}

					HttpSession s = request.getSession();
					
					s.setAttribute("prenom", prenom);
					s.setAttribute("nom", nom);
					
					s.getServletContext().getRequestDispatcher(page).forward(request, response);
					
				}
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
