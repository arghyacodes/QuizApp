package controller;

import java.io.IOException;

import dao.QuestionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        QuestionDAO dao = new QuestionDAO();
        dao.deleteQuestion(id);

        response.sendRedirect(request.getContextPath() + "/QuestionListServlet");
    }
}
