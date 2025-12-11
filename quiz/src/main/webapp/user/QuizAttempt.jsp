<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Attempt Quiz</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f8f9fa; /* light minimal background */
    margin: 0;
    padding: 0;
}

/* Quiz container */
h2 {
    text-align: center;
    margin: 2rem 0;
    color: #343a40;
}

form {
    background-color: #ffffff;
    padding: 2rem;
    border-radius: 12px;
    max-width: 700px;
    margin: 2rem auto;
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
}

/* Question Card */
.question-card {
    background-color: #f1f3f5;
    padding: 1rem 1.5rem;
    margin-bottom: 1.5rem;
    border-radius: 8px;
    transition: transform 0.2s, box-shadow 0.2s;
}

.question-card:hover {
    transform: scale(1.02);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.question-card p {
    margin: 0 0 0.8rem 0;
    font-size: 1.1rem;
    font-weight: 500;
    color: #495057;
}

/* Options */
.question-card input[type=radio] {
    margin-right: 0.6rem;
    cursor: pointer;
}

.option-label {
    display: block;
    padding: 0.4rem 0.6rem;
    border-radius: 6px;
    transition: background 0.2s, color 0.2s;
    cursor: pointer;
}

.question-card input[type=radio]:checked + .option-label {
    background-color: #36b9cc;
    color: white;
}

.option-label:hover {
    background-color: #e9ecef;
}

/* Submit button */
input[type=submit] {
    display: block;
    width: 100%;
    padding: 0.7rem;
    font-size: 1.1rem;
    font-weight: bold;
    color: #ffffff;
    background-color: #36b9cc;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    margin-top: 1rem;
    transition: background 0.3s, transform 0.2s;
}

input[type=submit]:hover {
    background-color: #2a9dab;
    transform: scale(1.03);
}
</style>
</head>
<body>
<jsp:include page="UserHeader.jsp" />

<%
    List<Map<String,Object>> questions = (List<Map<String,Object>>) session.getAttribute("questions");
    if (questions == null) { response.sendRedirect("UserDashboard.jsp"); return; }
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