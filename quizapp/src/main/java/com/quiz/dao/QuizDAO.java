package com.quiz.dao;

import com.quiz.model.Quiz;
import com.quiz.model.Question;
import com.quiz.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {

    // ➕ Add a new quiz to the database
    public boolean addQuiz(Quiz quiz) {
        boolean isAdded = false;

        String sql = "INSERT INTO quiz (name, category) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, quiz.getQuizName());
            ps.setString(2, quiz.getCategory());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                isAdded = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isAdded;
    }

    // 🔍 Fetch quiz details and all its questions
    public Quiz getQuizById(int quizId) {
        Quiz quiz = null;

        try (Connection conn = DBConnection.getConnection()) {

            // Fetch quiz name and category
            String quizQuery = "SELECT * FROM quiz WHERE id = ?";
            PreparedStatement psQuiz = conn.prepareStatement(quizQuery);
            psQuiz.setInt(1, quizId);
            ResultSet rsQuiz = psQuiz.executeQuery();

            if (rsQuiz.next()) {
                quiz = new Quiz();
                quiz.setId(rsQuiz.getInt("id"));
                quiz.setQuizName(rsQuiz.getString("name"));
                quiz.setCategory(rsQuiz.getString("category"));
            }

            if (quiz != null) {
                // Fetch associated questions
                String questionQuery =
                        "SELECT q.Id, q.category, q.questionText, q.optionA, q.optionB, q.optionC, q.optionD, q.correctOption " +
                        "FROM question q " +
                        "INNER JOIN quiz_question qq ON q.id = qq.question_id " +
                        "WHERE qq.quiz_id = ?";
                PreparedStatement psQues = conn.prepareStatement(questionQuery);
                psQues.setInt(1, quizId);
                ResultSet rsQues = psQues.executeQuery();

                List<Question> questions = new ArrayList<>();
                while (rsQues.next()) {
                    Question q = new Question();
//                    q.setId(rsQues.getInt("id"));
                    q.setCategory(rsQues.getString("category"));
                    q.setQuestionText(rsQues.getString("questionText"));
                    q.setOptionA(rsQues.getString("optionA"));
                    q.setOptionB(rsQues.getString("optionB"));
                    q.setOptionC(rsQues.getString("optionC"));
                    q.setOptionD(rsQues.getString("optionD"));
                    q.setCorrectOption(rsQues.getString("correctOption"));
                    questions.add(q);
                }

                quiz.setQuestions(questions);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return quiz;
    }
    
 // Link all questions of the given category to the quiz
    public void linkQuestionsByCategory(int quizId, String category) {
        String selectSql = "SELECT Id FROM question WHERE category = ?";
        String insertSql = "INSERT INTO quiz_question (quiz_id, question_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement psSelect = conn.prepareStatement(selectSql);
             PreparedStatement psInsert = conn.prepareStatement(insertSql)) {

            psSelect.setString(1, category);
            ResultSet rs = psSelect.executeQuery();

            while (rs.next()) {
                int questionId = rs.getInt("Id");
                psInsert.setInt(1, quizId);
                psInsert.setInt(2, questionId);
                psInsert.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getLastInsertedQuizId() {
        int id = -1;
        String sql = "SELECT id FROM quiz ORDER BY id DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }

    public Question getQuestionById(int questionId) {
        Question q = null;
        String sql = "SELECT * FROM question WHERE Id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, questionId);
            ResultSet rs = ps.executeQuery();

//            if (rs.next()) {
//                q = new Question();
//                q.setId(rs.getInt("id"));
//                q.setQuestion_text(rs.getString("question_text"));
//                q.setOption_a(rs.getString("option_a"));
//                q.setOption_b(rs.getString("option_b"));
//                q.setOption_c(rs.getString("option_c"));
//                q.setOption_d(rs.getString("option_d"));
//                q.setCorrect_option(rs.getString("correct_option"));
//                q.setCategory(rs.getString("category"));
//            }
            
            if (rs.next()) {
                q = new Question();
//                q.setId(rs.getInt("id"));
                q.setCategory(rs.getString("category"));
                q.setQuestionText(rs.getString("questionText"));
                q.setOptionA(rs.getString("optionA"));
                q.setOptionB(rs.getString("optionB"));
                q.setOptionC(rs.getString("optionC"));
                q.setOptionD(rs.getString("optionD"));
                q.setCorrectOption(rs.getString("correctOption"));
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return q;
    }


 // Fetch quizzes with limit and offset for pagination
    public List<Quiz> getQuizzesWithQuestions(int offset, int limit) {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM quiz ORDER BY id DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setQuizName(rs.getString("name"));
                quiz.setCategory(rs.getString("category"));

                // Fetch questions for this quiz
                quiz.setQuestions(getQuizById(quiz.getId()).getQuestions());

                quizzes.add(quiz);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quizzes;
    }

    // Get total quiz count
    public int getTotalQuizCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM quiz";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }


    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM question"; // or your category table

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

}
