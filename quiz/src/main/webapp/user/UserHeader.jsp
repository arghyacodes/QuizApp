<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar">
    <div class="brand">Quiz Portal</div>
    <div class="burger" id="burger">&#9776;</div>
    <ul class="nav-links" id="nav-links">
        <li><a href="<%= request.getContextPath() %>/User/UserDashboard.jsp">Dashboard</a></li>
        <li><a href="<%= request.getContextPath() %>/User/Leaderboard.jsp">Leaderboard</a></li>
        <li><a href="<%= request.getContextPath() %>/User/User.jsp">Logout</a></li>
    </ul>
</div>

<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    background-color: #f8f9fa; /* light minimal background */
}

/* Navbar */
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #ffffff; /* clean white navbar */
    color: #495057;
    padding: 0.5rem 1rem;
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    border-bottom: 1px solid #dee2e6;
}

.navbar .brand {
    font-size: 1.5rem;
    font-weight: bold;
    color: #343a40;
}

.nav-links {
    list-style: none;
    display: flex;
    margin: 0;
    padding: 0;
}

.nav-links li {
    margin-left: 1rem;
}

.nav-links li a {
    color: #343a40; /* dark text */
    text-decoration: none;
    font-weight: bold;
    padding: 0.4rem 0.8rem;
    border: 2px solid #dc3545; /* red border */
    border-radius: 8px;
    transition: background 0.3s, color 0.3s, transform 0.2s;
}

.nav-links li a:hover {
    background-color: #dc3545; /* red background on hover */
    color: #ffffff; /* white text on hover */
    transform: scale(1.05);
}

/* Burger menu */
.burger {
    display: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: #495057;
}

/* Responsive */
@media (max-width: 768px) {
    .nav-links {
        display: none;
        flex-direction: column;
        background-color: #ffffff;
        position: absolute;
        top: 60px;
        right: 0;
        width: 200px;
        padding: 1rem;
        border-radius: 0 0 0 8px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    .nav-links li {
        margin: 0.5rem 0;
    }
    .burger {
        display: block;
    }
    .nav-links.active {
        display: flex;
    }
}
</style>

<script>
const burger = document.getElementById("burger");
const navLinks = document.getElementById("nav-links");
burger.addEventListener("click", () => {
    navLinks.classList.toggle("active");
});
</script>