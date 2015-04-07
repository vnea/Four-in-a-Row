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
			
			if(confirmPassword != null) // Création compte 
			{
				ResultSet rs = _model.connection(pseudo, password); // Vérification pseudo existant
				if(!rs.next()) // Aucun utilisateur ayant ce pseudo
				{
					result = _model.inscription(pseudo, password);
					if(result > 0) // Inscription : succès
					{
						ResultSet rs2 = _model.connection(pseudo, password);
						int idUser = -1;
						int nbMatchGagneSolo = 0;
						int nbMatchPerduSolo = 0;
						int nbMatchNulSolo = 0;
						
						int nbMatchGagneOnline = 0;
						int nbMatchPerduOnline = 0;
						int nbMatchNulOnline = 0;
						int cpt = 0;
						while(rs2.next())
						{
							idUser = rs2.getInt("IdUser");
							nbMatchGagneSolo = rs2.getInt("NbMatchGagne");
							nbMatchPerduSolo = rs2.getInt("NbMatchPerdu");
							nbMatchNulSolo = rs2.getInt("NbMatchNul");
							
							nbMatchGagneOnline = rs2.getInt("NbMatchGagneOnLine");
							nbMatchPerduOnline = rs2.getInt("NbMatchPerduOnLine");
							nbMatchNulOnline = rs2.getInt("NbMatchNulOnLine");
							++cpt;
						}
						
						HttpSession s = request.getSession();
						
						if(cpt > 0)
						{
							s.setAttribute("pseudo", pseudo);
							s.setAttribute("idUser", idUser);
							
							s.setAttribute("nbMatchGagneSolo", nbMatchGagneSolo);
							s.setAttribute("nbMatchPerduSolo", nbMatchPerduSolo);
							s.setAttribute("nbMatchNulSolo", nbMatchNulSolo);
							s.setAttribute("nbMatchGagneOnline", nbMatchGagneOnline);
							s.setAttribute("nbMatchPerduOnline", nbMatchPerduOnline);
							s.setAttribute("nbMatchNulOnline", nbMatchNulOnline);

						}
						
						s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
					}
					else // Echec inscription
					{
						HttpSession s = request.getSession();
						s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
					}
				}
				else // Utilisateur déjà existant
				{
					HttpSession s = request.getSession();
					s.setAttribute("error", true);
					s.setAttribute("typeError", "Erreur d'inscription");
					s.setAttribute("msgError", "Le pseudo que vous avez choisi est déjà utilisé");
					s.setAttribute("modal", "inscription");
					
					s.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
				}
			}
			else // Mode connexion
			{
				ResultSet rs = _model.connection(pseudo, password);
				int idUser = -1;
				int nbMatchGagneSolo = 0;
				int nbMatchPerduSolo = 0;
				int nbMatchNulSolo = 0;
				
				int nbMatchGagneOnline = 0;
				int nbMatchPerduOnline = 0;
				int nbMatchNulOnline = 0;
				int cpt = 0;
				while(rs.next())
				{
					idUser = rs.getInt("IdUser");
					pseudo = rs.getString("Pseudo");
					
					nbMatchGagneSolo = rs.getInt("NbMatchGagne");
					nbMatchPerduSolo = rs.getInt("NbMatchPerdu");
					nbMatchNulSolo = rs.getInt("NbMatchNul");
					
					nbMatchGagneOnline = rs.getInt("NbMatchGagneOnLine");
					nbMatchPerduOnline = rs.getInt("NbMatchPerduOnLine");
					nbMatchNulOnline = rs.getInt("NbMatchNulOnLine");
					++cpt;
				}
				HttpSession s = request.getSession();
				
				if(cpt > 0)
				{
					s.setAttribute("pseudo", pseudo);
					s.setAttribute("idUser", idUser);
					
					s.setAttribute("nbMatchGagneSolo", nbMatchGagneSolo);
					s.setAttribute("nbMatchPerduSolo", nbMatchPerduSolo);
					s.setAttribute("nbMatchNulSolo", nbMatchNulSolo);
					s.setAttribute("nbMatchGagneOnline", nbMatchGagneOnline);
					s.setAttribute("nbMatchPerduOnline", nbMatchPerduOnline);
					s.setAttribute("nbMatchNulOnline", nbMatchNulOnline);
				}
				else
				{
					s.setAttribute("error", true);
					s.setAttribute("typeError", "Problème d'authentification");
					s.setAttribute("msgError", "Les informations fournies ne nous ont pas permis de vous authentifier.");
					s.setAttribute("modal", "connexion");
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
