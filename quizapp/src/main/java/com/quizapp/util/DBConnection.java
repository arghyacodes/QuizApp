package com.quizapp.util;
import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/QuizDB";
    private static final String USER = "root";
    private static final String PASSWORD = "root@39";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver"); // must succeed
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace(); // print here helps debugging
        }
        return conn;
    }
}