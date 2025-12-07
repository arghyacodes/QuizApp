package com.quiz.controller;

import com.quiz.dao.AdminDao;
import com.quiz.dao.AdminDao;
import com.quiz.model.Admin;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/Admin/AdminLoginServlet")
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
            resp.sendRedirect(req.getContextPath() + "/admin/AdminDashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid credentials!");
//            RequestDispatcher rd = req.getRequestDispatcher("Admin/AdminLogin.jsp");
//            rd.forward(req, resp);
            resp.sendRedirect(req.getContextPath()+"/admin/AdminLogin.jsp");
        }
    }
}
