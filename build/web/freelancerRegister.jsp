<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Freelancer Register - FreelancerHub</title>

    <!-- Bootstrap -->
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
            max-width: 520px;
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
            color: #10b981;
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

        .form-control, .form-select {
            border-radius: 50px;
            padding: 12px 20px;
            margin-bottom: 15px;
        }

        .form-control:focus, .form-select:focus {
            border-color: #10b981;
            box-shadow: none;
        }

        .btn-register {
            background: linear-gradient(45deg, #10b981, #059669);
            color: #fff;
            border-radius: 50px;
            padding: 12px;
            width: 100%;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-register:hover {
            background: linear-gradient(45deg, #059669, #047857);
        }

        .extra-links {
            margin-top: 15px;
            font-size: 0.9rem;
        }

        .extra-links a {
            color: #10b981;
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

        <h2>Freelancer Registration</h2>
        <p>Create your freelancer account and start earning</p>

        <!-- Messages -->
        <%
            String msg = request.getParameter("msg");
            if("success".equals(msg)){
        %>
            <div class="success-msg">
                <i class="fas fa-check-circle"></i> Registration Successful!
            </div>
        <%
            } else if("error".equals(msg)){
        %>
            <div class="error-msg">
                <i class="fas fa-exclamation-circle"></i> Registration Failed!
            </div>
        <%
            }
        %>

        <!-- Registration Form -->
        <form action="freelancerRegisterAction.jsp" method="post">
            <input type="text" name="name" class="form-control" placeholder="Full Name" required>
            <input type="email" name="email" class="form-control" placeholder="Email Address" required>
            <input type="password" name="password" class="form-control" placeholder="Password" required>
            <input type="text" name="phone" class="form-control" placeholder="Phone Number" required>

            <input type="text" name="skills" class="form-control" placeholder="Skills (e.g., Java, Web Design)" required>

            <select name="experience" class="form-select" required>
                <option value="">Select Experience</option>
                <option>Fresher</option>
                <option>1-2 Years</option>
                <option>3-5 Years</option>
                <option>5+ Years</option>
            </select>

            <button type="submit" class="btn btn-register">
                <i class="fas fa-user-plus me-2"></i> Register
            </button>
        </form>

        <div class="extra-links">
            <p>Already have an account? <a href="freelancerLogin.jsp">Login</a></p>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>