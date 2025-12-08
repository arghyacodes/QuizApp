<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Add New Question</title>

<style>
  body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #f0f7ff, #dff3ff);
    margin: 0;
    padding: 0;
  }

  /* Header */
  header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 60px;
    background-color: #2196f3;
    color: white;
    display: flex;
    align-items: center;
    padding: 10px 25px;
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
    z-index: 1001;
  }

  header h2 {
    margin: 0;
    font-size: 20px;
    font-weight: 600;
  }

  /* Burger Menu */
  .burger {
    width: 25px;
    height: 18px;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    margin-right: 15px;
  }

  .burger div {
    height: 3px;
    background-color: white;
    border-radius: 2px;
  }

  /* Sidebar */
  nav.sidebar {
    position: fixed;
    top: 60px;
    left: -240px;
    width: 220px;
    height: calc(100vh - 60px);
    background-color: #ffffff;
    border-right: 1px solid #cfd8dc;
    box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
    transition: left 0.3s ease;
    z-index: 1000;
  }

  nav.sidebar.open {
    left: 0;
  }

  nav.sidebar button {
    background: none;
    border: none;
    color: #333;
    padding: 14px 20px;
    text-align: left;
    font-size: 15px;
    width: 100%;
    cursor: pointer;
    transition: background 0.2s, color 0.2s;
  }

  nav.sidebar button:hover {
    background-color: #e3f2fd;
    color: #0d47a1;
  }

  /* Main Content */
  main.content {
    padding: 100px 20px;
    max-width: 550px;
    margin: auto;
  }

  form {
    background: linear-gradient(145deg, #ffffff, #f6fbff);
    padding: 28px 32px;
    border-radius: 14px;
    box-shadow: 0 6px 12px rgba(33, 150, 243, 0.1);
    border-top: 5px solid #2196f3;
    animation: fadeIn 0.5s ease-in-out;
  }

  @keyframes fadeIn {
    from {opacity: 0; transform: translateY(15px);}
    to {opacity: 1; transform: translateY(0);}
  }

  label {
    font-weight: 600;
    color: #1a237e;
    margin-top: 12px;
    display: block;
  }

  input[type="text"],
  textarea,
  select {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border: 1px solid #b0bec5;
    border-radius: 6px;
    font-size: 14px;
    background-color: #f9fbff;
    transition: all 0.2s;
  }

  input[type="text"]:focus,
  textarea:focus,
  select:focus {
    border-color: #2196f3;
    box-shadow: 0 0 6px rgba(33,150,243,0.4);
    outline: none;
  }

  input[type="submit"] {
    background-color: #2196f3;
    color: white;
    border: none;
    padding: 12px 18px;
    margin-top: 22px;
    cursor: pointer;
    border-radius: 6px;
    font-size: 15px;
    font-weight: 600;
    transition: 0.3s;
  }

  input[type="submit"]:hover {
    background-color: #1976d2;
    transform: scale(1.03);
  }

  a.back-link {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #1976d2;
    text-decoration: none;
    font-weight: 500;
  }

  a.back-link:hover {
    text-decoration: underline;
  }

  p.message {
    text-align: center;
    font-weight: 600;
    margin-bottom: 15px;
  }

  p.message.success {
    color: #2e7d32;
  }

  p.message.error {
    color: #c62828;
  }

  @media (max-width: 600px) {
    main.content {
      padding: 90px 10px;
    }

    form {
      padding: 22px;
    }

    input[type="submit"] {
      width: 100%;
    }
  }
</style>
</head>

<body>

  <header>
    <div class="burger" id="burger">
      <div></div>
      <div></div>
      <div></div>
    </div>
    <h2>🧠 Add New Quiz Question</h2>
  </header>

  <nav class="sidebar" id="sidebar">
    <button onclick="window.location.href='AdminDashboard.jsp'">🏠 Dashboard</button>
    <button onclick="window.location.href='AdminLogin.jsp'">🚪 Logout</button>
    <button onclick="window.location.href='/OnlineQuiz/QuestionListServlet'">📋 Question List</button>
  </nav>

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

    <form action="/OnlineQuiz/AddQuestionServlet" method="post">
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

      <input type="submit" value="✅ Add Question"/>
    </form>

    <a class="back-link" href="<%=request.getContextPath()%>/admin/AdminDashboard.jsp">← Back to Dashboard</a>
  </main>

  <script>
    const burger = document.getElementById('burger');
    const sidebar = document.getElementById('sidebar');

    burger.addEventListener('click', () => {
      sidebar.classList.toggle('open');
    });
  </script>

</body>
</html>