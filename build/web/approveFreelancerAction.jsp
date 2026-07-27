<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String id = request.getParameter("id");
    String action = request.getParameter("action");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    boolean success = false;
    String message = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String status = "";
        if("approve".equalsIgnoreCase(action)){
            status = "Approved";
        } else if("reject".equalsIgnoreCase(action)){
            status = "Rejected";
        }

        if(!status.equals("")){
            PreparedStatement ps = con.prepareStatement(
                "UPDATE freelancer SET status=? WHERE freelancer_id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(id));

            int rows = ps.executeUpdate();
            if(rows > 0){
                success = true;
                message = "Freelancer " + status + " successfully!";
            } else {
                message = "Error: Could not update freelancer.";
            }
            ps.close();
        } else {
            message = "Invalid action!";
        }

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
<title>Freelancer Status Update</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #1e3a8a, #2563eb);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .status-card {
        background: #fff;
        padding: 40px;
        border-radius: 20px;
        text-align: center;
        max-width: 450px;
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
        background: linear-gradient(45deg, #3b82f6, #2563eb);
        color: #fff;
        text-decoration: none;
        display: inline-block;
        transition: 0.3s;
    }

    .btn-custom:hover {
        background: linear-gradient(45deg, #2563eb, #1d4ed8);
        color: #fff;
    }

    .loader {
        border: 5px solid #f3f3f3;
        border-top: 5px solid #3b82f6;
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
    // Redirect to approveFreelancer.jsp after 3 seconds
    setTimeout(function(){
        window.location.href = "manageFreelancers.jsp";
    }, 3000);
</script>
</head>
<body>

<div class="status-card">

    <% if(success){ %>
        <div class="status-icon success">
            <i class="fas fa-check-circle"></i>
        </div>
        <h3 class="success">Success!</h3>
        <p><%= message %></p>
        <div class="loader"></div>
        <a href="manageFreelancers.jsp" class="btn-custom">
            Back to Freelancer Approvals
        </a>
    <% } else { %>
        <div class="status-icon error">
            <i class="fas fa-times-circle"></i>
        </div>
        <h3 class="error">Failed</h3>
        <p><%= message %></p>
        <a href="manageFreelancers.jsp" class="btn-custom">
            Try Again
        </a>
    <% } %>

</div>

</body>
</html>