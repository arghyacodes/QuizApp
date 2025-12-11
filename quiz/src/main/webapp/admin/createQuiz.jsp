<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dao.QuizDAO" %>
<%
    QuizDAO dao = new QuizDAO();
    List<String> categories = dao.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Quiz</title>

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        /* 🌈 Light Blue + Pink Gradient Background */
        background: linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 50%, #fbc2eb 100%);
        background-attachment: fixed;
    }

    .container {
        background: rgba(255, 255, 255, 0.9);
        padding: 40px 50px;
        border-radius: 16px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        width: 380px;
        text-align: center;
        backdrop-filter: blur(8px);
        animation: fadeIn 0.6s ease-in-out;
        position: relative;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    h2 {
        color: #0d47a1;
        margin-bottom: 20px;
        font-weight: 700;
    }

    .quiz-icon {
        font-size: 42px;
        color: #1565c0;
        margin-bottom: 10px;
        text-shadow: 0 2px 6px rgba(33,150,243,0.4);
    }

    label {
        display: block;
        margin-top: 12px;
        font-weight: 600;
        text-align: left;
        color: #1a237e;
    }

    input[type="text"], select {
        width: 100%;
        padding: 10px;
        margin-top: 6px;
        border: 1px solid #b0bec5;
        border-radius: 8px;
        font-size: 14px;
        background-color: rgba(255,255,255,0.95);
        transition: all 0.3s;
    }

    input[type="text"]:focus, select:focus {
        border-color: #42a5f5;
        box-shadow: 0 0 8px rgba(66,165,245,0.3);
        outline: none;
    }

    select {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        background-image: url("data:image/svg+xml;utf8,<svg fill='black' height='20' viewBox='0 0 24 24' width='20' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
        background-repeat: no-repeat;
        background-position-x: 98%;
        background-position-y: 10px;
    }

    button {
        margin-top: 25px;
        width: 100%;
        padding: 12px;
        background: linear-gradient(135deg, #f06292, #42a5f5);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: 0.3s ease;
    }

    button:hover {
        background: linear-gradient(135deg, #f48fb1, #64b5f6);
        transform: scale(1.03);
        box-shadow: 0 4px 10px rgba(66,165,245,0.4);
    }

    @media (max-width: 600px) {
        .container {
            width: 85%;
            padding: 25px 30px;
        }
    }
</style>
</head>

<body>
    <div class="container">
        <div class="quiz-icon">🧠</div>
        <h2>Create New Quiz</h2>

        <form action="../CreateQuizServlet" method="post">
            <label for="title">Quiz Title</label>
            <input type="text" id="title" name="title" placeholder="Enter quiz title" required>

            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="" disabled selected>--- Select Category ---</option>
                <%
                    for(String cat : categories) {
                %>
                    <option value="<%=cat%>"><%=cat%></option>
                <%
                    }
                %>
            </select>

            <button type="submit">Create Quiz</button>
        </form>
    </div>
</body>
</html>