<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%
    
    String adminName = null;
   
        adminName = (String) session.getAttribute("adminName");
   
    if(adminName == null){
        response.sendRedirect("adminLogin.jsp?error=Please+login+first");
        return;
    }

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    String message = "";
    if(request.getParameter("assign") != null){
        String projectId = request.getParameter("projectId");
        String freelancerId = request.getParameter("freelancerId");

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
            PreparedStatement ps = con.prepareStatement("UPDATE project SET freelancer_id=?, status='Assigned' WHERE id=?");
            ps.setInt(1, Integer.parseInt(freelancerId));
            ps.setInt(2, Integer.parseInt(projectId));
            int i = ps.executeUpdate();
            if(i > 0){
                message = "Project assigned successfully!";
            } else {
                message = "Error assigning project!";
            }
            ps.close();
            con.close();
        } catch(Exception e){
            message = "Error: "+e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assign Project - Admin Dashboard</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Roboto', sans-serif;
        padding: 20px;
        background-color: #f4f6f9;
    }

    h3 {
        margin-bottom: 20px;
        font-weight: 600;
        color: #1f2937;
    }

    .form-container {
        background: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        max-width: 600px;
        margin: auto;
    }

    .form-label {
        font-weight: 500;
        color: #1f2937;
    }

    .btn-assign {
        background-color: #10b981;
        color: #fff;
        border-radius: 50px;
        padding: 10px 25px;
        font-weight: 600;
        transition: 0.3s;
    }
    .btn-assign:hover {
        background-color: #059669;
        color: #fff;
    }

    .message {
        margin-bottom: 20px;
        font-weight: 500;
        color: #ef4444;
    }
</style>
</head>
<body>

<div class="container-fluid">
    <h3>Assign Project</h3>

    <div class="form-container">
        <% if(!message.isEmpty()){ %>
            <div class="alert alert-info"><%= message %></div>
        <% } %>

        <form method="post">
            <div class="mb-3">
                <label class="form-label">Select Project</label>
                <select class="form-select" name="projectId" required>
                    <option value="">--Select Project--</option>
                    <%
                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery("SELECT project_id, title FROM project WHERE status='Pending'");
                            while(rs.next()){
                    %>
                        <option value="<%= rs.getInt("project_id") %>"><%= rs.getString("title") %></option>
                    <%
                            }
                            rs.close();
                            st.close();
                            con.close();
                        } catch(Exception e){
                            out.println("<option disabled>Error: "+e.getMessage()+"</option>");
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Select Freelancer</label>
                <select class="form-select" name="freelancerId" required>
                    <option value="">--Select Freelancer--</option>
                    <%
                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery("SELECT freelancer_id, name FROM freelancer WHERE status='Active'");
                            while(rs.next()){
                    %>
                        <option value="<%= rs.getInt("freelancer_id") %>"><%= rs.getString("name") %></option>
                    <%
                            }
                            rs.close();
                            st.close();
                            con.close();
                        } catch(Exception e){
                            out.println("<option disabled>Error: "+e.getMessage()+"</option>");
                        }
                    %>
                </select>
            </div>

            <button type="submit" name="assign" class="btn btn-assign"><i class="fas fa-tasks me-2"></i> Assign Project</button>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>