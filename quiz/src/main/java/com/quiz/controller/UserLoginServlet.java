package com.quiz.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.quiz.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user")
public class UserLoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2621352181729361033L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String action = request.getParameter("action"); // "Register" or "Login"

        try (Connection conn = DBConnection.getConnection()) {
            if (action.equals("Register")) {
                // Check if user exists
                PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM user WHERE username=?");
                checkStmt.setString(1, username);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // already exists → redirect to login page
                    response.sendRedirect("/User/User.jsp?msg=User already exists, please login.");
                } else {
                    // register user
                    PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO user(username,password) VALUES(?,?)");
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, password);
                    insertStmt.executeUpdate();

                    response.sendRedirect(request.getContextPath() + "/user/User.jsp?msg=Registered successfully! Please login now.");
                }

            } else if (action.equals("Login")) {
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM user WHERE username=? AND password=?");
                stmt.setString(1, username);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // login success
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    response.sendRedirect(request.getContextPath() +"/User/UserDashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() +"/User/User.jsp?msg=Invalid username or password");
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
