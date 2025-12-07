<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success</title>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container {
        display: flex;
        align-items: center;
        background: rgba(255, 255, 255, 0.85);
        padding: 40px 50px;
        border-radius: 20px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        animation: fadeIn 0.8s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .text {
        font-size: 48px;
        font-weight: 700;
        color: #2c3e50;
        margin-right: 30px;
    }

    .image img {
        width: 120px;
        height: auto;
    }

    @media (max-width: 600px) {
        .container {
            flex-direction: column;
            text-align: center;
        }

        .text {
            margin-right: 0;
            margin-bottom: 20px;
            font-size: 36px;
        }

        .image img {
            width: 100px;
        }
    }
</style>
</head>
<body>

<div class="container">
    <div class="text">🎉 Created Successfully!</div>
    <div class="image">
        <img src="https://cdn-icons-png.flaticon.com/512/2278/2278992.png" alt="You Did It">
    </div>
</div>

</body>
</html>