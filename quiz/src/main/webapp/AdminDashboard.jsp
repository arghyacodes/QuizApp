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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admindashboard.css">
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
                <a href="<%=request.getContextPath()%>/QuizList.jsp">📜 Quiz List</a>
                <a href="<%=request.getContextPath()%>/createQuiz.jsp">➕ Create New Quiz</a>
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
            <div class="card" onclick="window.location.href='<%=request.getContextPath()%>/createQuiz.jsp'">
                <i class="fas fa-plus-circle"></i>
                Create Quiz
            </div>
            <div class="card" onclick="window.location.href='<%=request.getContextPath()%>/QuizList.jsp'">
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