<%@ page import="java.sql.* , com.quiz.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
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
    text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
}

table {
    width: 80%;
    margin: 2rem auto;
    border-collapse: collapse;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}

table th, table td {
    padding: 0.8rem;
    border: 1px solid #ddd;
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
}

.action-btn {
    padding: 0.4rem 0.8rem;
    border: none;
    background: linear-gradient(90deg, #36d1dc, #5b86e5);
    color: white;
    border-radius: 6px;
    cursor: pointer;
    text-decoration: none;
    font-weight: bold;
    transition: transform 0.2s, background 0.3s;
}

.action-btn:hover {
    background: linear-gradient(90deg, #ff6a00, #ee0979);
    transform: scale(1.05);
}

</style>
</head>
<body>
<jsp:include page="UserHeader.jsp" />

<h2>Welcome, <%= session.getAttribute("username") %></h2>

<table>
<tr>
    <th>ID</th>
    <th>Quiz Name</th>
    <th>Action</th>
</tr>
<%
    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM quiz");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td>
        <a class="action-btn" href="<%=request.getContextPath() %>/attemptQuiz?quizId=<%= rs.getInt("id") %>">Attempt Quiz</a>
    </td>
</tr>
<% 
        } 
    } catch(Exception e){ 
        out.println("<tr><td colspan='3' style='color:red;text-align:center;'>Error: "+e.getMessage()+"</td></tr>"); 
    } 
%>
</table>

</body>
</html>