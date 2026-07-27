<%@ page import="java.sql.*,javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Database connection
    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE username=? AND password=?");
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            // Login successful: create session
            
            session.setAttribute("adminName", username);

%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login Success</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { font-family: Arial, sans-serif; background: #1f2937; display:flex; justify-content:center; align-items:center; height:100vh; color:white; }
    .status-card { background: #fff; color: #1f2937; padding:40px; border-radius:20px; text-align:center; box-shadow:0 8px 20px rgba(0,0,0,0.3); }
    .btn-custom { background: #fbbf24; color: #1f2937; border-radius:50px; padding:10px 25px; font-weight:500; text-decoration:none; }
    .btn-custom:hover { background:#f59e0b; color:white; }
</style>
</head>
<body>
    <div class="status-card">
        <h2>Welcome, <%= username %>!</h2>
        <p>Login Successful. Redirecting to Dashboard...</p>
        <a href="adminDashboard.jsp" class="btn btn-custom mt-3">Go to Dashboard</a>
    </div>

    <script>
        // Auto redirect after 2 seconds
        setTimeout(function(){
            window.location.href = "adminDashboard.jsp";
        }, 2000);
    </script>
</body>
</html>
<%
        } else {
            // Login failed
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login Failed</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { font-family: Arial, sans-serif; background: #1f2937; display:flex; justify-content:center; align-items:center; height:100vh; color:white; }
    .status-card { background: #fff; color: #1f2937; padding:40px; border-radius:20px; text-align:center; box-shadow:0 8px 20px rgba(0,0,0,0.3); }
    .btn-custom { background: #fbbf24; color: #1f2937; border-radius:50px; padding:10px 25px; font-weight:500; text-decoration:none; }
    .btn-custom:hover { background:#f59e0b; color:white; }
</style>
</head>
<body>
    <div class="status-card">
        <h2>Login Failed!</h2>
        <p>Invalid username or password.</p>
        <a href="adminLogin.jsp" class="btn btn-custom mt-3">Try Again</a>
    </div>
</body>
</html>
<%
        }

        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
%>
<html>
<body>
<h3 style="color:red; text-align:center;">Server Error: <%= e.getMessage() %></h3>
</body>
</html>
<%
    }
%>