<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - FreelancerHub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
        }

        .login-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            text-align: center;
        }

        .login-card h2 {
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 10px;
        }

        .login-card p {
            color: #6b7280;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 50px;
            padding: 12px 20px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #3b82f6;
        }

        .btn-login {
            background: linear-gradient(45deg, #3b82f6, #2563eb);
            color: #fff;
            border-radius: 50px;
            padding: 12px;
            width: 100%;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-login:hover {
            background: linear-gradient(45deg, #2563eb, #1d4ed8);
        }

        .login-icon {
            font-size: 3rem;
            color: #3b82f6;
            margin-bottom: 15px;
        }

        .extra-links {
            margin-top: 15px;
            font-size: 0.9rem;
        }

        .extra-links a {
            text-decoration: none;
            color: #3b82f6;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }

        .error-msg {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-card">
        
        <div class="login-icon">
            <i class="fas fa-user-circle"></i>
        </div>

        <h2>User Login</h2>
        <p>Access your account and manage your projects</p>

        <!-- Error Message -->
        <%
            String error = request.getParameter("error");
            if(error != null){
        %>
            <div class="error-msg"><i class="fas fa-exclamation-circle"></i> <%= error %></div>
        <%
            }
        %>

        <!-- Login Form -->
        <form action="userLoginAction.jsp" method="post">
            <input type="email" name="email" class="form-control" placeholder="Email Address" required>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            
            <button type="submit" class="btn btn-login">
                <i class="fas fa-sign-in-alt me-2"></i> Login
            </button>
        </form>

        <div class="extra-links">
            <p>Don't have an account? <a href="userRegister.jsp">Register</a></p>
            <p><a href="userForgotPassword.jsp">Forgot Password?</a></p>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>