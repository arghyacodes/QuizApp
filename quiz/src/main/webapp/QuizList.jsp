<%@ page import="java.util.List, java.util.Collections, model.Quiz, model.Question, dao.QuizDAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // --- Pagination Setup ---
    int currentPage = 1; // default page
    int recordsPerPage = 5; // quizzes per page
    int questionsPerPage = 3; // questions per quiz per page

    if(request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    int offset = (currentPage - 1) * recordsPerPage;

    QuizDAO dao = new QuizDAO();
    int totalRecords = dao.getTotalQuizCount();
    int totalPages = (int)Math.ceil(totalRecords * 1.0 / recordsPerPage);

    // Fetch quizzes from DAO
    List<Quiz> quizzes = dao.getQuizzesWithQuestions(offset, recordsPerPage);

    // Sort quizzes so newest first (highest ID first)
    Collections.sort(quizzes, (q1, q2) -> q2.getId() - q1.getId());

    int prevPage = currentPage - 1;
    int nextPage = currentPage + 1;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Quizzes</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/quizlist.css">
</head>
<body>

<h2>All Quizzes</h2>

<table>
    <thead>
        <tr>
            <th>#</th>
            <th>Quiz Name</th>
            <th>Category</th>
            <th>Questions</th>
        </tr>
    </thead>
    <tbody>
    <%
        int count = offset + 1;
        for(Quiz quiz : quizzes) {
            List<Question> allQuestions = quiz.getQuestions();
            int totalQuestions = allQuestions.size();

            // Inner pagination for questions
            int questionPage = 1;
            String param = request.getParameter("qPage_" + quiz.getId());
            if(param != null) questionPage = Integer.parseInt(param);

            int questionOffset = (questionPage - 1) * questionsPerPage;
            int questionEnd = Math.min(questionOffset + questionsPerPage, totalQuestions);
    %>
        <tr>
            <td><%= count++ %></td>
            <td><%= quiz.getQuizName() %></td>
            <td><%= quiz.getCategory() %></td>
            <td>
                <table class="question-table">
                    <tr>
                        <th>#</th>
                        <th>Question</th>
                        <th>A</th>
                        <th>B</th>
                        <th>C</th>
                        <th>D</th>
                        <th>Correct</th>
                    </tr>
                    <%
                        int qCount = questionOffset + 1;
                        for(int i=questionOffset; i<questionEnd; i++) {
                            Question q = allQuestions.get(i);
                    %>
                    <tr>
                        <td><%= qCount++ %></td>
                        <td><%= q.getQuestionText() %></td>
                        <td><%= q.getOptionA() %></td>
                        <td><%= q.getOptionB() %></td>
                        <td><%= q.getOptionC() %></td>
                        <td><%= q.getOptionD() %></td>
                        <td><%= q.getCorrectOption() %></td>
                    </tr>
                    <% } %>
                </table>

                <!-- Inner pager for questions -->
                <div class="questionPager">
                    <%
                        int totalQuestionPages = (int)Math.ceil((double)totalQuestions / questionsPerPage);
                        for(int qp=1; qp<=totalQuestionPages; qp++){
                            if(qp==questionPage){
                    %>
                        <span><%= qp %></span>
                    <% } else { %>
                        <a href="QuizList.jsp?currentPage=<%=currentPage%>&qPage_<%=quiz.getId()%>=<%=qp%>"><%= qp %></a>
                    <% } } %>
                </div>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>

<!-- Outer pager for quizzes -->
<div class="pager">
    <% if(prevPage>=1){ %>
        <a href="QuizList.jsp?currentPage=<%=prevPage%>">« Previous</a>
    <% } else { %>
        <span>« Previous</span>
    <% } %>

    <% for(int i=1;i<=totalPages;i++){
        if(i==currentPage){ %>
            <span><%=i%></span>
        <% } else { %>
            <a href="QuizList.jsp?currentPage=<%=i%>"><%=i%></a>
    <% } } %>

    <% if(nextPage<=totalPages){ %>
        <a href="QuizList.jsp?currentPage=<%=nextPage%>">Next »</a>
    <% } else { %>
        <span>Next »</span>
    <% } %>
</div>
<div class="back-wrapper">
    <a class="back-btn" href="<%=request.getContextPath()%>/AdminDashboard.jsp">
        Back to Admin Dashboard
    </a>
</div>
</body>
</html>