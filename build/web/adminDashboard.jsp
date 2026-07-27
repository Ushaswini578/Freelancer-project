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
<title>Admin Dashboard - FreelancerHub</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Roboto', sans-serif;
        background-color: #f4f6f9;
        height: 100vh;
        overflow: hidden;
    }

    /* Sidebar */
    #sidebar {
        height: 100vh;
        background-color: #1f2937;
        color: #fff;
        padding-top: 20px;
        position: fixed;
        width: 250px;
        overflow-y: auto;
    }
    #sidebar .nav-link {
        color: #fff;
        font-weight: 500;
        margin: 5px 0;
    }
    #sidebar .nav-link:hover {
        background-color: #fbbf24;
        color: #1f2937;
        border-radius: 10px;
    }

    /* Main content */
    #main-content {
        margin-left: 250px;
        padding: 20px;
    }

    .iframe-container {
        width: 100%;
        height: 80vh;
        border: none;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }

    /* Topbar */
    .topbar {
        background-color: #fff;
        padding: 10px 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    }

    .topbar h4 {
        margin: 0;
        font-weight: 600;
        color: #1f2937;
    }
</style>
</head>
<body>

<!-- Sidebar -->
<div id="sidebar" class="d-flex flex-column">
    <h3 class="text-center mb-4">Admin Panel</h3>
    <nav class="nav flex-column px-3">
        <a class="nav-link" href="manageFreelancers.jsp" target="dashboardFrame"><i class="fas fa-user-tie me-2"></i>Manage Freelancers</a>
        <a class="nav-link" href="manageUsers.jsp" target="dashboardFrame"><i class="fas fa-users me-2"></i>Manage Users</a>
        <a class="nav-link" href="viewProjects.jsp" target="dashboardFrame"><i class="fas fa-briefcase me-2"></i>View Projects</a>
        <a class="nav-link" href="assignProject.jsp" target="dashboardFrame"><i class="fas fa-tasks me-2"></i>Assign Projects</a>
        <a class="nav-link" href="viewFeedback.jsp" target="dashboardFrame"><i class="fas fa-star me-2"></i>View Feedback</a>
        <a class="nav-link mt-3 text-danger" href="adminLogout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
    </nav>
</div>

<!-- Main Content -->
<div id="main-content">
    <div class="topbar">
        <h4>Welcome, <%= adminName %></h4>
        <span class="text-muted">FreelancerHub Admin Dashboard</span>
    </div>

    <!-- iframe for loading content -->
    <iframe name="dashboardFrame" class="iframe-container" src="welcomeAdmin.jsp"></iframe>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>