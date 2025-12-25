<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar">
    <div class="brand">Quiz Portal</div>
    <div class="burger" id="burger">&#9776;</div>
    <ul class="nav-links" id="nav-links">
        <li><a href="<%= request.getContextPath() %>/userDashboard.jsp">Dashboard</a></li>
        <li><a href="<%= request.getContextPath() %>/userLeaderboard.jsp">Leaderboard</a></li>
        <li><a href="<%= request.getContextPath() %>/user.jsp">Logout</a></li>
    </ul>
</div>

<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
}

/* NAVBAR */
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: rgba(15, 32, 39, 0.95);
    color: #eaf6f6;
    padding: 0.7rem 1.2rem;
    box-shadow: 0 6px 18px rgba(0,0,0,0.4);
    position: sticky;
    top: 0;
    z-index: 1000;
}

/* BRAND */
.navbar .brand {
    font-size: 1.6rem;
    font-weight: 700;
    color: #2bb0a6;
    letter-spacing: 1px;
}

/* LINKS */
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
    color: #eaf6f6;
    text-decoration: none;
    font-weight: 600;
    padding: 0.45rem 0.9rem;
    border-radius: 8px;
    border: 2px solid transparent;
    transition: background 0.3s, color 0.3s, transform 0.2s, box-shadow 0.2s;
}

/* HOVER */
.nav-links li a:hover {
    background: linear-gradient(135deg, #2bb0a6, #208b83);
    color: #ffffff;
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(0,0,0,0.3);
}

/* BURGER */
.burger {
    display: none;
    font-size: 1.7rem;
    cursor: pointer;
    color: #eaf6f6;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .nav-links {
        display: none;
        flex-direction: column;
        background: rgba(32, 58, 67, 0.98);
        position: absolute;
        top: 60px;
        right: 12px;
        width: 210px;
        padding: 1rem;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.45);
    }

    .nav-links li {
        margin: 0.6rem 0;
    }

    .nav-links li a {
        text-align: center;
        width: 100%;
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