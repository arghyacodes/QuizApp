<%@ page import="java.util.List, java.util.Collections, com.quiz.model.Quiz, com.quiz.model.Question, com.quiz.dao.QuizDAO" %>
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
<style>
    body { font-family: 'Segoe UI', sans-serif; padding: 20px; background: linear-gradient(135deg,#a1c4fd,#c2e9fb); }
    h2 { text-align:center; color:#2d3436; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; background: #fff; border-radius:10px; overflow:hidden; box-shadow:0 6px 18px rgba(0,0,0,0.15);}
    th, td { border: 1px solid #b2bec3; padding: 10px; text-align:left; }
    th { background: #0984e3; color: #fff; }
    tr:nth-child(even) { background: #dfe6e9; }
    tr:hover { background: #74b9ff; color:#fff; transition:0.3s; }

    /* Inner Question Table */
    .question-table { width: 100%; margin-top: 5px; border-collapse: collapse; }
    .question-table th, .question-table td { border: 1px solid #b2bec3; padding: 5px; font-size:13px; }
    .question-table th { background: #00b894; color: #fff; }
    .question-table tr:nth-child(even) { background: #dff9f0; }
    .question-table tr:hover { background: #00cec9; color:#fff; }

    /* Pager */
    .pager, .questionPager { text-align:center; margin-top:15px; }
    .pager a, .questionPager a { margin: 0 5px; text-decoration:none; color:#0984e3; font-weight:bold; }
    .pager span, .questionPager span { margin:0 5px; font-weight:bold; color:#d63031; }

    /* Card-like effect for quizzes */
    td > table { border-radius:8px; overflow:hidden; box-shadow:0 3px 10px rgba(0,0,0,0.1);}
</style>
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

</body>
</html>