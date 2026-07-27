<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>

<%
    // Invalidate session
    HttpSession session1 = request.getSession(false);
    if(session1 != null){
        session1.invalidate();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Logging Out - User</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #0f172a, #1e293b);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .logout-card {
        background: #ffffff;
        padding: 40px;
        border-radius: 20px;
        text-align: center;
        max-width: 420px;
        width: 100%;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    }

    .logout-icon {
        font-size: 3rem;
        color: #ef4444;
        margin-bottom: 15px;
    }

    h3 {
        font-weight: 600;
        color: #1f2937;
    }

    p {
        color: #6b7280;
        margin-top: 10px;
    }

    .loader {
        border: 5px solid #f3f3f3;
        border-top: 5px solid #3b82f6;
        border-radius: 50%;
        width: 45px;
        height: 45px;
        margin: 20px auto;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .btn-login {
        margin-top: 10px;
        padding: 12px;
        width: 100%;
        border-radius: 50px;
        background: linear-gradient(45deg, #3b82f6, #2563eb);
        color: #fff;
        font-weight: 600;
        text-decoration: none;
        display: inline-block;
        transition: 0.3s;
    }

    .btn-login:hover {
        background: linear-gradient(45deg, #2563eb, #1d4ed8);
        color: #fff;
    }
</style>

<script>
    // Auto redirect after 3 seconds
    setTimeout(function(){
        window.location.href = "index.jsp";
    }, 3000);
</script>

</head>
<body>

<div class="logout-card">

    <div class="logout-icon">
        <i class="fas fa-sign-out-alt"></i>
    </div>

    <h3>Logging Out...</h3>
    <p>You have successfully logged out.</p>

    <div class="loader"></div>

    <p>Redirecting to login page...</p>

    <a href="index.jsp" class="btn-login">
        <i class="fas fa-sign-in-alt me-2"></i> Go to Login
    </a>

</div>

</body>
</html>