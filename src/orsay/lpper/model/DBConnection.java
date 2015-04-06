package orsay.lpper.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static String host = "localhost";
	private static String db = "projet_je";
	private static String login = "root";
	private static String password = "";
	private static String port = "3306";
	
	
	
	
	private static Connection connection = null;

	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		if (connection == null) {
			Class.forName(com.mysql.jdbc.Driver.class.getName());
			connection = DriverManager.getConnection("jdbc:mysql://" + host + ":" + port + "/" + db, login, password);
		}
		return connection;
	}
}
