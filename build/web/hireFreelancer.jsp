<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,javax.servlet.http.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String userName = (String) session1.getAttribute("userName");

    String freelancerId = request.getParameter("id");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    String freelancerName = "";
    String freelancerEmail = "";
    String freelancerSkill = "";

    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

        PreparedStatement ps = con.prepareStatement("SELECT * FROM freelancer WHERE freelancer_id=?");
        ps.setInt(1, Integer.parseInt(freelancerId));

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            freelancerName = rs.getString("name");
            freelancerEmail = rs.getString("email");
            freelancerSkill = rs.getString("skills");
        }

        rs.close();
        ps.close();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hire Freelancer</title>

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

    .title {
        font-weight: 600;
        margin-bottom: 20px;
    }

    .info-box {
        background: #eef2ff;
        padding: 15px;
        border-radius: 15px;
        margin-bottom: 20px;
    }

    .form-control, .form-select {
        border-radius: 50px;
        padding: 12px 20px;
        margin-bottom: 15px;
    }

    textarea.form-control {
        border-radius: 15px;
    }

    .btn-assign {
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
        border-radius: 50px;
        padding: 12px;
        width: 100%;
        font-weight: 600;
        transition: 0.3s;
    }

    .btn-assign:hover {
        background: linear-gradient(45deg, #059669, #047857);
    }
</style>

</head>

<body>

<div class="container">

    <div class="card">

        <h4 class="title">
            <i class="fas fa-handshake me-2"></i> Hire Freelancer
        </h4>

        <!-- Freelancer Info -->
        <div class="info-box">
            <p><strong>Name:</strong> <%= freelancerName %></p>
            <p><strong>Email:</strong> <%= freelancerEmail %></p>
            <p><strong>Skill:</strong> <%= freelancerSkill %></p>
        </div>

        <!-- Form -->
        <form action="hireFreelancerAction.jsp" method="post">

            <input type="hidden" name="freelancer_name" value="<%= freelancerName %>">
            <input type="hidden" name="femail" value="<%= freelancerEmail %>">
            <input type="hidden" name="user_name" value="<%= userName %>">

            <!-- Select Project -->
            <label>Select Project</label>
            <select name="project_id" class="form-select" required>
                <option value="">-- Select Your Project --</option>

                <%
                    PreparedStatement ps2 = con.prepareStatement(
                        "SELECT project_id, title FROM project WHERE user_name=? AND status='Pending'"
                    );
                    ps2.setString(1, userName);

                    ResultSet rs2 = ps2.executeQuery();

                    while(rs2.next()){
                %>
                    <option value="<%= rs2.getInt("project_id") %>">
                        <%= rs2.getString("title") %>
                    </option>
                <%
                    }
                    rs2.close();
                    ps2.close();
                %>

            </select>

            <!-- Message -->
            <label>Message (Optional)</label>
            <textarea name="message" class="form-control" rows="3"
                      placeholder="Write instructions or details..."></textarea>

            <!-- Submit -->
            <button type="submit" class="btn btn-assign">
                <i class="fas fa-paper-plane me-2"></i> Assign Project
            </button>

        </form>

    </div>

</div>

</body>
</html>

<%
        con.close();
    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>