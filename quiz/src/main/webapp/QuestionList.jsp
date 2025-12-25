<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Question" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Question List</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/questionlist.css">
</head>

<body>

<h2>Question List</h2>

<table>
<tr>
    <th>ID</th>
    <th>Category</th>
    <th>Question</th>
    <th>Action</th>
</tr>

<%
List<Question> list = (List<Question>) request.getAttribute("questionList");
if (list != null && !list.isEmpty()) {
    for (Question q : list) {
%>
<tr>
    <td><%= q.getId() %></td>
    <td><%= q.getCategory() %></td>
    <td><%= q.getQuestionText() %></td>
    <td>
        <a class="action-btn"
           href="<%=request.getContextPath()%>/DeleteQuestionServlet?id=<%= q.getId() %>"
           onclick="return confirm('Delete this question?');">
           Delete
        </a>
    </td>
</tr>
<%
    }
} else {
%>
<tr>
    <td colspan="4" style="color:red;">No questions found</td>
</tr>
<%
}
%>
</table>
<div style="text-align:center; margin: 2rem 0;">
    <a class="back-btn"
       href="<%=request.getContextPath()%>/AdminDashboard.jsp">
       Back to Admin Dashboard
    </a>
</div>

</body>
</html>
