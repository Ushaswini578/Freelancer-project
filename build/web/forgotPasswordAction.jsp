<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String email = request.getParameter("email");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    boolean success = false;
    String message = "";
    String userPassword = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // You can change table name (users / freelancers / admin)
        PreparedStatement ps = con.prepareStatement(
            "SELECT password FROM freelancer WHERE email=?"
        );
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            success = true;
            userPassword = rs.getString("password");
            message = "Your password is: " + userPassword;
        } else {
            message = "Email not found!";
        }

        rs.close();
        ps.close();
        con.close();

    } catch(Exception e){
        message = "Error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Password Recovery</title>

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

    .status-card {
        background: #ffffff;
        padding: 40px;
        border-radius: 20px;
        text-align: center;
        max-width: 420px;
        width: 100%;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    }

    .status-icon {
        font-size: 3rem;
        margin-bottom: 15px;
    }

    .success { color: #10b981; }
    .error { color: #ef4444; }

    .btn-custom {
        margin-top: 20px;
        padding: 12px;
        border-radius: 50px;
        width: 100%;
        font-weight: 600;
        background: linear-gradient(45deg, #f59e0b, #d97706);
        color: #fff;
        border: none;
        text-decoration: none;
        transition: 0.3s;
    }

    .btn-custom:hover {
        background: linear-gradient(45deg, #d97706, #b45309);
        color: #fff;
    }

    .loader {
        border: 5px solid #f3f3f3;
        border-top: 5px solid #f59e0b;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        margin: 15px auto;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .password-box {
        background: #f1f5f9;
        padding: 10px;
        border-radius: 10px;
        font-weight: bold;
        margin-top: 10px;
    }
</style>

<script>
    <% if(success){ %>
        setTimeout(function(){
            window.location.href = "freelancerLogin.jsp";
        }, 4000);
    <% } %>
</script>

</head>
<body>

<div class="status-card">

    <% if(success){ %>
        <div class="status-icon success">
            <i class="fas fa-check-circle"></i>
        </div>
        <h3 class="success">Password Found!</h3>
        <p>We found your account details.</p>

        <div class="password-box">
            <%= userPassword %>
        </div>

        <div class="loader"></div>
        <p>Redirecting to login...</p>

        <a href="freelancerLogin.jsp" class="btn btn-custom">
            Go to Login
        </a>

    <% } else { %>
        <div class="status-icon error">
            <i class="fas fa-times-circle"></i>
        </div>
        <h3 class="error">Error</h3>
        <p><%= message %></p>

        <a href="forgotPassword.jsp" class="btn btn-custom">
            Try Again
        </a>
    <% } %>

</div>

</body>
</html>