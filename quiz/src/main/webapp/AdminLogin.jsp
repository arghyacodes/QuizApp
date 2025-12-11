<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz App | Admin Login</title>
    <style>
        body {
            margin: 0;
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #007bff, #6c63ff);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        .left-section {
            flex: 1;
            background: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            box-shadow: 5px 0 20px rgba(0, 0, 0, 0.1);
            border-top-right-radius: 50px;
            border-bottom-right-radius: 50px;
        }

        .logo {
            font-size: 36px;
            font-weight: 800;
            color: #007bff;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .tagline {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
        }

        .quiz-icon {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff, #6c63ff);
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 48px;
            font-weight: 700;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .right-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            color: white;
        }

        .welcome-text {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 20px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        form {
            width: 80%;
            max-width: 350px;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #444;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 15px;
            outline: none;
            transition: 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #6c63ff;
            box-shadow: 0 0 5px rgba(108, 99, 255, 0.5);
        }

        button {
            width: 100%;
            background: linear-gradient(135deg, #6c63ff, #007bff);
            color: white;
            font-size: 16px;
            margin-top: 10px;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: linear-gradient(135deg, #007bff, #6c63ff);
            transform: scale(1.03);
        }

        .error {
            color: #ff3b3b;
            text-align: center;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .footer-text {
            margin-top: 20px;
            font-size: 13px;
            color: rgba(255, 255, 255, 0.8);
        }

        .footer-text span {
            color: #ffd700;
        }
    </style>
</head>
<body>

    <!-- Left Section -->
    <div class="left-section">
        <div class="quiz-icon">Q?</div>
        <div class="logo">QuizMaster Admin</div>
        <div class="tagline">Empower Your Quiz Management</div>
        <img class="pug-img" src="https://images.pexels.com/photos/3184326/pexels-photo-3184326.jpeg?auto=compress&cs=tinysrgb&w=600" 
             alt="Quiz Illustration" style="border-radius:15px; width:80%; margin-top:20px;">
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

        <div class="footer-text">Project3---<span></span></div>
    </div>

</body>
</html>