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
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Users - Admin Dashboard</title>

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

    .search-bar {
        margin-bottom: 20px;
    }

    table {
        background: #fff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    }

    th, td {
        vertical-align: middle !important;
    }

    thead {
        background-color: #1f2937;
        color: #fff;
    }

    tbody tr:hover {
        background-color: #fbbf24;
        color: #1f2937;
        transition: 0.3s;
    }

    .btn-action {
        border-radius: 50px;
        padding: 5px 15px;
        font-size: 0.9rem;
    }

    .btn-view { background-color: #3b82f6; color: #fff; }
    .btn-view:hover { background-color: #2563eb; color: #fff; }

    .btn-activate { background-color: #10b981; color: #fff; }
    .btn-activate:hover { background-color: #059669; color: #fff; }

    .btn-deactivate { background-color: #ef4444; color: #fff; }
    .btn-deactivate:hover { background-color: #b91c1c; color: #fff; }
</style>

<script>
    function searchUser() {
        let input = document.getElementById('searchInput');
        let filter = input.value.toLowerCase();
        let table = document.getElementById('userTable');
        let trs = table.getElementsByTagName('tr');

        for (let i = 1; i < trs.length; i++) {
            let td = trs[i].getElementsByTagName('td')[1]; // User Name column
            if(td){
                let textValue = td.textContent || td.innerText;
                trs[i].style.display = textValue.toLowerCase().includes(filter) ? '' : 'none';
            }
        }
    }
</script>

</head>
<body>

<div class="container-fluid">
    <h3>Manage Users</h3>

    <!-- Search Bar -->
    <div class="search-bar mb-3">
        <input type="text" id="searchInput" class="form-control" placeholder="Search by User Name..." onkeyup="searchUser()">
    </div>

    <!-- Users Table -->
    <div class="table-responsive">
        <table class="table table-hover" id="userTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Registered On</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM user");

                    while(rs.next()){
            %>
                <tr>
                    <td><%= rs.getInt("user_id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getDate("registration_date") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td>
                        <!--<a href="viewUser.jsp?id=<%= rs.getInt("user_id") %>" target="dashboardFrame" class="btn btn-action btn-view"><i class="fas fa-eye"></i> View</a>-->
                        <a href="activateUserAction.jsp?id=<%= rs.getInt("user_id") %>&action=activate" target="dashboardFrame" class="btn btn-action btn-activate"><i class="fas fa-check"></i> Activate</a>
                        <a href="activateUserAction.jsp?id=<%= rs.getInt("user_id") %>&action=reject" target="dashboardFrame" class="btn btn-action btn-deactivate"><i class="fas fa-times"></i> Deactivate</a>
                    </td>
                </tr>
            <%
                    }
                    rs.close();
                    st.close();
                    con.close();
                } catch(Exception e){
                    out.println("<tr><td colspan='6' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>