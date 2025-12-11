package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.DBConnection;

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

        try (Connection con = DBConnection.getConnection()) {
            if (action.equals("Register")) {
                // Check if user exists
                PreparedStatement checkStmt = con.prepareStatement("select * from user where username=?");
                checkStmt.setString(1, username);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // already exists → redirect to login page
//                    response.sendRedirect("/user/User.jsp?msg=User already exists, please login.");
                	response.sendRedirect("/user.jsp?msg=User already exists, please login.");
                } else {
                    // register user
                    PreparedStatement insertStmt = con.prepareStatement("insert into user(username,password) VALUES(?,?)");
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, password);
                    insertStmt.executeUpdate();

//                    response.sendRedirect(request.getContextPath() + "/user/User.jsp?msg=Registered successfully! Please login now.");
                    response.sendRedirect(request.getContextPath() + "/user.jsp?msg=Registered successfully! Please login now.");
                }

            } else if (action.equals("Login")) {
                PreparedStatement stmt = con.prepareStatement("select * from user where username=? AND password=?");
                stmt.setString(1, username);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // login success
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
//                    response.sendRedirect(request.getContextPath() +"/user/UserDashboard.jsp");
                    response.sendRedirect(request.getContextPath() +"/userDashboard.jsp");
                } else {
//                    response.sendRedirect(request.getContextPath() +"/user/User.jsp?msg=Invalid username or password");
                	response.sendRedirect(request.getContextPath() +"/user.jsp?msg=Invalid username or password");
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
