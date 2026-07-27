<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String freelancerName = null;

    if(session1 != null){
        freelancerName = (String) session1.getAttribute("freelancerName");
    }

    if(freelancerName == null){
        response.sendRedirect("freelancerLogin.jsp?error=Please+login+first");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Freelancer Dashboard</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        overflow: hidden;
    }

    /* Sidebar */
    #sidebar {
        width: 250px;
        height: 100vh;
        background: linear-gradient(180deg, #064e3b, #022c22);
        color: #fff;
        position: fixed;
        padding-top: 20px;
    }

    #sidebar h3 {
        text-align: center;
        font-weight: 700;
        margin-bottom: 20px;
    }

    #sidebar .nav-link {
        color: #d1fae5;
        padding: 12px 20px;
        margin: 5px 10px;
        border-radius: 10px;
        transition: 0.3s;
        display: block;
    }

    #sidebar .nav-link:hover {
        background: #10b981;
        color: #fff;
    }

    /* Main content */
    #main-content {
        margin-left: 250px;
        padding: 20px;
    }

    /* Topbar */
    .topbar {
        background: #fff;
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    }

    .topbar h5 {
        margin: 0;
        font-weight: 600;
        color: #1f2937;
    }

    /* iframe */
    .iframe-container {
        width: 100%;
        height: 80vh;
        border: none;
        border-radius: 10px;
        background: #fff;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }

    /* Logout button */
    .logout-btn {
        background: #ef4444;
        color: #fff;
        border-radius: 50px;
        padding: 6px 15px;
        text-decoration: none;
        font-size: 0.9rem;
    }

    .logout-btn:hover {
        background: #dc2626;
        color: #fff;
    }
</style>
</head>

<body>

<!-- Sidebar -->
<div id="sidebar">
    <h3>Freelancer Panel</h3>

    <a href="freelancerHome.jsp" target="freelancerFrame" class="nav-link">
        <i class="fas fa-home me-2"></i> Home
    </a>
    <a href="viewAvailableProjects.jsp" target="freelancerFrame" class="nav-link">
        <i class="fa-solid fa-diagram-project me-2"></i> Available Projects
    </a>

    <a href="viewAssignedProjects.jsp" target="freelancerFrame" class="nav-link">
        <i class="fas fa-briefcase me-2"></i> Assigned Projects
    </a>

    <a href="updateWorkStatus.jsp" target="freelancerFrame" class="nav-link">
        <i class="fas fa-sync-alt me-2"></i> Update Work Status
    </a>

    <a href="viewPayments.jsp" target="freelancerFrame" class="nav-link">
        <i class="fas fa-wallet me-2"></i> Payments
    </a>

    <a href="freelancerLogout.jsp" class="nav-link text-danger mt-3">
        <i class="fas fa-sign-out-alt me-2"></i> Logout
    </a>
</div>

<!-- Main Content -->
<div id="main-content">

    <!-- Topbar -->
    <div class="topbar">
        <h5>Welcome, <%= freelancerName %> 👋</h5>
        <a href="freelancerLogout.jsp" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <!-- iframe -->
    <iframe name="freelancerFrame" class="iframe-container" src="freelancerHome.jsp"></iframe>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>