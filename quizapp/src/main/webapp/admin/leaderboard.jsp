<%@ page import="java.sql.*, com.quiz.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leaderboard</title>

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 0;
        padding: 0;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        background: linear-gradient(135deg, #a1c4fd, #fbc2eb); /* Light Blue + Pink Gradient */
    }

    h2 {
        margin-top: 40px;
        color: #1e3c72;
        font-size: 2rem;
        text-align: center;
    }

    table {
        width: 90%;
        max-width: 900px;
        margin: 2rem auto;
        border-collapse: collapse;
        background-color: #ffffff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    }

    th, td {
        padding: 12px 15px;
        border-bottom: 1px solid #ddd;
        text-align: center;
        color: #2c3e50;
    }

    th {
        background-color: #42a5f5; /* Header color */
        color: white;
    }

    tr:hover {
        background-color: #f0f4ff;
    }

    .action-btn {
        display: inline-block;
        margin: 2rem 0;
        padding: 0.5rem 1rem;
        background-color: #42a5f5;
        color: white;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 600;
    }

    .action-btn:hover {
        background-color: #64b5f6;
    }

    @media (max-width: 768px) {
        th, td {
            padding: 8px 10px;
            font-size: 0.9rem;
        }
        h2 {
            font-size: 1.6rem;
        }
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
        <% } } catch(Exception e){ out.println("<tr><td colspan='4'>Error: "+e.getMessage()+"</td></tr>"); } %>
    </table>

    <a class="action-btn" href="AdminDashboard.jsp">Back to Dashboard</a>
</body>
</html>