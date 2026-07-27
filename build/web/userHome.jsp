<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*,java.sql.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String userName = (String) session1.getAttribute("userName");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    int totalProjects = 0;
    int activeProjects = 0;
    int completedProjects = 0;

    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

        Statement st = con.createStatement();

        ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM project WHERE user_name='"+userName+"'");
        if(rs1.next()) totalProjects = rs1.getInt(1);

        ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM project WHERE user_name='"+userName+"' AND status='Assigned'");
        if(rs2.next()) activeProjects = rs2.getInt(1);

        ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM project WHERE user_name='"+userName+"' AND status='Completed'");
        if(rs3.next()) completedProjects = rs3.getInt(1);

        con.close();
    } catch(Exception e){
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Home</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f4f6f9;
        padding: 20px;
    }

    .welcome-box {
        background: linear-gradient(45deg, #3b82f6, #2563eb);
        color: #fff;
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 25px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    }

    .card-box {
        border-radius: 15px;
        padding: 20px;
        color: #fff;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        transition: 0.3s;
    }

    .card-box:hover {
        transform: translateY(-5px);
    }

    .bg1 { background: #10b981; }
    .bg2 { background: #f59e0b; }
    .bg3 { background: #ef4444; }

    .card-box i {
        font-size: 2rem;
        margin-bottom: 10px;
    }

    .card-box h4 {
        margin: 10px 0;
    }

    .quick-actions {
        margin-top: 30px;
    }

    .action-btn {
        border-radius: 50px;
        padding: 10px 20px;
        margin: 5px;
        font-weight: 500;
    }
</style>
</head>

<body>

<!-- Welcome Section -->
<div class="welcome-box">
    <h3>Welcome, <%= userName %> 👋</h3>
    <p>Manage your projects and collaborate with freelancers بسهولة.</p>
</div>

<!-- Stats Cards -->
<div class="row">
    <div class="col-md-4 mb-3">
        <div class="card-box bg1 text-center">
            <i class="fas fa-folder"></i>
            <h4><%= totalProjects %></h4>
            <p>Total Projects</p>
        </div>
    </div>

    <div class="col-md-4 mb-3">
        <div class="card-box bg2 text-center">
            <i class="fas fa-spinner"></i>
            <h4><%= activeProjects %></h4>
            <p>Active Projects</p>
        </div>
    </div>

    <div class="col-md-4 mb-3">
        <div class="card-box bg3 text-center">
            <i class="fas fa-check-circle"></i>
            <h4><%= completedProjects %></h4>
            <p>Completed Projects</p>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="quick-actions text-center">
    <h5 class="mb-3">Quick Actions</h5>

    <a href="postProject.jsp" target="userFrame" class="btn btn-primary action-btn">
        <i class="fas fa-plus me-2"></i> Post Project
    </a>
    
<!--    <a href="viewBids.jsp" target="userFrame" class="btn btn-primary action-btn">
        <i class="fas fa-plus me-2"></i> View Bids
    </a>-->

    <a href="viewFreelancers.jsp" target="userFrame" class="btn btn-success action-btn">
        <i class="fas fa-user-tie me-2"></i> Hire Freelancer
    </a>

    <a href="projectStatus.jsp" target="userFrame" class="btn btn-warning action-btn">
        <i class="fas fa-tasks me-2"></i> View Projects
    </a>

    <a href="giveFeedback.jsp" target="userFrame" class="btn btn-danger action-btn">
        <i class="fas fa-star me-2"></i> Give Feedback
    </a>
</div>

</body>
</html>