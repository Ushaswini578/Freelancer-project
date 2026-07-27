<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Register - FreelancerHub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-container {
            width: 100%;
            max-width: 500px;
        }

        .register-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            text-align: center;
        }

        .register-icon {
            font-size: 3rem;
            color: #3b82f6;
            margin-bottom: 15px;
        }

        .register-card h2 {
            font-weight: 700;
            color: #1f2937;
        }

        .register-card p {
            color: #6b7280;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 50px;
            padding: 12px 20px;
            margin-bottom: 15px;
        }

        .form-control:focus {
            border-color: #3b82f6;
            box-shadow: none;
        }

        .btn-register {
            background: linear-gradient(45deg, #3b82f6, #2563eb);
            color: #fff;
            border-radius: 50px;
            padding: 12px;
            width: 100%;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-register:hover {
            background: linear-gradient(45deg, #2563eb, #1d4ed8);
        }

        .extra-links {
            margin-top: 15px;
            font-size: 0.9rem;
        }

        .extra-links a {
            color: #3b82f6;
            text-decoration: none;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }

        .success-msg {
            color: green;
            margin-bottom: 10px;
        }

        .error-msg {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="register-container">
    <div class="register-card">

        <div class="register-icon">
            <i class="fas fa-user-plus"></i>
        </div>

        <h2>Create Account</h2>
        <p>Join FreelancerHub and start posting projects</p>

        <!-- Messages -->
        <%
            String msg = request.getParameter("msg");
            if("success".equals(msg)){
        %>
            <div class="success-msg"><i class="fas fa-check-circle"></i> Registration Successful!</div>
        <%
            } else if("error".equals(msg)){
        %>
            <div class="error-msg"><i class="fas fa-exclamation-circle"></i> Registration Failed!</div>
        <%
            }
        %>

        <!-- Registration Form -->
        <form action="userRegisterAction.jsp" method="post">
            <input type="text" name="name" class="form-control" placeholder="Full Name" required>
            <input type="email" name="email" class="form-control" placeholder="Email Address" required>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            <input type="text" name="phone" class="form-control" placeholder="Phone Number" required>

            <button type="submit" class="btn btn-register">
                <i class="fas fa-user-plus me-2"></i> Register
            </button>
        </form>

        <div class="extra-links">
            <p>Already have an account? <a href="userLogin.jsp">Login</a></p>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>