<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - FreelancerHub</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1f2937, #111827);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }
        .login-card {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-card h2 {
            margin-bottom: 25px;
            font-weight: bold;
        }
        .form-control {
            border-radius: 50px;
            padding: 10px 20px;
        }
        .btn-custom {
            background: #fbbf24;
            color: #1f2937;
            font-weight: 500;
            border-radius: 50px;
            padding: 10px 25px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background: #f59e0b;
            color: #fff;
        }
        .error-msg {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <h2>Admin Login</h2>

        <!-- Login Form -->
        <form action="adminLoginaction.jsp" method="post">
            <input type="text" name="username" placeholder="Username" class="form-control mb-3" required>
            <input type="password" name="password" placeholder="Password" class="form-control mb-3" required>
            <button type="submit" class="btn btn-custom w-100">Login</button>
        </form>
    </div>

</body>
</html>