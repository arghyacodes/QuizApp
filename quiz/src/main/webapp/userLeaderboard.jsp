<%@ page import="java.sql.*, util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leaderboard</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/userleaderboard.css">
</head>
<body>

<h2>Leaderboard</h2>

<table>
<tr>
    <th>Rank</th>
    <th>Username</th>
    <th>Quiz</th>
    <th>Score</th>
</tr>
<%
    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement(
            "SELECT u.username, q.name, r.score FROM result r " +
            "JOIN user u ON r.user_id=u.id JOIN quiz q ON r.quiz_id=q.id " +
            "ORDER BY r.score DESC"
        );
        ResultSet rs = ps.executeQuery();
        int rank = 1;
        while (rs.next()) {
%>
<tr>
    <td><%= rank++ %></td>
    <td><%= rs.getString("username") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getInt("score") %></td>
</tr>
<% 
        } 
    } catch(Exception e){ 
        out.println("<tr><td colspan='4' style='color:red;text-align:center;'>Error: "+e.getMessage()+"</td></tr>"); 
    } 
%>
</table>

<div style="text-align:center;">
    <a class="action-btn" href="userDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>