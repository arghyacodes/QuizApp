<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Result</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f8f9fa; /* light background */
    margin: 0;
    padding: 0;
}

/* Header */
h2 {
    text-align: center;
    color: #343a40;
    margin-top: 2rem;
}

/* Table styling */
table {
    width: 80%;
    margin: 2rem auto;
    border-collapse: collapse;
    background-color: #ffffff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

table th, table td {
    padding: 0.8rem;
    text-align: center;
    font-size: 1rem;
    border-bottom: 1px solid #dee2e6;
}

table th {
    background-color: #36b9cc; /* blue header */
    color: #ffffff;
    font-weight: bold;
}

/* Correct/Wrong row colors */
.correct { 
    background-color: #d4edda; /* light green */
    color: #155724;
}
.wrong { 
    background-color: #f8d7da; /* light red */
    color: #721c24;
}

/* Buttons */
a.action-btn {
    display:inline-block;
    margin: 1rem 0.5rem;
    padding: 0.5rem 1rem;
    border: none;
    background-color: #36b9cc; /* button color */
    color: white;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
    transition: background 0.3s, transform 0.2s;
}

a.action-btn:hover { 
    background-color: #2a9dab; 
    transform: scale(1.05);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    table {
        width: 95%;
    }
    a.action-btn {
        width: 45%;
        text-align: center;
    }
}
</style>
</head>
<body>
<jsp:include page="userHeader.jsp" />

<h2>Your Score: <%= request.getAttribute("score") %></h2>

<table>
<tr><th>Question</th><th>Your Answer</th><th>Correct Answer</th></tr>
<%
    List<Map<String,String>> review = (List<Map<String,String>>) request.getAttribute("review");
    for (Map<String,String> r : review) {
        String chosen = r.get("chosen");
        String correct = r.get("correct");
%>
<tr class="<%= chosen.equalsIgnoreCase(correct) ? "correct" : "wrong" %>">
    <td><%= r.get("question") %></td>
    <td><%= chosen %></td>
    <td><%= correct %></td>
</tr>
<% } %>
</table>

<div style="text-align:center;">
    <a class="action-btn" href="userLeaderboard.jsp">View Leaderboard</a>
    <a class="action-btn" href="userDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>