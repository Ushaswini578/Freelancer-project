<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    boolean success = false;
    String message = "";
    String freelancerName = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM freelancer WHERE email=? AND password=? AND status='Approved'"
        );
        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            success = true;
            freelancerName = rs.getString("name");
            message = "Login Successful!";

            // Create session
            HttpSession session1 = request.getSession();
            session1.setAttribute("freelancerName", freelancerName);
            session1.setAttribute("freelancerEmail", email);
        } else {
            message = "Invalid Email or Password!";
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
<title>Freelancer Login Status</title>

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
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
        border: none;
        text-decoration: none;
        transition: 0.3s;
    }

    .btn-custom:hover {
        background: linear-gradient(45deg, #059669, #047857);
        color: #fff;
    }

    .loader {
        border: 5px solid #f3f3f3;
        border-top: 5px solid #10b981;
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
</style>

<script>
    <% if(success){ %>
        setTimeout(function(){
            window.location.href = "freelancerDashboard.jsp";
        }, 2500);
    <% } %>
</script>

</head>
<body>

<div class="status-card">

    <% if(success){ %>
        <div class="status-icon success">
            <i class="fas fa-check-circle"></i>
        </div>
        <h3 class="success">Welcome, <%= freelancerName %>!</h3>
        <p><%= message %></p>
        <div class="loader"></div>
        <p>Redirecting to dashboard...</p>
        <a href="freelancerDashboard.jsp" class="btn btn-custom">Go to Dashboard</a>

    <% } else { %>
        <div class="status-icon error">
            <i class="fas fa-times-circle"></i>
        </div>
        <h3 class="error">Login Failed</h3>
        <p><%= message %></p>
        <a href="freelancerLogin.jsp" class="btn btn-custom">Try Again</a>
    <% } %>

</div>

</body>
</html>