package controller;

import dao.QuizDAO;
import model.Quiz;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/CreateQuizServlet")
public class CreateQuizServlet extends HttpServlet {
	 boolean success;
	  int quizId;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String category = request.getParameter("category");

        if (title == null || title.trim().isEmpty() ||
            category == null || category.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/createQuiz.jsp?error=InvalidInput");
            return;
        }

        Quiz quiz = new Quiz();
        quiz.setQuizName(title);
        quiz.setCategory(category);

        QuizDAO dao = new QuizDAO();
       
		try {
			success = dao.addQuiz(quiz);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (success) {
            // Get the generated quiz ID
          
			try {
				quizId = dao.getLastInsertedQuizId();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // We will create this method in DAO

            // Link questions automatically by category
            try {
				dao.linkQuestionsByCategory(quizId, category);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            // Redirect to quiz list or quiz detail page
            response.sendRedirect(request.getContextPath() + "/admin/quizDetail.jsp?quizId=" + quizId);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/createQuiz.jsp?error=DatabaseError");
        }

    }
}
