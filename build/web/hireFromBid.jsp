<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="Mail.MailSender"%>

<%
    HttpSession session1 = request.getSession(false);

    // ✅ Session Check
    if(session1 == null || session1.getAttribute("userName") == null){
%>
<script>
    window.location.href="userLogin.jsp";
</script>
<%
        return;
    }

    String userName = (String) session1.getAttribute("userName");

    // ✅ Get bid_id
    String bidIdStr = request.getParameter("bid_id");

    if(bidIdStr == null || bidIdStr.trim().equals("")){
%>
    <h3 style="color:red;text-align:center;">❌ Invalid Bid ID</h3>
<%
        return;
    }

    int bidId = 0;
    try{
        bidId = Integer.parseInt(bidIdStr);
    }catch(Exception e){
%>
    <h3 style="color:red;text-align:center;">❌ Invalid Bid ID Format</h3>
<%
        return;
    }

    String dbURL = "jdbc:mysql://localhost:3306/freelancer";
    String dbUser = "root";
    String dbPass = "root";

    boolean success = false;
    String freelancerName = "";
    int projectId = 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hire Freelancer</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #10b981, #059669);
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.card-box {
    background: #fff;
    padding: 40px;
    border-radius: 20px;
    text-align: center;
    width: 100%;
    max-width: 450px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

.success-icon {
    font-size: 3rem;
    color: #10b981;
    margin-bottom: 15px;
}

.btn-back {
    margin-top: 20px;
    padding: 12px;
    border-radius: 50px;
    width: 100%;
    background: linear-gradient(45deg, #10b981, #059669);
    color: #fff;
    text-decoration: none;
}
</style>

<script>
function redirectPage(){
    setTimeout(function(){
        window.location.href="projectStatus.jsp";
    }, 3000);
}
</script>

</head>

<body onload="redirectPage()">

<div class="card-box">

<%
    String femail = null;
    
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

    // ✅ Get bid details
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT * FROM bids WHERE id=?"
    );
    ps1.setInt(1, bidId);
    ResultSet rs1 = ps1.executeQuery();

    if(rs1.next()){
        freelancerName = rs1.getString("freelancer_name");
        projectId = rs1.getInt("project_id");
        femail = rs1.getString("femail");
    }

    // ✅ Assign freelancer to project
    PreparedStatement ps2 = con.prepareStatement(
        "UPDATE project SET femail=?, status='Assigned' WHERE project_id=?"
    );
    ps2.setString(1, femail);
    ps2.setInt(2, projectId);
    ps2.executeUpdate();
    
    String msg = "You Hired by "+userName+"\n Assigned Project ID:"+projectId;
    
    //msg = "You Loose Auction the Vehicle Number:"+vno;
        MailSender email = new MailSender();
        Boolean flag = email.sendMail(femail,"Project Assigned",msg);
        if(flag)
        {
            System.out.println("Email Sent");
        }
    
    // ✅ Update selected bid → Hired
    PreparedStatement ps3 = con.prepareStatement(
        "UPDATE bids SET status='Hired' WHERE id=?"
    );
    ps3.setInt(1, bidId);
    ps3.executeUpdate();

    // ✅ Reject other bids
    PreparedStatement ps4 = con.prepareStatement(
        "UPDATE bids SET status='Rejected' WHERE project_id=? AND id!=?"
    );
    ps4.setInt(1, projectId);
    ps4.setInt(2, bidId);
    ps4.executeUpdate();

    success = true;

    rs1.close();
    ps1.close();
    ps2.close();
    ps3.close();
    ps4.close();
    con.close();

}catch(Exception e){
    e.printStackTrace();
%>

    <div style="color:red;">
        ❌ Error: <%= e.toString() %>
    </div>

<%
}
%>

<% if(success){ %>

    <div class="success-icon">
        <i class="fas fa-check-circle"></i>
    </div>

    <h3>Freelancer Hired Successfully!</h3>

    <p>
        <strong><%= freelancerName %></strong> has been assigned to the project.
    </p>

    <p>Redirecting to dashboard...</p>

    <a href="projectStatus.jsp" class="btn-back">Go Back</a>

<% } %>

</div>

</body>
</html>