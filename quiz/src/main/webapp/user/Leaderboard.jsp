<%@ page import="java.sql.*, com.quiz.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leaderboard</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 50%, #fbc2eb 100%);
    min-height: 100vh;
    margin: 0;
    padding: 0;
}

h2 {
    text-align: center;
    margin: 2rem 0;
    color: #2c3e50;
    text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
}

table {
    width: 80%;
    margin: 2rem auto;
    border-collapse: collapse;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

table th, table td {
    padding: 0.8rem;
    text-align: center;
    font-size: 1rem;
    transition: background 0.3s, color 0.3s;
}

table th {
    background: linear-gradient(90deg, #ff416c, #ff4b2b);
    color: white;
    font-weight: bold;
}

table tr:nth-child(even) {
    background: rgba(255, 255, 255, 0.9);
}

table tr:hover {
    background: #ffe066;
    color: #2c3e50;
    transform: scale(1.02);
    transition: 0.3s;
}

a.action-btn {
    display: inline-block;
    margin: 1rem auto;
    padding: 0.5rem 1rem;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
    color: white;
    background: linear-gradient(90deg, #36d1dc, #5b86e5);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    transition: 0.3s;
}

a.action-btn:hover {
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    transform: scale(1.1);
    box-shadow: 0 8px 25px rgba(0,0,0,0.3);
}

</style>
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
    <a class="action-btn" href="UserDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>