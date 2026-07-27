<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*" %>

<%
    HttpSession session1 = request.getSession(false);

    // ✅ Session Validation
    if(session1 == null || session1.getAttribute("userName") == null){
%>
<script>
    window.location.href="userLogin.jsp";
</script>
<%
        return;
    }

    String userName = (String) session1.getAttribute("userName");

    // ✅ Get project_id
    String projectId = request.getParameter("project_id");

    if(projectId == null || projectId.trim().equals("")){
%>
    <h3 style="color:red;text-align:center;">❌ Invalid Project ID</h3>
<%
        return;
    }

    // ✅ Safe Parsing
    int pid = 0;
    try{
        pid = Integer.parseInt(projectId);
    }catch(Exception e){
%>
    <h3 style="color:red;text-align:center;">❌ Invalid Project ID Format</h3>
<%
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
<title>View Bids</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(to right, #eef2ff, #f0fdf4);
    padding: 20px;
}

.card {
    border-radius: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    padding: 20px;
}

h4 {
    font-weight: 600;
    color: #1e40af;
}

.table thead {
    background: linear-gradient(45deg, #3b82f6, #2563eb);
    color: #fff;
}

.lowest {
    background-color: #d1fae5 !important;
    font-weight: 600;
}

.btn-hire {
    background: linear-gradient(45deg, #10b981, #059669);
    color: #fff;
    border-radius: 50px;
    padding: 5px 15px;
}

.btn-hire:hover {
    transform: translateY(-2px);
}

.badge-lowest {
    background: #10b981;
    color: #fff;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 12px;
}
</style>

</head>

<body>

<div class="container">

<div class="card">

<h4 class="mb-3">
    <i class="fas fa-chart-line me-2"></i> Project Bids
</h4>

<div class="table-responsive">
<table class="table table-bordered text-center align-middle">

<thead>
<tr>
    <th>#</th>
    <th>Freelancer</th>
    <th>Bid Amount</th>
    <th>Proposal</th>
    <th>Status</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

    // ✅ Get Lowest Bid Safely
    Double lowestBid = null;

    PreparedStatement minPs = con.prepareStatement(
        "SELECT MIN(bid_amount) FROM bids WHERE project_id=?"
    );
    minPs.setInt(1, pid);
    ResultSet minRs = minPs.executeQuery();

    if(minRs.next()){
        lowestBid = minRs.getDouble(1);
        if(minRs.wasNull()){
            lowestBid = null;
        }
    }

    // ✅ Fetch All Bids
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM bids WHERE project_id=? ORDER BY bid_amount ASC"
    );
    ps.setInt(1, pid);

    ResultSet rs = ps.executeQuery();

    int count = 1;

    while(rs.next()){

        double bidAmount = rs.getDouble("bid_amount");

        boolean isLowest = (lowestBid != null && bidAmount == lowestBid);
%>

<tr class="<%= isLowest ? "lowest" : "" %>">
    <td><%= count++ %></td>
    <td><%= rs.getString("freelancer_name") %></td>

    <td>
        ₹ <%= bidAmount %>
        <% if(isLowest){ %>
            <span class="badge-lowest">Lowest</span>
        <% } %>
    </td>

    <td><%= rs.getString("proposal") %></td>
    <td><%= rs.getString("status") %></td>

    <td>
        <% if("Pending".equals(rs.getString("status"))){ %>

            <a href="hireFromBid.jsp?bid_id=<%= rs.getInt("id") %>" 
               class="btn btn-hire">
                <i class="fas fa-user-check"></i> Hire
            </a>

        <% } else { %>

            <button class="btn btn-secondary" disabled>
                <%= rs.getString("status") %>
            </button>

        <% } %>
    </td>
</tr>

<%
    }

    rs.close();
    ps.close();
    minRs.close();
    minPs.close();
    con.close();

}catch(Exception e){
    e.printStackTrace();
%>
<tr>
    <td colspan="6">Error: <%= e.toString() %></td>
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