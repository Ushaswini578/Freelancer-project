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
<title>View Freelancers</title>

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

    .btn-hire {
        border-radius: 50px;
        padding: 6px 15px;
        font-size: 0.9rem;
        background: #10b981;
        color: #fff;
    }

    .btn-hire:hover {
        background: #059669;
        color: #fff;
    }
</style>

<script>
function searchFreelancers(){
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
            <i class="fas fa-user-tie me-2"></i> Available Freelancers
        </h4>

        <!-- Search -->
        <div class="mb-3">
            <input type="text" id="searchInput" onkeyup="searchFreelancers()" 
                   class="form-control search-box" placeholder="Search freelancers...">
        </div>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Skill</th>
                        <th>Experience</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT * FROM freelancer");

                        while(rs.next()){
                %>
                    <tr>
                        <td><%= rs.getInt("freelancer_id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("skills") %></td>
                        <td><%= rs.getString("experience") %> Years</td>
                        <td>
                            <a href="hireFreelancer.jsp?id=<%= rs.getInt("freelancer_id") %>" 
                               target="userFrame" class="btn btn-hire">
                                <i class="fas fa-handshake me-1"></i> Hire
                            </a>
                        </td>
                    </tr>
                <%
                        }

                        rs.close();
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