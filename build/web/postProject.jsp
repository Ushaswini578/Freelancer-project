<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String userName = (String) session1.getAttribute("userName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Post Project</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f4f6f9;
        padding: 20px;
    }

    .form-card {
        background: #ffffff;
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    }

    .form-title {
        font-weight: 600;
        margin-bottom: 20px;
        color: #1f2937;
    }

    .form-control, .form-select {
        border-radius: 50px;
        padding: 12px 20px;
        margin-bottom: 15px;
    }

    .form-control:focus, .form-select:focus {
        border-color: #3b82f6;
        box-shadow: none;
    }

    textarea.form-control {
        border-radius: 15px;
    }

    .btn-submit {
        background: linear-gradient(45deg, #3b82f6, #2563eb);
        color: #fff;
        border-radius: 50px;
        padding: 12px;
        width: 100%;
        font-weight: 600;
        transition: 0.3s;
    }

    .btn-submit:hover {
        background: linear-gradient(45deg, #2563eb, #1d4ed8);
    }
</style>
</head>

<body>

<div class="container">

    <div class="form-card">

        <h4 class="form-title">
            <i class="fas fa-plus-circle me-2"></i> Post New Project
        </h4>

        <!-- Form -->
        <form action="postProjectAction.jsp" method="post">

            <input type="hidden" name="user_name" value="<%= userName %>">

            <!-- Project Title -->
            <label>Project Title</label>
            <input type="text" name="title" class="form-control" placeholder="Enter project title" required>

            <!-- Description -->
            <label>Project Description</label>
            <textarea name="description" class="form-control" rows="4" 
                      placeholder="Describe your project..." required></textarea>

            <!-- Budget -->
            <label>Budget (₹)</label>
            <input type="number" name="budget" class="form-control" placeholder="Enter budget" required>

            <!-- Category -->
            <label>Category</label>
            <select name="category" class="form-select" required>
                <option value="">-- Select Category --</option>
                <option>Web Development</option>
                <option>Mobile App Development</option>
                <option>UI/UX Design</option>
                <option>Data Science</option>
                <option>Machine Learning</option>
                <option>Other</option>
            </select>

            <!-- Deadline -->
            <label>Deadline</label>
            <input type="date" name="deadline" class="form-control" required>

            <!-- Submit -->
            <button type="submit" class="btn btn-submit">
                <i class="fas fa-paper-plane me-2"></i> Submit Project
            </button>

        </form>

    </div>

</div>

</body>
</html>