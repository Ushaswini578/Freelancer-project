<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,javax.servlet.http.*" %>

<%
    
    String freelancerEmail = (String) session.getAttribute("freelancerEmail");
    System.out.println("email"+freelancerEmail);

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Work Status</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f4f6f9;
        padding: 20px;
    }

    .card {
        border-radius: 20px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        padding: 25px;
    }

    .card-title {
        font-weight: 600;
        margin-bottom: 20px;
    }

    .form-control, .form-select {
        border-radius: 50px;
        padding: 12px 20px;
        margin-bottom: 15px;
    }

    .form-control:focus, .form-select:focus {
        border-color: #10b981;
        box-shadow: none;
    }

    .btn-update {
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
        border-radius: 50px;
        padding: 12px;
        width: 100%;
        font-weight: 600;
        transition: 0.3s;
    }

    .btn-update:hover {
        background: linear-gradient(45deg, #059669, #047857);
    }
</style>

</head>

<body>

<div class="container">

    <div class="card">
        <h4 class="card-title">
            <i class="fas fa-sync-alt me-2"></i> Update Work Status
        </h4>

        <!-- Form -->
        <form action="updateWorkStatusAction.jsp" method="post">

            <!-- Project Dropdown -->
            <label>Select Project</label>
            <select name="project_id" class="form-select" required>
                <option value="">-- Select Project --</option>

                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        PreparedStatement ps = con.prepareStatement(
                            "SELECT project_id, title FROM project WHERE femail=?"
                        );
                        ps.setString(1, freelancerEmail);

                        ResultSet rs = ps.executeQuery();

                        while(rs.next()){
                %>
                    <option value="<%= rs.getInt("project_id") %>">
                        <%= rs.getString("title") %>
                    </option>
                <%
                        }

                        rs.close();
                        ps.close();
                        con.close();
                    } catch(Exception e){
                        out.println("<option>Error loading projects</option>");
                    }
                %>

            </select>

            <!-- Status -->
            <label>Status</label>
            <select name="status" class="form-select" required>
                <option value="">-- Select Status --</option>
                <option>Pending</option>
                <option>In Progress</option>
                <option>Completed</option>
            </select>

            <!-- Notes -->
            <label>Work Notes / Description</label>
            <textarea name="notes" class="form-control" rows="4" 
                      placeholder="Enter work update details..." required></textarea>

            <!-- Submit -->
            <button type="submit" class="btn btn-update">
                <i class="fas fa-save me-2"></i> Update Status
            </button>

        </form>

    </div>

</div>

</body>
</html>