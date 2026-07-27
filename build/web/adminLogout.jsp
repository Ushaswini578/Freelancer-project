<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Invalidate admin session
  

    // Redirect to login after 3 seconds
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Logging Out - Admin</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Roboto', sans-serif;
        background-color: #f4f6f9;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .logout-container {
        text-align: center;
        background: #fff;
        padding: 40px 50px;
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        max-width: 400px;
    }

    .logout-container h3 {
        margin-bottom: 20px;
        color: #1f2937;
        font-weight: 600;
    }

    .logout-container p {
        color: #6b7280;
        margin-bottom: 30px;
        font-size: 1rem;
    }

    .loader {
        border: 6px solid #f3f3f3;
        border-top: 6px solid #3b82f6;
        border-radius: 50%;
        width: 50px;
        height: 50px;
        margin: 0 auto 20px;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg);}
        100% { transform: rotate(360deg);}
    }

    .btn-login {
        background-color: #3b82f6;
        color: #fff;
        border-radius: 50px;
        padding: 10px 25px;
        font-weight: 600;
        text-decoration: none;
        transition: 0.3s;
    }

    .btn-login:hover {
        background-color: #2563eb;
        color: #fff;
    }
</style>

<script>
    // Redirect to login page after 3 seconds
    setTimeout(function(){
        window.location.href = "index.jsp";
    }, 3000);
</script>

</head>
<body>

<div class="logout-container">
    <div class="loader"></div>
    <h3>Logging Out...</h3>
    <p>You have successfully logged out. Redirecting to login page.</p>
    <a href="index.jsp" class="btn-login"><i class="fas fa-sign-in-alt me-2"></i> Go to Login</a>
</div>

</body>
</html>