<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Portal</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/userstyle.css">
</head>
<body>

<h2>Login Portal</h2>

<div class="welcome-card">
    <img src="<%=request.getContextPath()%>/images/user.jpg" alt="User Avatar">
    <h3>Welcome!</h3>
    <p>Please login or register to continue.</p>

    <form action="<%= request.getContextPath() %>/user" method="post">
        <label>Username:</label>
        <input type="text" name="username" placeholder="Enter your username" required>

        <label>Password:</label>
        <input type="password" name="password" placeholder="Enter your password" required>

        <input type="submit" name="action" value="Register">
        <input type="submit" name="action" value="Login">
    </form>
	<form action="<%=request.getContextPath()%>/AdminLogin.jsp" method="get">
    <input type="submit" value="Admin Login" class="admin-btn">
	</form>
    <% 
    String message = request.getParameter("msg");
    if(message != null) {
    %>
        <div class="message"><%= message %></div>
    <% } %>
</div>


</body>

</html>