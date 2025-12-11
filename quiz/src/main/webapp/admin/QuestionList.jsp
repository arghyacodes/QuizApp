<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Question" %>

<%
    model.Admin admin = (model.Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/AdminLogin.jsp");
        return;
    }
    List<Question> questionList = (List<Question>) request.getAttribute("questionList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Question List - Admin</title>
<style>
    /* ---------- BODY ---------- */
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 0;
        background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
        min-height: 100vh;
        color: #333;
    }

    /* ---------- HEADER ---------- */
    .header {
        background: #6c63ff;
        color: white;
        padding: 15px 25px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        position: sticky;
        top: 0;
        z-index: 100;
    }
    .header h2 {
        margin: 0;
        font-weight: 600;
    }
    .menu-icon {
        font-size: 28px;
        cursor: pointer;
        transition: 0.3s;
    }
    .menu-icon:hover { transform: scale(1.1); }
    .logout {
        background: #ff6b6b;
        color: white;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 8px;
        font-weight: bold;
        transition: 0.3s;
    }
    .logout:hover { background: #e04e4e; transform: scale(1.05); }

    /* ---------- SIDE MENU ---------- */
    .menu {
        height: 100%;
        width: 0;
        position: fixed;
        z-index: 200;
        top: 0;
        left: 0;
        background: #3f3d56;
        overflow-x: hidden;
        transition: 0.4s;
        padding-top: 60px;
        color: #fff;
        box-shadow: 2px 0 10px rgba(0,0,0,0.2);
    }
    .menu a {
        padding: 12px 25px;
        display: block;
        font-size: 18px;
        color: #ddd;
        text-decoration: none;
        border-radius: 6px;
        transition: 0.3s;
    }
    .menu a:hover { background: #6c63ff; color: white; transform: translateX(5px); }
    .menu .closebtn { position: absolute; top: 0; right: 25px; font-size: 36px; margin-left: 50px; cursor: pointer; }
    .sub-menu {
        display: none;
        padding-left: 20px;
        margin-top: 5px;
    }
    .sub-menu a {
        font-size: 16px;
        color: #ccc;
    }
    .sub-menu a:hover { color: #fff; background: #5a54d1; }

    /* ---------- MAIN CONTENT ---------- */
    .content {
        padding: 20px;
        margin-left: 20px;
        transition: margin-left 0.5s;
    }
    .welcome {
        font-size: 1.3em;
        font-weight: 600;
        color: #2c3e50;
    }

    /* ---------- TABLE STYLES ---------- */
    .question-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        border-radius: 10px;
        overflow: hidden;
    }
    .question-table th, .question-table td {
        padding: 12px;
        text-align: left;
    }
    .question-table th {
        background: #6c63ff;
        color: white;
        font-weight: 600;
    }
    .question-table tr:nth-child(even) { background-color: #f3f3f3; }
    .question-table tr:nth-child(odd) { background-color: #ffffff; }
    .question-table tr:hover { background: #dce8ff; transform: scale(1.01); transition: 0.2s; }

    /* ---------- MEDIA QUERIES ---------- */
    @media(max-width: 768px) {
        .content { margin-left: 0; padding: 15px; }
        .menu { width: 200px; }
        .question-table th, .question-table td { font-size: 14px; padding: 10px; }
    }

</style>
</head>
<body>

<div class="header">
    <span class="menu-icon" onclick="openMenu()">☰</span>
    <h2>Admin Dashboard</h2>
    <a class="logout" href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
</div>

<div id="sideMenu" class="menu">
    <span class="closebtn" onclick="closeMenu()">&times;</span>

    <div class="menu-item">
        <a href="javascript:void(0)" onclick="toggleSubMenu('quizSub')">Quiz Manager ▾</a>
        <div id="quizSub" class="sub-menu">
            <a href="<%=request.getContextPath()%>/admin/CreateQuiz.jsp">Create New Quiz</a>
            <a href="<%=request.getContextPath()%>/admin/QuizList.jsp">Quiz List</a>
        </div>
    </div>

    <div class="menu-item">
        <a href="javascript:void(0)" onclick="toggleSubMenu('questionSub')">Question Manager ▾</a>
        <div id="questionSub" class="sub-menu" style="display: block;">
            <a href="<%=request.getContextPath()%>/admin/AddQuestion.jsp">Add New Question(s)</a>
            <a href="<%=request.getContextPath()%>/QuestionListServlet">Question List</a>
        </div>
    </div>

    <a href="<%=request.getContextPath()%>/admin/leaderboard.jsp">Leaderboard</a>
</div>

<div class="content">
    <p class="welcome">Welcome, <strong><%= admin.getUsername() %></strong> 👋</p>
    
    <h2>All Questions</h2>
    
    <table class="question-table">
        <thead>
            <tr>
                <th>Category</th>
                <th>Question Text</th>
                <th>Option A</th>
                <th>Option B</th>
                <th>Option C</th>
                <th>Option D</th>
                <th>Correct Option</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (questionList != null && !questionList.isEmpty()) {
                    for (Question q : questionList) {
            %>
                        <tr>
                            <td><%= q.getCategory() %></td>
                            <td><%= q.getQuestionText() %></td>
                            <td><%= q.getOptionA() %></td>
                            <td><%= q.getOptionB() %></td>
                            <td><%= q.getOptionC() %></td>
                            <td><%= q.getOptionD() %></td>
                            <td><strong><%= q.getCorrectOption() %></strong></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="7" style="text-align: center;">No questions found.</td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<script>
    function toggleSubMenu(id) {
        var subMenu = document.getElementById(id);
        subMenu.style.display = subMenu.style.display === "block" ? "none" : "block";
    }

    function openMenu() { document.getElementById("sideMenu").style.width = "250px"; }
    function closeMenu() { document.getElementById("sideMenu").style.width = "0"; }
</script>

</body>
</html>