package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() throws Exception {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    return DriverManager.getConnection(
	        "jdbc:mysql://127.0.0.1:3306/QuizDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
	        "root",
	        "root@39"
	    );
	}
}