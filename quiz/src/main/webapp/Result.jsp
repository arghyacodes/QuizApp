<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Result</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/result.css">
</head>
<body>
<jsp:include page="userHeader.jsp" />

<div class="score-box">
    Your Score:
    <span class="score-value"><%= request.getAttribute("score") %></span>
</div>


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