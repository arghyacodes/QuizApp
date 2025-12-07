package com.quiz.model;

import java.util.List;

public class Quiz {
    private int id;
    private String quizName;
    private String category; // 🆕 Added category field
    private List<Question> questions; // each quiz has multiple questions

    // --- Constructors ---
    public Quiz() {}

    public Quiz(int id, String quizName) {
        this.id = id;
        this.quizName = quizName;
    }

    public Quiz(int id, String quizName, String category) {
        this.id = id;
        this.quizName = quizName;
        this.category = category;
    }

    public Quiz(int id, String quizName, String category, List<Question> questions) {
        this.id = id;
        this.quizName = quizName;
        this.category = category;
        this.questions = questions;
    }

    // --- Getters and Setters ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuizName() {
        return quizName;
    }

    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    // --- Optional: toString() for easy debugging ---
    @Override
    public String toString() {
        return "Quiz{" +
                "id=" + id +
                ", quizName='" + quizName + '\'' +
                ", category='" + category + '\'' +
                ", questions=" + (questions != null ? questions.size() : 0) +
                '}';
    }
}
