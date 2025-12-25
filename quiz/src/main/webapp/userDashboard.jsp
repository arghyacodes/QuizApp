<%@ page import="java.sql.* , util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/userdashboardstyle.css">
</head>
<body>
<jsp:include page="userHeader.jsp" />

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