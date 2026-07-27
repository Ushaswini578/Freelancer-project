<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Freelancer Marketplace</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        /* Navbar */
        .navbar {
            padding: 1rem 2rem;
            background-color: #1f2937;
        }
        .navbar-brand, .navbar-nav .nav-link {
            color: #ffffff !important;
            font-weight: 500;
        }
        .navbar-brand:hover, .nav-link:hover {
            color: #fbbf24 !important;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1551836022-d5d88e9218df?auto=format&fit=crop&w=1470&q=80') center/cover no-repeat;
            color: #fff;
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .hero h1 {
            font-size: 3rem;
            font-weight: 700;
        }
        .hero p {
            font-size: 1.2rem;
            margin: 1rem 0 2rem 0;
        }

        /* Buttons */
        .btn-custom {
            background: #fbbf24;
            color: #1f2937;
            font-weight: 500;
            border-radius: 50px;
            padding: 10px 25px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background: #f59e0b;
            color: #fff;
        }

        /* Features Section */
        .feature-card {
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        .feature-card i {
            font-size: 2.5rem;
            color: #fbbf24;
            margin-bottom: 15px;
        }

        /* Footer */
        footer {
            background-color: #1f2937;
            color: #fff;
            padding: 2rem 0;
        }
        footer a {
            color: #fbbf24;
            text-decoration: none;
        }
        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">FreelancerHub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="userLogin.jsp">User Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="freelancerLogin.jsp">Freelancer Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="adminLogin.jsp">Admin Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero text-center">
        <div class="container">
            <h1>Connect, Hire, and Work with the Best Freelancers</h1>
            <p>Join our marketplace to find talented freelancers or showcase your skills.</p>
            <a href="userRegister.jsp" class="btn btn-custom me-3">Join as User</a>
            <a href="freelancerRegister.jsp" class="btn btn-outline-light">Join as Freelancer</a>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Our Features</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card p-4 text-center">
                        <i class="fas fa-user-tie"></i>
                        <h5 class="mt-3">Hire Freelancers</h5>
                        <p>Find skilled freelancers for your projects in various domains.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card p-4 text-center">
                        <i class="fas fa-briefcase"></i>
                        <h5 class="mt-3">Manage Projects</h5>
                        <p>Create, track, and manage all your projects efficiently.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card p-4 text-center">
                        <i class="fas fa-star"></i>
                        <h5 class="mt-3">Rate & Review</h5>
                        <p>Provide feedback to freelancers and maintain quality standards.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="text-center">
        <div class="container">
            <p>&copy; 2026 FreelancerHub. All Rights Reserved.</p>
            <div>
                <a href="#"><i class="fab fa-facebook-f me-3"></i></a>
                <a href="#"><i class="fab fa-twitter me-3"></i></a>
                <a href="#"><i class="fab fa-linkedin-in me-3"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>