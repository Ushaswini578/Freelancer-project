<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    HttpSession session1 = request.getSession(false);
    String userName = null;

    if(session1 != null){
        userName = (String) session1.getAttribute("userName");
    }

    if(userName == null){
        response.sendRedirect("userLogin.jsp?error=Please+login+first");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard - FreelancerHub</title>

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
        background: linear-gradient(180deg, #0f172a, #1e293b);
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
        color: #cbd5e1;
        padding: 12px 20px;
        margin: 5px 10px;
        border-radius: 10px;
        transition: 0.3s;
        display: block;
    }

    #sidebar .nav-link:hover {
        background: #3b82f6;
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
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        background: #fff;
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
    <h3>User Panel</h3>

    <a href="userHome.jsp" target="userFrame" class="nav-link">
        <i class="fas fa-home me-2"></i> Home
    </a>

    <a href="postProject.jsp" target="userFrame" class="nav-link">
        <i class="fas fa-plus-circle me-2"></i> Post Project
    </a>
<!--    <a href="viewBids.jsp" target="userFrame" class="nav-link">
        <i class="fa-solid fa-chess-bishop me-2"></i> View Bids
    </a>-->
    <a href="viewFreelancers.jsp" target="userFrame" class="nav-link">
        <i class="fas fa-user-tie me-2"></i> View Freelancers
    </a>

    <a href="projectStatus.jsp" target="userFrame" class="nav-link">
        <i class="fas fa-tasks me-2"></i> Project Status
    </a>

    <a href="giveFeedback.jsp" target="userFrame" class="nav-link">
        <i class="fas fa-star me-2"></i> Give Feedback
    </a>

    <a href="userLogout.jsp" class="nav-link text-danger mt-3">
        <i class="fas fa-sign-out-alt me-2"></i> Logout
    </a>
</div>

<!-- Main Content -->
<div id="main-content">

    <!-- Topbar -->
    <div class="topbar">
        <h5>Welcome, <%= userName %> 👋</h5>
        <a href="userLogout.jsp" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <!-- iframe -->
    <iframe name="userFrame" class="iframe-container" src="userHome.jsp"></iframe>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>