<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Portal</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(to right, #6a11cb, #2575fc);
    margin: 0;
    padding: 0;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
}

h2 {
    color: white;
    margin-top: 2rem;
    text-align: center;
}

.welcome-card {
    background-color: rgba(255, 255, 255, 0.95);
    border-radius: 12px;
    padding: 2rem;
    max-width: 450px;
    width: 90%;
    margin-top: 2rem;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
    text-align: center;
}

.welcome-card img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    margin-bottom: 1rem;
}

form {
    display: flex;
    flex-direction: column;
    text-align: left;
}

form label {
    font-weight: bold;
    margin-top: 0.5rem;
}

form input[type=text], form input[type=password] {
    width: 100%;
    padding: 0.6rem;
    margin: 0.3rem 0 1rem 0;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    transition: border-color 0.3s;
}

form input[type=text]:focus, form input[type=password]:focus {
    border-color: #2575fc;
    outline: none;
}

form input[type=submit] {
    background-color: #2575fc;
    color: white;
    border: none;
    padding: 0.6rem 1rem;
    border-radius: 6px;
    cursor: pointer;
    margin-top: 0.5rem;
    font-size: 1rem;
    transition: background-color 0.3s;
}

form input[type=submit]:hover {
    background-color: #6a11cb;
}

.message {
    text-align: center;
    margin-top: 1rem;
    color: #2c3e50;
    font-weight: bold;
}



</style>
</head>
<body>

<h2>User Portal</h2>

<div class="welcome-card">
    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="User Avatar">
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

    <% 
    String message = request.getParameter("msg");
    if(message != null) {
    %>
        <div class="message"><%= message %></div>
    <% } %>
</div>


</body>

</html>