<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,javax.servlet.http.*" %>

<%
   // HttpSession session1 = request.getSession(false);
    String freelancerEmail = (String) session.getAttribute("freelancerEmail");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assigned Projects</title>

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
        border-radius: 15px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.08);
    }

    .table thead {
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
    }

    .table tbody tr:hover {
        background-color: #f1f5f9;
    }

    .search-box {
        border-radius: 50px;
        padding: 10px 20px;
        border: 1px solid #ccc;
    }

    .status-badge {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 0.8rem;
    }

    .status-progress { background: #f59e0b; color: #fff; }
    .status-complete { background: #10b981; color: #fff; }
    .status-pending { background: #ef4444; color: #fff; }
</style>

<script>
    function searchProjects() {
        let input = document.getElementById("searchInput").value.toLowerCase();
        let rows = document.querySelectorAll("tbody tr");

        rows.forEach(row => {
            let text = row.innerText.toLowerCase();
            row.style.display = text.includes(input) ? "" : "none";
        });
    }
</script>

</head>

<body>

<div class="container-fluid">

    <div class="card p-4">
        <h4 class="mb-3"><i class="fas fa-briefcase me-2"></i> Assigned Projects</h4>

        <!-- Search -->
        <div class="mb-3">
            <input type="text" id="searchInput" onkeyup="searchProjects()" 
                   class="form-control search-box" placeholder="Search projects...">
        </div>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered align-middle text-center">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Project Title</th>
                        <th>Description</th>
                        <th>Client Name</th>
                        <th>Budget</th>
                        <th>Status</th>
                        <th>Deadline</th>
                    </tr>
                </thead>
                <tbody>

                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        PreparedStatement ps = con.prepareStatement(
                            "SELECT * FROM project WHERE femail=?"
                        );
                        ps.setString(1, freelancerEmail);

                        ResultSet rs = ps.executeQuery();

                        while(rs.next()){
                            String status = rs.getString("status");
                            String badgeClass = "status-pending";

                            if("In Progress".equalsIgnoreCase(status)){
                                badgeClass = "status-progress";
                            } else if("Completed".equalsIgnoreCase(status)){
                                badgeClass = "status-complete";
                            }
                %>
                    <tr>
                        <td><%= rs.getInt("project_id") %></td>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getString("description") %></td>
                        <td><%= rs.getString("user_name") %></td>
                        <td>₹ <%= rs.getString("budget") %></td>
                        <td>
                            <span class="status-badge <%= badgeClass %>">
                                <%= status %>
                            </span>
                        </td>
                        <td><%= rs.getString("deadline") %></td>
                    </tr>
                <%
                        }

                        rs.close();
                        ps.close();
                        con.close();

                    } catch(Exception e){
                        out.println("<tr><td colspan='7'>Error: "+e.getMessage()+"</td></tr>");
                    }
                %>

                </tbody>
            </table>
        </div>

    </div>

</div>

</body>
</html>