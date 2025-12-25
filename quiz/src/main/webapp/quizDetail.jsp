<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/quizdetail.css">
</head>

<body>

<div class="container">
    <div class="text">🎉 Quiz Created Successfully!</div>

    <div class="image">
        <img src="<%=request.getContextPath()%>/images/success.jpg" alt="Success">
    </div>

<a class="back-btn" href="<%=request.getContextPath()%>/createQuiz.jsp">
    Create Another Quiz
</a>

<a class="back-btn secondary" href="<%=request.getContextPath()%>/AdminDashboard.jsp">
    Back to Admin Dashboard
</a>

</div>

</body>
</html>
