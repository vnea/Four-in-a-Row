package orsay.lpper.controler;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
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
		String logOut = request.getParameter("logout");
		if(logOut != "")
		{
		    request.getSession().invalidate();
		    response.sendRedirect("index.jsp");
		    return; 
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String pseudo = request.getParameter("pseudo");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		//System.out.println("DEEEEEEEEEEEEEEEEEEEEEEEEEEBUUUUUUUUUUUUUUUUUG" + confirmPassword);
		int result;
		try {
			
			if(confirmPassword != null)
			{
				result = _model.inscription(pseudo, password);
				if(result > 0)
				{
					ResultSet rs = _model.connection(pseudo, password);
					int idUser = -1;
					int cpt = 0;
					while(rs.next())
					{
						idUser = rs.getInt("IdUser");
						++cpt;
					}
					
					HttpSession s = request.getSession();
					
					if(cpt > 0)
					{
						s.setAttribute("pseudo", pseudo);
						s.setAttribute("idUser", idUser);
					}
					
					s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
				}
				else
				{
					HttpSession s = request.getSession();
					s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
				}

			}
			else
			{
				ResultSet rs = _model.connection(pseudo, password);
				int idUser = -1;
				int cpt = 0;
				while(rs.next())
				{
					idUser = rs.getInt("IdUser");
					++cpt;
				}
				
				HttpSession s = request.getSession();
				
				if(cpt > 0)
				{
					s.setAttribute("pseudo", pseudo);
					s.setAttribute("idUser", idUser);
				}
				
				s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}

			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
