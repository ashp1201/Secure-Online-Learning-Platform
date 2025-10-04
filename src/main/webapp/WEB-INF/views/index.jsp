<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LearnHub - Online Learning Platform</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: #1f2937;
            background: #ffffff;
        }

        :root {
    --primary-color: #8b5cf6;      /* Violet */
    --primary-dark: #7c3aed;       /* Deep Purple */
    --primary-light: #a78bfa;      /* Light Purple */
    --secondary-color: #6d28d9;    /* Dark Violet */
    --accent-color: #ec4899;       /* Pink accent */
    --text-color: #1f2937;         /* Dark Gray */
    --text-light: #6b7280;         /* Medium Gray */
    --light-bg: #faf5ff;           /* Light Purple tint */
    --white: #ffffff;              /* Pure White */
    --gradient: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
    --shadow: 0 10px 25px rgba(139, 92, 246, 0.15);
    --shadow-hover: 0 15px 35px rgba(139, 92, 246, 0.25);
}

        /* Navigation */
        .navbar {
            background: var(--white);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            transition: all 0.3s ease;
            border-bottom: 2px solid var(--light-bg);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }

        .logo {
            font-size: 28px;
            font-weight: 800;
            color: var(--primary-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            font-size: 32px;
        }

        .auth-buttons {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .btn {
            padding: 12px 28px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .btn-primary {
            background: var(--gradient);
            color: white;
            border: 2px solid transparent;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        /* Hero Section */
        .hero {
            background: var(--white);
            padding: 120px 0 80px;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 50%;
            height: 100%;
            background: var(--light-bg);
            border-radius: 0 0 0 200px;
            z-index: 0;
        }

        .hero-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            position: relative;
            z-index: 2;
        }

        .hero-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }

        .hero-text h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.2;
            color: var(--text-color);
        }

        .hero-text h1 .highlight {
            color: var(--primary-color);
            position: relative;
        }

        .hero-text p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: var(--text-light);
            line-height: 1.8;
        }

        .hero-buttons {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .hero-image {
            text-align: center;
            position: relative;
        }

        .hero-illustration {
            width: 100%;
            max-width: 500px;
            height: auto;
            filter: drop-shadow(0 20px 40px rgba(16, 185, 129, 0.2));
        }

        /* Features Section */
        .features {
            padding: 80px 0;
            background: var(--light-bg);
        }

        .features-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .section-header {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-header h2 {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--text-color);
            margin-bottom: 15px;
        }

        .section-header p {
            font-size: 1.1rem;
            color: var(--text-light);
            max-width: 600px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
        }

        .feature-card {
            background: white;
            padding: 40px 30px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            border-color: var(--primary-color);
            box-shadow: var(--shadow);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: var(--gradient);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            color: white;
        }

        .feature-card h3 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--text-color);
        }

        .feature-card p {
            color: var(--text-light);
            line-height: 1.7;
        }

        /* Stats Section */
        .stats {
            padding: 80px 0;
            background: white;
        }

        .stats-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            text-align: center;
        }

        .stat-item {
            padding: 30px;
            background: var(--light-bg);
            border-radius: 15px;
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
        }

        .stat-item h3 {
            font-size: 3rem;
            font-weight: 800;
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .stat-item p {
            font-size: 1.1rem;
            color: var(--text-color);
            font-weight: 600;
        }

        /* Footer */
        .footer {
            background: var(--text-color);
            color: white;
            padding: 60px 0 30px;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }

        .footer-section h3 {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: white;
        }

        .footer-section p, .footer-section a {
            color: #9ca3af;
            text-decoration: none;
            line-height: 1.8;
            transition: color 0.3s ease;
        }

        .footer-section a:hover {
            color: var(--primary-color);
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .footer-bottom {
            border-top: 1px solid #374151;
            padding-top: 30px;
            text-align: center;
            color: #9ca3af;
        }

        .social-icons i {
            margin-right: 15px;
            font-size: 24px;
            color: var(--primary-color);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .social-icons i:hover {
            color: var(--primary-light);
            transform: translateY(-3px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero::before {
                display: none;
            }

            .auth-buttons {
                gap: 10px;
            }

            .btn {
                padding: 10px 20px;
                font-size: 14px;
            }

            .hero-content {
                grid-template-columns: 1fr;
                gap: 40px;
                text-align: center;
            }

            .hero-text h1 {
                font-size: 2.5rem;
            }

            .section-header h2 {
                font-size: 2rem;
            }

            .footer-content {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .stat-item h3 {
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            .hero-text h1 {
                font-size: 2rem;
            }

            .hero-buttons {
                flex-direction: column;
                align-items: stretch;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-in {
            animation: fadeInUp 0.6s ease forwards;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="#" class="logo">
                <i class="fas fa-graduation-cap"></i> LearnHub
            </a>

            <div class="auth-buttons">
                <a href="login" class="btn btn-outline">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
                <a href="register" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Register
                </a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="hero-container">
            <div class="hero-content">
                <div class="hero-text animate-fade-in">
                    <h1>Learn <span class="highlight">Without Limits</span></h1>
                    <p>Access world-class courses from expert instructors. Build new skills, advance your career, and achieve your learning goals with our comprehensive online learning platform.</p>
                    <div class="hero-buttons">
                        <a href="register" class="btn btn-primary btn-lg">
                            <i class="fas fa-rocket"></i> Start Learning
                        </a>
                        <a href="#features" class="btn btn-outline btn-lg">
                            <i class="fas fa-play-circle"></i> Explore Courses
                        </a>
                    </div>
                </div>
                <div class="hero-image">
                    <svg class="hero-illustration" viewBox="0 0 500 400" fill="none" xmlns="http://www.w3.org/2000/svg">
    <!-- Book/Learning illustration with purple colors -->
    <rect x="100" y="120" width="300" height="220" rx="15" fill="#8b5cf6" fill-opacity="0.1"/>
    <rect x="130" y="150" width="110" height="160" rx="10" fill="#8b5cf6" fill-opacity="0.2"/>
    <rect x="260" y="150" width="110" height="160" rx="10" fill="#6d28d9" fill-opacity="0.2"/>
    
    <!-- Graduation cap -->
    <path d="M250 80 L350 110 L250 140 L150 110 Z" fill="#8b5cf6"/>
    <path d="M250 140 L250 180" stroke="#8b5cf6" stroke-width="4" fill="none"/>
    
    <!-- Stars/achievements -->
    <circle cx="380" cy="100" r="15" fill="#8b5cf6"/>
    <circle cx="120" cy="200" r="10" fill="#ec4899"/>
    <circle cx="390" cy="280" r="12" fill="#6d28d9"/>
    
    <!-- Additional decorative elements -->
    <rect x="150" y="170" width="70" height="4" rx="2" fill="#8b5cf6" fill-opacity="0.3"/>
    <rect x="150" y="190" width="60" height="4" rx="2" fill="#8b5cf6" fill-opacity="0.3"/>
    <rect x="150" y="210" width="75" height="4" rx="2" fill="#8b5cf6" fill-opacity="0.3"/>
    
    <rect x="280" y="170" width="70" height="4" rx="2" fill="#6d28d9" fill-opacity="0.3"/>
    <rect x="280" y="190" width="60" height="4" rx="2" fill="#6d28d9" fill-opacity="0.3"/>
    <rect x="280" y="210" width="75" height="4" rx="2" fill="#6d28d9" fill-opacity="0.3"/>
</svg>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
        <div class="features-container">
            <div class="section-header">
                <h2>Why Choose LearnHub?</h2>
                <p>Empowering learners and instructors with cutting-edge tools and resources for effective online education.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <h3>Expert Instructors</h3>
                    <p>Learn from industry professionals and experienced educators who are passionate about sharing their knowledge.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3>Track Your Progress</h3>
                    <p>Monitor your learning journey with detailed progress tracking, completion certificates, and achievement badges.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-video"></i>
                    </div>
                    <h3>Quality Content</h3>
                    <p>Access high-quality video lectures, interactive assignments, and comprehensive course materials anytime, anywhere.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
        <div class="stats-container">
            <div class="stats-grid">
                <div class="stat-item">
                    <h3>500+</h3>
                    <p>Courses Available</p>
                </div>
                <div class="stat-item">
                    <h3>50K+</h3>
                    <p>Active Students</p>
                </div>
                <div class="stat-item">
                    <h3>1K+</h3>
                    <p>Expert Instructors</p>
                </div>
                <div class="stat-item">
                    <h3>98%</h3>
                    <p>Satisfaction Rate</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer" id="contact">
        <div class="footer-container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3><i class="fas fa-graduation-cap"></i> LearnHub</h3>
                    <p>Your gateway to quality education. Empowering learners worldwide to achieve their goals through accessible online learning.</p>
                    <div class="social-icons" style="margin-top: 20px;">
                        <i class="fab fa-facebook"></i>
                        <i class="fab fa-twitter"></i>
                        <i class="fab fa-linkedin"></i>
                        <i class="fab fa-youtube"></i>
                    </div>
                </div>
                <div class="footer-section">
                    <h3>For Students</h3>
                    <div class="footer-links">
                        <a href="#">Browse Courses</a>
                        <a href="#">My Learning</a>
                        <a href="#">Certificates</a>
                        <a href="#">Student Support</a>
                    </div>
                </div>
                <div class="footer-section">
                    <h3>For Instructors</h3>
                    <div class="footer-links">
                        <a href="#">Teach on LearnHub</a>
                        <a href="#">Instructor Dashboard</a>
                        <a href="#">Teaching Resources</a>
                        <a href="#">Instructor Support</a>
                    </div>
                </div>
                <div class="footer-section">
                    <h3>Company</h3>
                    <div class="footer-links">
                        <a href="#">About Us</a>
                        <a href="#">Contact</a>
                        <a href="#">Privacy Policy</a>
                        <a href="#">Terms of Service</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 LearnHub. All rights reserved. Empowering education worldwide.</p>
            </div>
        </div>
    </footer>
</body>
</html>