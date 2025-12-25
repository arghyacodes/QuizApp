package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Question;
import util.DBConnection;

public class QuestionDAO {
	

    public boolean addQuestion(Question question) {
        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO question (category, questionText, optionA , optionB, optionC, optionD, correctOption) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, question.getCategory());
            ps.setString(2, question.getQuestionText());
            ps.setString(3, question.getOptionA());
            ps.setString(4, question.getOptionB());
            ps.setString(5, question.getOptionC());
            ps.setString(6, question.getOptionD());
            ps.setString(7, question.getCorrectOption());

            int inserted = ps.executeUpdate();
            status = inserted > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    public List<Question> getAllQuestions() {
        List<Question> questions = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM question";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id")); // IMPORTANT
                q.setCategory(rs.getString("category"));
                q.setQuestionText(rs.getString("questionText"));
                q.setOptionA(rs.getString("optionA"));
                q.setOptionB(rs.getString("optionB"));
                q.setOptionC(rs.getString("optionC"));
                q.setOptionD(rs.getString("optionD"));
                q.setCorrectOption(rs.getString("correctOption"));
                questions.add(q);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    public void deleteQuestion(int id) {
        String sql = "DELETE FROM question WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
