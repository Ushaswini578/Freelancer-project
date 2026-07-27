<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - FreelancerHub</title>

    <!-- Bootstrap -->
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

        .forgot-container {
            width: 100%;
            max-width: 420px;
        }

        .forgot-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            text-align: center;
        }

        .forgot-icon {
            font-size: 3rem;
            color: #f59e0b;
            margin-bottom: 15px;
        }

        .forgot-card h2 {
            font-weight: 700;
            color: #1f2937;
        }

        .forgot-card p {
            color: #6b7280;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 50px;
            padding: 12px 20px;
            margin-bottom: 15px;
        }

        .form-control:focus {
            border-color: #f59e0b;
            box-shadow: none;
        }

        .btn-reset {
            background: linear-gradient(45deg, #f59e0b, #d97706);
            color: #fff;
            border-radius: 50px;
            padding: 12px;
            width: 100%;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-reset:hover {
            background: linear-gradient(45deg, #d97706, #b45309);
        }

        .extra-links {
            margin-top: 15px;
            font-size: 0.9rem;
        }

        .extra-links a {
            color: #f59e0b;
            text-decoration: none;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }

        .msg {
            margin-bottom: 10px;
            font-size: 0.9rem;
        }

        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>

<div class="forgot-container">
    <div class="forgot-card">

        <div class="forgot-icon">
            <i class="fas fa-key"></i>
        </div>

        <h2>Forgot Password</h2>
        <p>Enter your registered email to reset your password</p>

        <!-- Messages -->
        <%
            String msg = request.getParameter("msg");
            if("success".equals(msg)){
        %>
            <div class="msg success">
                <i class="fas fa-check-circle"></i> Reset link sent successfully!
            </div>
        <%
            } else if("error".equals(msg)){
        %>
            <div class="msg error">
                <i class="fas fa-exclamation-circle"></i> Email not found!
            </div>
        <%
            }
        %>

        <!-- Form -->
        <form action="forgotPasswordAction.jsp" method="post">
            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>

            <button type="submit" class="btn btn-reset">
                <i class="fas fa-paper-plane me-2"></i> Send Reset Link
            </button>
        </form>

        <div class="extra-links">
            <p><a href="freelancerLogin.jsp">Back to Login</a></p>
        </div>

    </div>
</div>

</body>
</html>