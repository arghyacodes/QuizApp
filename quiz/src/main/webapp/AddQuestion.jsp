<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Add New Question</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/addquestion.css">
</head>

<body>

  <main class="content">
    <% 
      String success = request.getParameter("success");
      String error = request.getParameter("error");
      if (success != null) { 
    %>
      <p class="message success"><%= success %></p>
    <% } else if (error != null) { %>
      <p class="message error"><%= error %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/AddQuestionServlet" method="post">

      <h2 style="text-align:center; margin-bottom:15px;">Add New Quiz Question</h2>

      <label>Category:</label>
      <select name="category" required>
        <option value="">-- Select Category --</option>
        <option value="Java">Java</option> 
        <option value="Python">Python</option>
        <option value="Web Development">Web Development</option>
        <option value="Databases">Databases</option>
        <option value="Networking">Networking</option>
      </select>

      <label>Question Text:</label>
      <textarea name="questionText" rows="3" required></textarea>

      <label>Option A:</label>
      <input type="text" name="optionA" required/>

      <label>Option B:</label>
      <input type="text" name="optionB" required/>

      <label>Option C:</label>
      <input type="text" name="optionC" required/>

      <label>Option D:</label>
      <input type="text" name="optionD" required/>

      <label>Correct Option:</label>
      <select name="correctOption" required>
        <option value="">-- Select Correct Option --</option>
        <option value="A">Option A</option>
        <option value="B">Option B</option>
        <option value="C">Option C</option>
        <option value="D">Option D</option>
      </select>

      <input type="submit" value="Add Question"/>
    </form>

    <div class="back-wrapper">
        <a class="back-btn" href="<%=request.getContextPath()%>/AdminDashboard.jsp">
            Back to Admin Dashboard
        </a>
    </div>
  </main>

</body>
</html>
