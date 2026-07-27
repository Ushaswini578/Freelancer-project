<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,javax.servlet.http.*" %>

<%
    HttpSession session1 = request.getSession(false);
    String freelancerName = (String) session1.getAttribute("freelancerName");
    String freelancerEmail = (String) session1.getAttribute("freelancerEmail");

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    double totalEarnings = 0;
    double pendingPayments = 0;
    double completedPayments = 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payments</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f4f6f9;
        padding: 20px;
    }

    .card-box {
        border-radius: 15px;
        padding: 20px;
        color: #fff;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        margin-bottom: 20px;
        transition: 0.3s;
    }

    .card-box:hover {
        transform: translateY(-5px);
    }

    .bg1 { background: #3b82f6; }
    .bg2 { background: #f59e0b; }
    .bg3 { background: #10b981; }

    .card-box i {
        font-size: 2rem;
    }

    .table thead {
        background: linear-gradient(45deg, #10b981, #059669);
        color: #fff;
    }

    .table tbody tr:hover {
        background-color: #f1f5f9;
    }

    .status-badge {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 0.8rem;
    }

    .paid { background: #10b981; color: #fff; }
    .pending { background: #f59e0b; color: #fff; }
</style>

</head>

<body>

<div class="container-fluid">

    <h4 class="mb-4"><i class="fas fa-wallet me-2"></i> Payment Overview</h4>

    <!-- Summary Cards -->
    <div class="row">

        <%
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                PreparedStatement ps = con.prepareStatement(
                    "SELECT amount, payment_status FROM payments WHERE freelancer_name=?"
                );
                ps.setString(1, freelancerName);

                ResultSet rs = ps.executeQuery();

                while(rs.next()){
                    double amount = rs.getDouble("amount");
                    totalEarnings += amount;

                    if("Paid".equalsIgnoreCase(rs.getString("payment_status"))){
                        completedPayments += amount;
                    } else {
                        pendingPayments += amount;
                    }
                }

                rs.close();
                ps.close();
        %>

        <div class="col-md-4">
            <div class="card-box bg1 text-center">
                <i class="fas fa-rupee-sign"></i>
                <h4>₹ <%= totalEarnings %></h4>
                <p>Total Earnings</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-box bg2 text-center">
                <i class="fas fa-hourglass-half"></i>
                <h4>₹ <%= pendingPayments %></h4>
                <p>Pending Payments</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-box bg3 text-center">
                <i class="fas fa-check-circle"></i>
                <h4>₹ <%= completedPayments %></h4>
                <p>Received Payments</p>
            </div>
        </div>

    </div>

    <!-- Payment Table -->
    <div class="card p-4 mt-3">
        <h5 class="mb-3"><i class="fas fa-list me-2"></i> Payment History</h5>

        <div class="table-responsive">
            <table class="table table-bordered text-center align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Project</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Payment Date</th>
                    </tr>
                </thead>
                <tbody>

                <%
                    PreparedStatement ps2 = con.prepareStatement(
                        "SELECT * FROM payments WHERE freelancer_name=?"
                    );
                    ps2.setString(1, freelancerName);

                    ResultSet rs2 = ps2.executeQuery();

                    while(rs2.next()){
                        String status = rs2.getString("payment_status");
                        String badgeClass = status.equalsIgnoreCase("Paid") ? "paid" : "pending";
                %>
                    <tr>
                        <td><%= rs2.getInt("id") %></td>
                        <td><%= rs2.getString("project_title") %></td>
                        <td>₹ <%= rs2.getDouble("amount") %></td>
                        <td>
                            <span class="status-badge <%= badgeClass %>">
                                <%= status %>
                            </span>
                        </td>
                        <td><%= rs2.getString("payment_date") %></td>
                    </tr>
                <%
                    }

                    rs2.close();
                    ps2.close();
                    con.close();

                } catch(Exception e){
                    out.println("<tr><td colspan='5'>Error: "+e.getMessage()+"</td></tr>");
                }
                %>

                </tbody>
            </table>
        </div>

    </div>

</div>

</body>
</html>