package com.quiz.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.quiz.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/submitQuiz")
public class SubmitQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        int quizId = (int) session.getAttribute("quizId");
        List<Map<String,Object>> questions = (List<Map<String,Object>>) session.getAttribute("questions");

        int correct = 0;
        List<Map<String,String>> review = new ArrayList<>();

        for (Map<String,Object> q : questions) {
            String qid = "q" + q.get("id");
            String chosen = request.getParameter(qid);
            String correctOpt = (String) q.get("correct_option");

            Map<String,String> item = new HashMap<>();
            item.put("question", (String) q.get("question_text"));
            item.put("chosen", chosen != null ? chosen : "Not Answered");
            item.put("correct", correctOpt);

            if (chosen != null && chosen.equalsIgnoreCase(correctOpt))
                correct++;

            review.add(item);
        }

        int userId = 0;
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT id FROM user WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) userId = rs.getInt("id");

            PreparedStatement insert = conn.prepareStatement(
                "INSERT INTO result(user_id, quiz_id, score) VALUES(?,?,?)");
            insert.setInt(1, userId);
            insert.setInt(2, quizId);
            insert.setInt(3, correct);
            insert.executeUpdate();
        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("score", correct);
        request.setAttribute("review", review);
        request.getRequestDispatcher("User/Result.jsp").forward(request, response);
    }
}
