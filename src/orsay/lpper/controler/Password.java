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
 * Servlet implementation class Password
 */
@WebServlet("/Password")
public class Password extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Model_Connexion _model;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Password() {
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
		String userId = request.getParameter("userId");
		int userid = -1;
		userid = Integer.parseInt(userId);
		
		String actualPassword = request.getParameter("actualPassword");
		String newPassword = request.getParameter("newPassword");
		String confirm = request.getParameter("confirm");
		
		if(actualPassword != null && newPassword!= null && confirm != null && actualPassword != "" && newPassword!= "" && confirm != "")
		{
			if(newPassword == confirm)
			{
				
				ResultSet rs = _model.connectionWithId(userid, actualPassword); // Vérification pseudo existant
				int cpt=0;
				try {
					while(rs.next())
					{
						++cpt;
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				if(cpt > 0) // Mot de passe correct
				{
					int result;
					try {
						result = _model.modifPassword(userid,newPassword);
						if(result >0) // Changement mot de passe réussi
						{
							HttpSession s = request.getSession();
							s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
						}
						else
						{
							HttpSession s = request.getSession();
							s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
						}
					} catch (NoSuchAlgorithmException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
				else
				{
					HttpSession s = request.getSession();
					s.getServletContext().getRequestDispatcher("/compte.jsp").forward(request, response);
				}
			}
			else
			{
				HttpSession s = request.getSession();
				s.getServletContext().getRequestDispatcher("/compte.jsp").forward(request, response);
			}
		}
		else
		{
			HttpSession s = request.getSession();
			s.getServletContext().getRequestDispatcher("/compte.jsp").forward(request, response);
		}
	}

}
