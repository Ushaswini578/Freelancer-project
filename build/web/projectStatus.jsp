<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,javax.servlet.http.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String userName = (String) session1.getAttribute("userName");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Project Status</title>

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
    }

    .table thead {
        background: linear-gradient(45deg, #3b82f6, #2563eb);
        color: #fff;
    }

    .table tbody tr:hover {
        background-color: #eef2ff;
    }

    .search-box {
        border-radius: 50px;
        padding: 10px 20px;
    }

    .status-badge {
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        color: #fff;
    }

    .pending { background: #ef4444; }
    .assigned { background: #f59e0b; }
    .progress { background: #3b82f6; }
    .completed { background: #10b981; }
</style>

<script>
function searchProjects(){
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

        <h4 class="mb-3">
            <i class="fas fa-tasks me-2"></i> Project Status
        </h4>

        <!-- Search -->
        <div class="mb-3">
            <input type="text" id="searchInput" onkeyup="searchProjects()" 
                   class="form-control search-box" placeholder="Search projects...">
        </div>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Freelancer</th>
                        <th>Budget</th>
                        <th>Status</th>
                        <th>Deadline</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        PreparedStatement ps = con.prepareStatement(
                            "SELECT * FROM project WHERE user_name=?"
                        );
                        ps.setString(1, userName);

                        ResultSet rs = ps.executeQuery();

                        while(rs.next()){
                            String status = rs.getString("status");
                            String badgeClass = "pending";

                            if("Assigned".equalsIgnoreCase(status)){
                                badgeClass = "assigned";
                            } else if("In Progress".equalsIgnoreCase(status)){
                                badgeClass = "progress";
                            } else if("Completed".equalsIgnoreCase(status)){
                                badgeClass = "completed";
                            }
                %>
                    <tr>
                        <td><%= rs.getInt("project_id") %></td>
                        <td><%= rs.getString("title") %></td>
                        <td>
                            <%= rs.getString("femail") == null ? "-" : rs.getString("femail") %>
                        </td>
                        <td>₹ <%= rs.getString("budget") %></td>
                        <td>
                            <span class="status-badge <%= badgeClass %>">
                                <%= status %>
                            </span>
                        </td>
                        <td><%= rs.getString("deadline") %></td>
                        <td>
                        <a href="viewBids.jsp?project_id=<%= rs.getInt("project_id") %>" class="btn btn-info">
                            <i class="fas fa-eye"></i> View Bids
                        </a>
                        </td>
                    </tr>
                <%
                        }

                        rs.close();
                        ps.close();
                        con.close();

                    } catch(Exception e){
                        out.println("<tr><td colspan='6'>Error: "+e.getMessage()+"</td></tr>");
                    }
                %>

                </tbody>
            </table>
        </div>

    </div>

</div>

</body>
</html>