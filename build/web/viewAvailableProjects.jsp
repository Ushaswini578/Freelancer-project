<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String freelancerName = (String) session1.getAttribute("freelancerName");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Available Projects</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(to right, #f8fafc, #ecfdf5);
        padding: 20px;
    }

    .card {
        border-radius: 20px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        padding: 20px;
    }

    h4 {
        font-weight: 600;
        color: #065f46;
    }

    .table thead {
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
    }

    .table tbody tr:hover {
        background-color: #ecfdf5;
    }

    .search-box {
        border-radius: 50px;
        padding: 10px 20px;
    }

    .btn-bid {
        background: linear-gradient(45deg, #3b82f6, #2563eb);
        color: #fff;
        border-radius: 50px;
        padding: 5px 15px;
        font-weight: 500;
        transition: 0.3s;
    }

    .btn-bid:hover {
        transform: translateY(-2px);
    }

    .btn-secondary {
        border-radius: 50px;
        padding: 5px 15px;
        background: #9ca3af;
        color: #fff;
    }
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

    <div class="card">

        <h4 class="mb-3">
            <i class="fas fa-briefcase me-2"></i> Available Projects
        </h4>

        <!-- Search -->
        <input type="text" id="searchInput" onkeyup="searchProjects()" 
               class="form-control search-box mb-3" placeholder="Search projects...">

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-heading"></i> Title</th>
                        <th><i class="fas fa-align-left"></i> Description</th>
                        <th><i class="fas fa-rupee-sign"></i> Budget</th>
                        <th><i class="fas fa-calendar"></i> Deadline</th>
                        <th><i class="fas fa-gavel"></i> Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        PreparedStatement ps = con.prepareStatement(
                            "SELECT * FROM project WHERE status='Open'"
                        );

                        ResultSet rs = ps.executeQuery();

                        while(rs.next()){

                            int projectId = rs.getInt("project_id");

                            // Check if already bid
                            PreparedStatement checkPs = con.prepareStatement(
                                "SELECT bid_amount FROM bids WHERE project_id=? AND freelancer_name=?"
                            );
                            checkPs.setInt(1, projectId);
                            checkPs.setString(2, freelancerName);

                            ResultSet checkRs = checkPs.executeQuery();

                            boolean alreadyBid = false;
                            double userBid = 0;

                            if(checkRs.next()){
                                alreadyBid = true;
                                userBid = checkRs.getDouble("bid_amount");
                            }
                %>

                    <tr>
                        <td><%= projectId %></td>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getString("description") %></td>
                        <td>₹ <%= rs.getString("budget") %></td>
                        <td><%= rs.getString("deadline") %></td>

                        <td>
                            <% if(!alreadyBid){ %>

                                <a href="placeBid.jsp?project_id=<%= projectId %>" 
                                   class="btn btn-bid">
                                    <i class="fas fa-gavel me-1"></i> Bid
                                </a>

                            <% } else { %>

                                <button class="btn btn-secondary" disabled>
                                    ₹ <%= userBid %> (Bid Placed)
                                </button>

                            <% } %>
                        </td>
                    </tr>

                <%
                            checkRs.close();
                            checkPs.close();
                        }

                        rs.close();
                        ps.close();
                        con.close();

                    } catch(Exception e){
                %>
                    <tr>
                        <td colspan="6">Error: <%= e.getMessage() %></td>
                    </tr>
                <%
                    }
                %>

                </tbody>
            </table>
        </div>

    </div>

</div>

</body>
</html>