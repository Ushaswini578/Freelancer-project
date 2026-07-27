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
<title>Give Feedback</title>

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

    .form-control, .form-select {
        border-radius: 50px;
        padding: 12px 20px;
        margin-bottom: 15px;
    }

    textarea.form-control {
        border-radius: 15px;
    }

    .btn-submit {
        background: linear-gradient(45deg, #f59e0b, #d97706);
        color: #fff;
        border-radius: 50px;
        padding: 12px;
        width: 100%;
        font-weight: 600;
        transition: 0.3s;
    }

    .btn-submit:hover {
        background: linear-gradient(45deg, #d97706, #b45309);
    }

    .star-preview {
        font-size: 1.5rem;
        color: #f59e0b;
        margin-bottom: 10px;
    }
</style>

<script>
function showStars(value){
    let stars = "★".repeat(value) + "☆".repeat(5 - value);
    document.getElementById("starDisplay").innerHTML = stars;
}
</script>

</head>

<body>

<div class="container">

    <div class="card">

        <h4 class="title">
            <i class="fas fa-star me-2"></i> Give Feedback
        </h4>

        <!-- Form -->
        <form action="giveFeedbackAction.jsp" method="post">

            <input type="hidden" name="user_name" value="<%= userName %>">

            <!-- Select Project -->
            <label>Select Project</label>
            <select name="project_id" class="form-select" required>
                <option value="">-- Select Project --</option>

                <%
                    String email = null;
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        PreparedStatement ps = con.prepareStatement(
                            "SELECT project_id, title, femail FROM project WHERE user_name=? AND status='Completed'"
                        );
                        ps.setString(1, userName);

                        ResultSet rs = ps.executeQuery();

                        while(rs.next()){
                            email = rs.getString("femail");
                %>
                    <option value="<%= rs.getInt("project_id") %>">
                        <%= rs.getString("title") %>
                    </option>
                <%
                        }

                        rs.close();
                        ps.close();
                        con.close();

                    } catch(Exception e){
                        out.println("<option>Error loading projects</option>");
                    }
                %>

            </select>
            <!-- Select Project -->
            <label>Select Freelancer</label>
            <select name="femail" class="form-select" required>
                <option value="">-- Select Freelancer --</option>

                <%
                    
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                        PreparedStatement ps = con.prepareStatement(
                            "SELECT femail FROM project WHERE user_name=? AND status='Completed'"
                        );
                        ps.setString(1, userName);

                        ResultSet rs = ps.executeQuery();

                        while(rs.next()){
                            
                %>
                    <option value="<%= rs.getString("femail") %>">
                        <%= rs.getString("femail") %>
                    </option>
                <%
                        }

                        rs.close();
                        ps.close();
                        con.close();

                    } catch(Exception e){
                        out.println("<option>Error loading projects</option>");
                    }
                %>

            </select>
            
            <!-- Rating -->
            <label>Rating</label>
            <select name="rating" class="form-select" onchange="showStars(this.value)" required>
                <option value="">-- Select Rating --</option>
                <option value="1">1 Star</option>
                <option value="2">2 Stars</option>
                <option value="3">3 Stars</option>
                <option value="4">4 Stars</option>
                <option value="5">5 Stars</option>
            </select>

            <div id="starDisplay" class="star-preview"></div>

            <!-- Feedback -->
            <label>Feedback</label>
            <textarea name="feedback" class="form-control" rows="4"
                      placeholder="Write your feedback..." required></textarea>
            

            <!-- Submit -->
            <button type="submit" class="btn btn-submit">
                <i class="fas fa-paper-plane me-2"></i> Submit Feedback
            </button>

        </form>

    </div>

</div>

</body>
</html>