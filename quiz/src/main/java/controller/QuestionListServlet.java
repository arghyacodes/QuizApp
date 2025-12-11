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
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Get the data from the DAO
        QuestionDAO dao = new QuestionDAO();
        List<Question> questionList = dao.getAllQuestions();
        
        // 2. Set the data as an attribute for the JSP
        request.setAttribute("questionList", questionList);
        
        // 3. Forward the request to the JSP view
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/QuestionList.jsp");
        dispatcher.forward(request, response);
    }
}
