<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz App | Admin Login</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/adminloginstyle.css">
</head>
<body>

    <!-- Left Section -->
    <div class="left-section">
        <div class="quiz-icon">Q?</div>
        <div class="logo">QuizPro Admin</div>
        <div class="tagline">Empower Your Quiz Management</div>
<img 
    src="<%= request.getContextPath() %>/images/admin-login.jpg"
    style="border-radius:15px; width:80%; margin-top:20px;"
    alt="Admin Login Image">

    </div>

    <!-- Right Section -->
    <div class="right-section">
        <div class="welcome-text">Welcome Back, Admin</div>

        <% 
            String error = (String) request.getAttribute("error");
            if(error != null) {
        %>
            <div class="error"><%= error %></div>
        <% } %>

        <form action="<%=request.getContextPath()%>/quizapp/AdminLoginServlet" method="post">
            <label for="username">Username</label>
            <input type="text" id="email" name="username" placeholder="Enter your username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <button type="submit">Login</button>
        </form>
	<div class="switch-user">
    <a href="<%=request.getContextPath()%>/user.jsp" class="user-btn">
        Not an admin? Login as User
    </a>
</div>
	
        <div class="footer-text">Dev : Arghya Ghoshal<span></span></div>
    </div>

</body>
</html>