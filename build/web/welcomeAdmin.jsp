<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%

        String adminName = (String) session.getAttribute("adminName");
    
    if(adminName == null){
        response.sendRedirect("adminLogin.jsp?error=Please+login+first");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard Welcome - FreelancerHub</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Roboto', sans-serif;
        background-color: #f4f6f9;
        padding: 20px;
    }

    .welcome-card {
        background: linear-gradient(135deg, #1f2937, #111827);
        color: #fff;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        text-align: center;
        margin-bottom: 30px;
    }

    .welcome-card h2 {
        font-weight: 700;
        margin-bottom: 10px;
    }

    .overview-section .card {
        border-radius: 15px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        transition: transform 0.3s, box-shadow 0.3s;
    }
    .overview-section .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 12px 25px rgba(0,0,0,0.2);
    }

    .overview-section .card i {
        font-size: 2.5rem;
        color: #fbbf24;
        margin-bottom: 10px;
    }

    .card-title {
        font-weight: 600;
        margin-bottom: 5px;
    }

    .card-text {
        font-size: 0.9rem;
        color: #555;
    }
</style>
</head>
<body>

<!-- Welcome Card -->
<div class="welcome-card">
    <h2>Welcome, <%= adminName %>!</h2>
    <p>Manage Freelancers, Users, Projects, and Feedback efficiently from your Admin Dashboard.</p>
</div>

<!-- Quick Overview Section -->
<div class="overview-section container">
    <div class="row g-4">
        <div class="col-md-3">
            <a href="manageFreelancers.jsp" target="dashboardFrame" style="text-decoration:none;">
                <div class="card text-center p-4">
                    <i class="fas fa-user-tie"></i>
                    <div class="card-body">
                        <h5 class="card-title">Freelancers</h5>
                        <p class="card-text">View, approve, or deactivate freelancers.</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="manageUsers.jsp" target="dashboardFrame" style="text-decoration:none;">
                <div class="card text-center p-4">
                    <i class="fas fa-users"></i>
                    <div class="card-body">
                        <h5 class="card-title">Users</h5>
                        <p class="card-text">Manage registered users and their projects.</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="viewProjects.jsp" target="dashboardFrame" style="text-decoration:none;">
                <div class="card text-center p-4">
                    <i class="fas fa-briefcase"></i>
                    <div class="card-body">
                        <h5 class="card-title">Projects</h5>
                        <p class="card-text">Monitor ongoing and completed projects.</p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="viewFeedback.jsp" target="dashboardFrame" style="text-decoration:none;">
                <div class="card text-center p-4">
                    <i class="fas fa-star"></i>
                    <div class="card-body">
                        <h5 class="card-title">Feedback</h5>
                        <p class="card-text">View ratings and comments for freelancers.</p>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>