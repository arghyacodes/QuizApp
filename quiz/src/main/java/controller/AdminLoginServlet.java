package controller;

import java.io.IOException;

import dao.AdminDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;

@WebServlet("/quizapp/AdminLoginServlet")
//@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        AdminDao dao = new AdminDao();
        Admin admin = dao.validateAdmin(username, password);

        if (admin != null) {
            HttpSession session = req.getSession();
            session.setAttribute("admin", admin);
            resp.sendRedirect(req.getContextPath() + "/AdminDashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid credentials!");
//            RequestDispatcher rd = req.getRequestDispatcher("Admin/AdminLogin.jsp");
//            rd.forward(req, resp);
            resp.sendRedirect(req.getContextPath()+"/AdminLogin.jsp");
        }
    }
}
