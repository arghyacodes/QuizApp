<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        /* ---------- GLOBAL ---------- */
        body {
            margin: 0;
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #d0e8ff, #ffe0f0); /* Light blue & pink mix */
            min-height: 100vh;
            color: #333;
            overflow-x: hidden;
        }

        h2, h1 {
            margin: 0;
            font-weight: 600;
        }

        /* ---------- HEADER ---------- */
        .header {
            background: linear-gradient(90deg, #6c63ff, #8b5cf6);
            color: white;
            padding: 15px 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
        }

        .menu-icon {
            font-size: 28px;
            cursor: pointer;
            transition: 0.3s;
        }

        .menu-icon:hover {
            transform: scale(1.1);
        }

        .logout {
            background: #ff6b6b;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }

        .logout:hover {
            background: #e04e4e;
            transform: scale(1.05);
        }

        /* ---------- SIDE MENU ---------- */
        .menu {
            height: 100%;
            width: 0;
            position: fixed;
            z-index: 1000;
            top: 0;
            left: 0;
            background: linear-gradient(180deg, #f4f6ff, #dbe4ff);
            border-right: 1px solid #ccc;
            overflow-x: hidden;
            transition: 0.4s;
            padding-top: 70px;
        }

        .menu a {
            padding: 12px 25px;
            text-decoration: none;
            font-size: 18px;
            color: #333;
            display: block;
            transition: 0.3s;
            border-radius: 8px;
        }

        .menu a:hover {
            background-color: #c7d8ff;
            color: #000;
            transform: translateX(5px);
        }

        .menu .closebtn {
            position: absolute;
            top: 10px;
            right: 25px;
            font-size: 35px;
            color: #555;
        }

        .sub-menu {
            display: none;
            background: linear-gradient(90deg, #e2e8ff, #f1f3ff);
            padding-left: 20px;
            border-left: 3px solid #6c63ff;
            margin-top: 5px;
            margin-bottom: 5px;
            border-radius: 5px;
        }

        .sub-menu a {
            font-size: 16px;
            color: #555;
        }

        .sub-menu a:hover {
            background-color: #dbe4ff;
            color: #111;
        }

        /* ---------- DASHBOARD CONTENT ---------- */
        .content {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: center;
            margin-top: 80px;
        }

        .welcome {
            font-size: 28px;
            font-weight: 600;
            color: #4b4bff;
            margin-bottom: 20px;
        }

        .dashboard-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            margin-top: 30px;
        }

        .card {
            background: linear-gradient(135deg, #ffffff, #f0f4ff);
            width: 230px;
            height: 140px;
            border-radius: 15px;
            color: #333;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: 500;
            font-size: 18px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-8px) scale(1.04);
            box-shadow: 0 10px 20px rgba(0,0,0,0.25);
            background: linear-gradient(135deg, #dbe4ff, #c7d8ff);
        }

        .card i {
            font-size: 35px;
            margin-bottom: 10px;
            color: #6c63ff;
        }

        /* ---------- FOOTER ---------- */
        .footer {
            position: absolute;
            bottom: 15px;
            width: 100%;
            text-align: center;
            color: #555;
            font-size: 13px;
        }

        .footer span {
            color: #6c63ff;
            font-weight: 500;
        }

        /* ---------- MEDIA ---------- */
        @media (max-width: 768px) {
            .dashboard-cards {
                flex-direction: column;
                gap: 15px;
            }
        }

    </style>

    <!-- Font Awesome for icons -->
    <script src="https://kit.fontawesome.com/6d77c6a53a.js" crossorigin="anonymous"></script>
</head>
<body>

    <!-- HEADER -->
    <div class="header">
        <span class="menu-icon" onclick="openMenu()">☰</span>
        <h1>Admin Dashboard</h1>
        <a class="logout" href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
    </div>

    <!-- SIDE MENU -->
    <div id="sideMenu" class="menu">
        <a href="javascript:void(0)" class="closebtn" onclick="closeMenu()">&times;</a>

        <div class="menu-item">
            <a href="javascript:void(0)" onclick="toggleSubMenu('quizSub')">
                <i class="fas fa-question-circle"></i> Quiz Manager ▾
            </a>
            <div id="quizSub" class="sub-menu">
                <a href="<%=request.getContextPath()%>/admin/QuizList.jsp">📜 Quiz List</a>
                <a href="<%=request.getContextPath()%>/admin/createQuiz.jsp">➕ Create New Quiz</a>
            </div>
        </div>

        <div class="menu-item">
            <a href="javascript:void(0)" onclick="toggleSubMenu('questionSub')">
                <i class="fas fa-pen"></i> Question Manager ▾
            </a>
            <div id="questionSub" class="sub-menu">
                <a href="AddQuestion.jsp">➕ Add New Question(s)</a>
                <a href="<%=request.getContextPath()%>/QuestionListServlet">📄 Question List</a>
            </div>
        </div>

        <a href="leaderboard.jsp"><i class="fas fa-trophy"></i> Leaderboard</a>
    </div>

    <!-- MAIN CONTENT -->
    <div class="content">
        <p class="welcome">Welcome, <strong><%= admin.getUsername() %></strong> 👋</p>

        <div class="dashboard-cards">
            <div class="card" onclick="window.location.href='<%=request.getContextPath()%>/admin/createQuiz.jsp'">
                <i class="fas fa-plus-circle"></i>
                Create Quiz
            </div>
            <div class="card" onclick="window.location.href='<%=request.getContextPath()%>/admin/QuizList.jsp'">
                <i class="fas fa-list"></i>
                View All Quizzes
            </div>
            <div class="card" onclick="window.location.href='AddQuestion.jsp'">
                <i class="fas fa-question"></i>
                Add Questions
            </div>
            <div class="card" onclick="window.location.href='<%=request.getContextPath()%>/QuestionListServlet'">
                <i class="fas fa-database"></i>
                Question Bank
            </div>
            <div class="card" onclick="window.location.href='leaderboard.jsp'">
                <i class="fas fa-trophy"></i>
                Leaderboard
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <div class="footer">
         <span>Quiz App</span> | Admin Dashboard
    </div>

    <!-- JS -->
    <script>
        function toggleSubMenu(id) {
            var subMenu = document.getElementById(id);
            subMenu.style.display = subMenu.style.display === "block" ? "none" : "block";
        }

        function openMenu() {
            document.getElementById("sideMenu").style.width = "250px";
        }

        function closeMenu() {
            document.getElementById("sideMenu").style.width = "0";
        }
    </script>

</body>
</html>