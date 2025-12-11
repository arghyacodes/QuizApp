package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.DBConnection;

@WebServlet("/attemptQuiz")
public class AttemptQuizServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT q.* FROM question q JOIN quiz_question qq ON q.id=qq.question_id WHERE qq.quiz_id=?");
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            List<Map<String,Object>> questions = new ArrayList<>();
            while (rs.next()) {
                Map<String,Object> q = new HashMap<>();
                q.put("id", rs.getInt("id"));
                q.put("question_text", rs.getString("questionText"));
                q.put("option_a", rs.getString("optiona"));
                q.put("option_b", rs.getString("optionb"));
                q.put("option_c", rs.getString("optionc"));
                q.put("option_d", rs.getString("optiond"));
                q.put("correct_option", rs.getString("correctOption"));
                questions.add(q);
            }

            HttpSession session = request.getSession();
            session.setAttribute("quizId", quizId);
            session.setAttribute("questions", questions);

            response.sendRedirect(request.getContextPath() +"/user/QuizAttempt.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
