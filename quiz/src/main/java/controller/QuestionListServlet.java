package controller;

import java.io.IOException;
import java.util.List;

import dao.QuestionDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Question;

@WebServlet("/QuestionListServlet")
public class QuestionListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        QuestionDAO dao = new QuestionDAO();
        List<Question> questionList = dao.getAllQuestions();

        request.setAttribute("questionList", questionList);

        RequestDispatcher rd = request.getRequestDispatcher("/QuestionList.jsp");
        rd.forward(request, response);
    }
}
