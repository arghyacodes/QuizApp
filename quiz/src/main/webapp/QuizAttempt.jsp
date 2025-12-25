<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Attempt Quiz</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/quizattempt.css">
</head>
<body>
<jsp:include page="userHeader.jsp" />

<%
    List<Map<String,Object>> questions = (List<Map<String,Object>>) session.getAttribute("questions");
    if (questions == null) { response.sendRedirect("userDashboard.jsp"); return; }
%>

<h2>Attempt Quiz</h2>
<form action="<%=request.getContextPath() %>/submitQuiz" method="post">
<%
    int qNo = 1;
    for (Map<String,Object> q : questions) {
%>
<div class="question-card">
    <p><b><%= qNo++ %>. <%= q.get("question_text") %></b></p>
    <input type="radio" id="q<%= q.get("id") %>A" name="q<%= q.get("id") %>" value="A">
    <label class="option-label" for="q<%= q.get("id") %>A"><%= q.get("option_a") %></label>

    <input type="radio" id="q<%= q.get("id") %>B" name="q<%= q.get("id") %>" value="B">
    <label class="option-label" for="q<%= q.get("id") %>B"><%= q.get("option_b") %></label>

    <input type="radio" id="q<%= q.get("id") %>C" name="q<%= q.get("id") %>" value="C">
    <label class="option-label" for="q<%= q.get("id") %>C"><%= q.get("option_c") %></label>

    <input type="radio" id="q<%= q.get("id") %>D" name="q<%= q.get("id") %>" value="D">
    <label class="option-label" for="q<%= q.get("id") %>D"><%= q.get("option_d") %></label>
</div>
<% } %>
<input type="submit" value="Submit Quiz">
</form>
</body>
</html>