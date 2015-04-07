package orsay.lpper.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Model_Connexion {
	
	private Connection connexion; 
	
	public Model_Connexion()
	{
		DBConnection dbc = new DBConnection();
		try {
			connexion =  dbc.getConnection();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ResultSet connection(String login, String mdp)
	{
		try 
		{
			// SQL to check if the person exist in DB
			PreparedStatement ps = connexion.prepareStatement("SELECT * FROM user WHERE Pseudo = ? AND Mdp = ?");
			ps.setString(1, login);
			ps.setString(2, sha1(mdp));

			ResultSet rs = ps.executeQuery();
			return rs;
		}
		catch(Exception e)
		{
			
		}
		return null;
	}
	
	public int inscription(String aPseudo, String aPassword) throws NoSuchAlgorithmException
	{
		try {
			PreparedStatement ps = connexion.prepareStatement("INSERT INTO USER(Pseudo, Mdp, NbMatchGagne, NbMatchPerdu, NbMatchNul, NbMatchGagneOnLine, NbMatchPerduOnLine, NbMatchNulOnLine) VALUES (?, ?, 0, 0, 0, 0, 0, 0)");
			ps.setString(1, aPseudo);
			ps.setString(2, sha1(aPassword));
			int myResult = ps.executeUpdate();
			return myResult;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
		
	}
	
	
	   public static String sha1(String input) throws NoSuchAlgorithmException {
	        byte[] result = MessageDigest.getInstance("SHA1").digest(input.getBytes());
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < result.length; ++i) {
	            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
	        }
	         
	        return sb.toString();
	    }
}
