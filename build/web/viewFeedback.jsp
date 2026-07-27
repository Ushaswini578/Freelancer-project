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
<title>View Feedback - Admin Dashboard</title>

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

    .badge-status {
        font-size: 0.9rem;
        border-radius: 50px;
        padding: 5px 10px;
    }

    .badge-positive { background-color: #10b981; color: #fff; }
    .badge-neutral { background-color: #fbbf24; color: #1f2937; }
    .badge-negative { background-color: #ef4444; color: #fff; }
</style>

<script>
    function searchFeedback() {
        let input = document.getElementById('searchInput');
        let filter = input.value.toLowerCase();
        let table = document.getElementById('feedbackTable');
        let trs = table.getElementsByTagName('tr');

        for (let i = 1; i < trs.length; i++) {
            let td = trs[i].getElementsByTagName('td')[2]; // Feedback column
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
    <h3>View Feedback</h3>

    <!-- Search Bar -->
    <div class="search-bar mb-3">
        <input type="text" id="searchInput" class="form-control" placeholder="Search Feedback..." onkeyup="searchFeedback()">
    </div>

    <!-- Feedback Table -->
    <div class="table-responsive">
        <table class="table table-hover" id="feedbackTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Feedback</th>
                    <th>Freelancer / Project</th>
                    <th>Rating</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT f.feedback_id, u.name AS user_name, f.comments , freelancer_id, f.rating FROM feedback f JOIN user u ON f.user_id = u.user_id ORDER BY f.feedback_id DESC");

                    while(rs.next()){
                        String rating = rs.getString("rating");
                        String badgeClass = "badge-neutral";
                        if("Positive".equalsIgnoreCase(rating)) badgeClass="badge-positive";
                        else if("Negative".equalsIgnoreCase(rating)) badgeClass="badge-negative";
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("user_name") %></td>
                    <td><%= rs.getString("feedback_text") %></td>
                    <td><%= rs.getString("target_name") %></td>
                    <td><span class="badge badge-status <%= badgeClass %>"><%= rating %></span></td>
                    <td><%= rs.getDate("date") %></td>
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