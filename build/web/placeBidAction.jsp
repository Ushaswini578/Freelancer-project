<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String freelancerEmail = (String) session.getAttribute("freelancerEmail");
    String projectId = request.getParameter("project_id");
    String freelancerName = request.getParameter("freelancer_name");
    String bidAmount = request.getParameter("bid_amount");
    String proposal = request.getParameter("proposal");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    boolean success = false;
    String message = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO bids(project_id, freelancer_name, bid_amount, proposal,femail) VALUES(?,?,?,?,?)"
        );

        ps.setInt(1, Integer.parseInt(projectId));
        ps.setString(2, freelancerName);
        ps.setDouble(3, Double.parseDouble(bidAmount));
        ps.setString(4, proposal);
        ps.setString(5, freelancerEmail);

        int i = ps.executeUpdate();

        if(i > 0){
            success = true;
            message = "Your bid has been submitted successfully!";
        } else {
            message = "Failed to submit bid!";
        }

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
<title>Bid Status</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #10b981, #059669);
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

    .amount-box {
        background: #ecfdf5;
        padding: 10px;
        border-radius: 10px;
        font-weight: bold;
        margin-top: 10px;
        color: #065f46;
    }

    .btn-custom {
        margin-top: 20px;
        padding: 12px;
        border-radius: 50px;
        width: 100%;
        font-weight: 600;
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
        text-decoration: none;
        display: inline-block;
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
            window.location.href = "viewAvailableProjects.jsp";
        }, 3000);
    <% } %>
</script>

</head>
<body>

<div class="status-card">

    <% if(success){ %>
        <div class="status-icon success">
            <i class="fas fa-check-circle"></i>
        </div>

        <h3 class="success">Bid Submitted!</h3>
        <p><%= message %></p>

        <!-- Show Bid Amount -->
        <div class="amount-box">
            ₹ <%= bidAmount %>
        </div>

        <div class="loader"></div>
        <p>Redirecting to projects...</p>

        <a href="viewAvailableProjects.jsp" class="btn-custom">
            Back to Projects
        </a>

    <% } else { %>
        <div class="status-icon error">
            <i class="fas fa-times-circle"></i>
        </div>

        <h3 class="error">Error</h3>
        <p><%= message %></p>

        <a href="viewAvailableProjects.jsp" class="btn-custom">
            Try Again
        </a>
    <% } %>

</div>

</body>
</html>