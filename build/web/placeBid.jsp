<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String freelancerName = (String) session.getAttribute("freelancerName");
    String freelancerEmail = (String) session.getAttribute("freelancerEmail");

    String projectId = request.getParameter("project_id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Place Bid</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(to right, #ecfdf5, #d1fae5);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bid-card {
        background: #fff;
        padding: 35px;
        border-radius: 20px;
        width: 100%;
        max-width: 500px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        animation: fadeIn 0.5s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    h3 {
        font-weight: 600;
        margin-bottom: 20px;
        color: #065f46;
    }

    .form-control {
        border-radius: 50px;
        padding: 12px 20px;
        margin-bottom: 15px;
    }

    textarea.form-control {
        border-radius: 15px;
    }

    .btn-submit {
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
        border-radius: 50px;
        padding: 12px;
        width: 100%;
        font-weight: 500;
        transition: 0.3s;
    }

    .btn-submit:hover {
        background: linear-gradient(45deg, #059669, #047857);
        transform: translateY(-2px);
    }

    .info-box {
        background: #ecfdf5;
        padding: 10px;
        border-radius: 10px;
        font-size: 0.9rem;
        color: #065f46;
        margin-bottom: 15px;
    }
</style>
</head>

<body>

<div class="bid-card">

    <h3>
        <i class="fas fa-gavel me-2"></i> Place Your Bid
    </h3>

    <div class="info-box">
        Submit your best price and proposal to win this project 🚀
    </div>

    <!-- Form -->
    <form action="placeBidAction.jsp" method="post">

        <input type="hidden" name="project_id" value="<%= projectId %>">
        <input type="hidden" name="freelancer_name" value="<%= freelancerName %>">

        <!-- Bid Amount -->
        <label><i class="fas fa-rupee-sign"></i> Bid Amount</label>
        <input type="number" name="bid_amount" class="form-control" 
               placeholder="Enter your bid amount" required>

        <!-- Proposal -->
        <label><i class="fas fa-align-left"></i> Proposal</label>
        <textarea name="proposal" class="form-control" rows="4"
                  placeholder="Describe your plan, experience, timeline..." required></textarea>

        <!-- Submit -->
        <button type="submit" class="btn btn-submit">
            <i class="fas fa-paper-plane me-2"></i> Submit Bid
        </button>

    </form>

</div>

</body>
</html>