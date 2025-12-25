<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dao.QuizDAO" %>
<%
    QuizDAO dao = new QuizDAO();
    List<String> categories = dao.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Quiz</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/createquiz.css">
</head>

<body>
    <div class="container">
        <div class="quiz-icon">🧠</div>
        <h2>Create New Quiz</h2>

        <form action="<%= request.getContextPath() %>/CreateQuizServlet" method="post">
            <label for="title">Quiz Title</label>
            <input type="text" id="title" name="title" placeholder="Enter quiz title" required>

            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="" disabled selected>--- Select Category ---</option>
                <%
                    for(String cat : categories) {
                %>
                    <option value="<%=cat%>"><%=cat%></option>
                <%
                    }
                %>
            </select>

            <button type="submit">Create Quiz</button>
        </form>
        <div class="back-wrapper">
    <a class="back-btn" href="<%=request.getContextPath()%>/AdminDashboard.jsp">
        Back to Admin Dashboard
    </a>
</div>
        
    </div>
</body>
</html>