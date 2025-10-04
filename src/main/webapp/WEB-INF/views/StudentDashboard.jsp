<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page isELIgnored="true" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Student Dashboard - LearnHub</title>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Arial', sans-serif;
                    background: linear-gradient(135deg, #f5f7fa 0%, #e8d5f5 100%);
                    min-height: 100vh;
                }

                .header {
                    background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
                    color: white;
                    padding: 20px 0;
                    box-shadow: 0 4px 20px rgba(139, 92, 246, 0.3);
                }

                .header-content {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 0 20px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .logo {
                    font-size: 24px;
                    font-weight: bold;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .user-info {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                .logout-btn {
                    background: rgba(255, 255, 255, 0.2);
                    border: 1px solid rgba(255, 255, 255, 0.3);
                    color: white;
                    padding: 10px 20px;
                    border-radius: 10px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    font-weight: 600;
                }

                .logout-btn:hover {
                    background: rgba(255, 255, 255, 0.3);
                    transform: translateY(-2px);
                }

                .dashboard-container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 30px 20px;
                }

                .dashboard-nav {
                    display: flex;
                    gap: 20px;
                    margin-bottom: 30px;
                    flex-wrap: wrap;
                }

                .nav-tab {
                    background: white;
                    border: none;
                    padding: 12px 24px;
                    border-radius: 12px;
                    cursor: pointer;
                    font-weight: 600;
                    transition: all 0.3s ease;
                    box-shadow: 0 4px 15px rgba(139, 92, 246, 0.1);
                }

                .nav-tab.active {
                    background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
                    color: white;
                }

                .nav-tab:hover:not(.active) {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(139, 92, 246, 0.2);
                    background: #faf5ff;
                }

                .tab-content {
                    display: none;
                    background: white;
                    border-radius: 15px;
                    padding: 30px;
                    box-shadow: 0 10px 30px rgba(139, 92, 246, 0.1);
                }

                .tab-content.active {
                    display: block;
                }

                .section-title {
                    font-size: 24px;
                    color: #333;
                    margin-bottom: 20px;
                    font-weight: 700;
                }

                /* Search and Filter */
                .search-filter-section {
                    background: #faf5ff;
                    padding: 20px;
                    border-radius: 12px;
                    margin-bottom: 30px;
                }

                .search-row {
                    display: flex;
                    gap: 15px;
                    flex-wrap: wrap;
                }

                .search-input {
                    flex: 2;
                    padding: 12px 20px;
                    border: 2px solid #e1e1e1;
                    border-radius: 10px;
                    font-size: 14px;
                }

                .filter-select {
                    flex: 1;
                    padding: 12px 15px;
                    border: 2px solid #e1e1e1;
                    border-radius: 10px;
                    font-size: 14px;
                }

                .search-btn {
                    padding: 12px 30px;
                    background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
                    color: white;
                    border: none;
                    border-radius: 10px;
                    cursor: pointer;
                    font-weight: 600;
                    transition: all 0.3s ease;
                }

                .search-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(139, 92, 246, 0.3);
                }

                /* Course Cards */
                .course-card {
                    background: white;
                    border-radius: 12px;
                    padding: 20px;
                    margin-bottom: 20px;
                    box-shadow: 0 4px 15px rgba(139, 92, 246, 0.1);
                    transition: all 0.3s ease;
                    border-left: 4px solid #8b5cf6;
                }

                .course-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 8px 25px rgba(139, 92, 246, 0.2);
                }

                .course-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: start;
                    margin-bottom: 15px;
                }

                .course-title {
                    font-size: 20px;
                    font-weight: 700;
                    color: #333;
                    margin-bottom: 5px;
                }

                .course-instructor {
                    color: #666;
                    font-size: 14px;
                }

                .course-details {
                    display: flex;
                    gap: 15px;
                    margin-bottom: 15px;
                    flex-wrap: wrap;
                }

                .course-detail {
                    background: #faf5ff;
                    padding: 5px 12px;
                    border-radius: 20px;
                    font-size: 12px;
                    color: #666;
                }

                .course-description {
                    color: #666;
                    line-height: 1.6;
                    margin-bottom: 15px;
                }

                .course-actions {
                    display: flex;
                    gap: 10px;
                }

                .btn {
                    padding: 10px 20px;
                    border: none;
                    border-radius: 10px;
                    cursor: pointer;
                    font-weight: 600;
                    transition: all 0.3s ease;
                    font-size: 14px;
                }

                .btn-primary {
                    background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
                    color: white;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(139, 92, 246, 0.3);
                }

                .btn-outline {
                    background: transparent;
                    border: 2px solid #8b5cf6;
                    color: #8b5cf6;
                }

                .btn-outline:hover {
                    background: #8b5cf6;
                    color: white;
                }

                .btn-success {
                    background: #10b981;
                    color: white;
                }

                .btn-small {
                    padding: 6px 12px;
                    font-size: 12px;
                }

                /* Progress Bar */
                .progress-container {
                    margin-top: 15px;
                }

                .progress-label {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 8px;
                    font-size: 14px;
                    color: #666;
                }

                .progress-bar {
                    width: 100%;
                    height: 8px;
                    background: #e1e1e1;
                    border-radius: 10px;
                    overflow: hidden;
                }

                .progress-fill {
                    height: 100%;
                    background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
                    transition: width 0.3s ease;
                }

                /* Enrollment Status */
                .enrollment-status {
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 12px;
                    font-weight: 600;
                }

                .status-active {
                    background: #d4edda;
                    color: #155724;
                }

                .status-completed {
                    background: #cce5ff;
                    color: #004085;
                }

                .alert {
                    padding: 15px;
                    margin-bottom: 20px;
                    border-radius: 10px;
                    font-weight: 600;
                }

                .alert-success {
                    background-color: #d4edda;
                    color: #155724;
                    border: 1px solid #c3e6cb;
                }

                .alert-error {
                    background-color: #f8d7da;
                    color: #721c24;
                    border: 1px solid #f5c6cb;
                }

                .loading {
                    display: inline-block;
                    width: 20px;
                    height: 20px;
                    border: 3px solid #f3f3f3;
                    border-top: 3px solid #8b5cf6;
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                    margin-right: 10px;
                }

                @keyframes spin {
                    0% {
                        transform: rotate(0deg);
                    }

                    100% {
                        transform: rotate(360deg);
                    }
                }

                /* Modal */
                .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.5);
                    backdrop-filter: blur(3px);
                }

                .modal-content {
                    background-color: white;
                    margin: 5% auto;
                    padding: 30px;
                    border-radius: 15px;
                    width: 90%;
                    max-width: 600px;
                    max-height: 80vh;
                    overflow-y: auto;
                    box-shadow: 0 20px 60px rgba(139, 92, 246, 0.3);
                }

                .modal-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 20px;
                    padding-bottom: 15px;
                    border-bottom: 2px solid #f0f0f0;
                }

                .modal-title {
                    font-size: 24px;
                    font-weight: 700;
                    color: #333;
                }

                .close {
                    font-size: 32px;
                    font-weight: bold;
                    color: #999;
                    cursor: pointer;
                    transition: color 0.3s ease;
                }

                .close:hover {
                    color: #333;
                }

                @media (max-width: 768px) {
                    .header-content {
                        flex-direction: column;
                        gap: 15px;
                    }

                    .dashboard-nav {
                        flex-direction: column;
                    }

                    .search-row {
                        flex-direction: column;
                    }

                    .course-header {
                        flex-direction: column;
                    }

                    .course-actions {
                        flex-direction: column;
                    }
                }
            </style>
        </head>

        <body>
            <header class="header">
                <div class="header-content">
                    <div class="logo">
                        <i class="fas fa-graduation-cap"></i>
                        LearnHub - Student
                    </div>
                    <div class="user-info">
                        <span>Welcome, <strong id="studentName"></strong></span>
                        <button class="logout-btn" onclick="logout()">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </button>
                    </div>
                </div>
            </header>

            <div class="dashboard-container">
                <div class="dashboard-nav">
                    <button class="nav-tab active" onclick="showTab('browse-courses', event)">
                        <i class="fas fa-search"></i> Browse Courses
                    </button>
                    <button class="nav-tab" onclick="showTab('my-courses', event)">
                        <i class="fas fa-book-open"></i> My Courses
                    </button>
                    <button class="nav-tab" onclick="showTab('progress', event)">
                        <i class="fas fa-tasks"></i> Progress
                    </button>
                </div>

                <!-- Browse Courses Tab -->
                <div id="browse-courses" class="tab-content active">
                    <h2 class="section-title">Browse Available Courses</h2>

                    <div class="search-filter-section">
                        <div class="search-row">
                            <input type="text" id="searchInput" class="search-input" placeholder="Search courses...">
                            <select id="categoryFilter" class="filter-select">
                                <option value="">All Categories</option>
                                <option value="Programming">Programming</option>
                                <option value="Design">Design</option>
                                <option value="Business">Business</option>
                                <option value="Marketing">Marketing</option>
                                <option value="Data Science">Data Science</option>
                            </select>
                            <select id="difficultyFilter" class="filter-select">
                                <option value="">All Levels</option>
                                <option value="Beginner">Beginner</option>
                                <option value="Intermediate">Intermediate</option>
                                <option value="Advanced">Advanced</option>
                            </select>
                            <button class="search-btn" onclick="searchCourses()">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>

                    <div id="alertContainer"></div>
                    <div id="coursesList">
                        <p>Loading available courses...</p>
                    </div>
                </div>

                <!-- My Courses Tab -->
                <div id="my-courses" class="tab-content">
                    <h2 class="section-title">My Enrolled Courses</h2>
                    <div id="enrolledCoursesList">
                        <p>Loading your courses...</p>
                    </div>
                </div>

                <!-- Progress Tab -->
                <div id="progress" class="tab-content">
                    <h2 class="section-title">Learning Progress</h2>
                    <div id="progressList">
                        <p>Loading progress data...</p>
                    </div>
                </div>
            </div>

            <!-- Course Details Modal -->
            <div id="courseModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title" id="modalCourseTitle">Course Details</h2>
                        <span class="close" onclick="closeModal()">&times;</span>
                    </div>
                    <div id="modalCourseContent">
                        Loading...
                    </div>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                let authToken = null;

                $(document).ready(function () {
                    authToken = getCookie('token') || localStorage.getItem('authToken');
                    if (!authToken) {
                        alert('Please login first!');
                        window.location.href = '/Secure-Online-Learning-Platform/login';
                        return;
                    }
                    loadUserInfo();
                    loadAvailableCourses();
                });

                function showTab(tabId, event) {
                    $(".tab-content").removeClass("active");
                    $(".nav-tab").removeClass("active");

                    $("#" + tabId).addClass("active");
                    if (event) $(event.target).addClass("active");

                    if (tabId === 'browse-courses') {
                        loadAvailableCourses();
                    } else if (tabId === 'my-courses') {
                        loadEnrolledCourses();
                    } else if (tabId === 'progress') {
                        loadProgress();
                    }
                }

                function loadUserInfo() {
                    $.ajax({
                        url: "/Secure-Online-Learning-Platform/auth/user/me",
                        method: "GET",
                        headers: { "Authorization": "Bearer " + authToken },
                        success: function (data) {
                            let displayName = data.fullName || data.email;
                            $("#studentName").text(displayName);
                        },
                        error: function () {
                            $("#studentName").text("Student");
                        }
                    });
                }

                function loadAvailableCourses() {
                    const coursesList = $("#coursesList");
                    coursesList.html("<p>Loading courses...</p>");

                    $.ajax({
                        url: "/Secure-Online-Learning-Platform/courses/list",
                        method: "GET",
                        headers: { "Authorization": "Bearer " + authToken },
                        success: function (courses) {
                            displayCourses(courses, coursesList, false);
                        },
                        error: function () {
                            coursesList.html("<p>Error loading courses. Please try again.</p>");
                        }
                    });
                }

                function searchCourses() {
                    const searchTerm = $("#searchInput").val();
                    const category = $("#categoryFilter").val();
                    const difficulty = $("#difficultyFilter").val();

                    const coursesList = $("#coursesList");
                    coursesList.html("<p>Searching courses...</p>");

                    $.ajax({
                        url: "/Secure-Online-Learning-Platform/courses/search",
                        method: "GET",
                        headers: { "Authorization": "Bearer " + authToken },
                        data: { search: searchTerm, category: category, difficulty: difficulty },
                        success: function (courses) {
                            displayCourses(courses, coursesList, false);
                        },
                        error: function () {
                            coursesList.html("<p>Error searching courses. Please try again.</p>");
                        }
                    });
                }

                function displayCourses(courses, container, isEnrolled) {
                    container.html("");
                    if (!courses || courses.length === 0) {
                        container.html("<p>No courses found.</p>");
                        return;
                    }

                    courses.forEach(course => {
                        const instructorName = course.instructor ? course.instructor.fullName : 'Unknown';
                        const courseCard = `
                    <div class="course-card">
                        <div class="course-header">
                            <div>
                                <div class="course-title">${escapeHtml(course.title)}</div>
                                <div class="course-instructor">
                                    <i class="fas fa-user"></i> ${escapeHtml(instructorName)}
                                </div>
                            </div>
                            ${isEnrolled ? '<span class="enrollment-status status-active">Enrolled</span>' : ''}
                        </div>
                        <div class="course-details">
                            <div class="course-detail">
                                <i class="fas fa-tag"></i> ${escapeHtml(course.category)}
                            </div>
                            <div class="course-detail">
                                <i class="fas fa-signal"></i> ${escapeHtml(course.difficulty)}
                            </div>
                        </div>
                        <div class="course-description">${escapeHtml(course.description)}</div>
                        ${isEnrolled ? renderProgressBar(course.progressPercent || 0) : ''}
                        <div class="course-actions">
                            ${isEnrolled ?
                                `<button class="btn btn-primary btn-small" onclick="continueCourse(${course.courseId})">
                                    <i class="fas fa-play"></i> Continue Learning
                                </button>` :
                                `<button class="btn btn-primary btn-small" onclick="enrollCourse(${course.courseId})">
                                    <i class="fas fa-plus"></i> Enroll Now
                                </button>`
                            }
                            <button class="btn btn-outline btn-small" onclick="viewCourseDetails(${course.courseId})">
                                <i class="fas fa-info-circle"></i> Details
                            </button>
                        </div>
                    </div>`;
                        container.append(courseCard);
                    });
                }

                function renderProgressBar(percent) {
                    return `
                <div class="progress-container">
                    <div class="progress-label">
                        <span>Progress</span>
                        <span><strong>${percent}%</strong></span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${percent}%"></div>
                    </div>
                </div>`;
                }

                function loadEnrolledCourses() {
                    const enrolledList = $("#enrolledCoursesList");
                    enrolledList.html("<p>Loading your courses...</p>");

                    $.ajax({
                        url: "/Secure-Online-Learning-Platform/enrollments/my-enrollments",
                        method: "GET",
                        headers: { "Authorization": "Bearer " + authToken },
                        success: function (enrollments) {
                            enrolledList.html("");
                            if (!enrollments || enrollments.length === 0) {
                                enrolledList.html("<p>You haven't enrolled in any courses yet. <a href='#' onclick=\"showTab('browse-courses')\">Browse courses</a> to get started!</p>");
                                return;
                            }
                            const courses = enrollments.map(e => ({ ...e.course, progressPercent: e.progressPercent }));
                            displayCourses(courses, enrolledList, true);
                        },
                        error: function () {
                            enrolledList.html("<p>Error loading your courses. Please try again.</p>");
                        }
                    });
                }

                function loadProgress() {
                    const progressList = $("#progressList");
                    progressList.html("<p>Loading progress...</p>");

                    $.ajax({
                        url: "/Secure-Online-Learning-Platform/progress/my-progress",
                        method: "GET",
                        headers: { "Authorization": "Bearer " + authToken },
                        success: function (progressData) {
                            progressList.html("");
                            if (!progressData || progressData.length === 0) {
                                progressList.html("<p>No progress data available yet.</p>");
                                return;
                            }
                            progressList.html(`<p>${progressData.length} course(s) in progress.</p>`);
                        },
                        error: function () {
                            progressList.html("<p>Error loading progress. Please try again.</p>");
                        }
                    });
                }

                function enrollCourse(courseId) {
                    if (!confirm('Are you sure you want to enroll in this course?')) return;

                    $.ajax({
                        url: "/Secure-Online-Learning-Platform/enrollments/enroll",
                        method: "POST",
                        headers: { "Authorization": "Bearer " + authToken },
                        contentType: "application/json",
                        data: JSON.stringify({ courseId: courseId }),
                        success: function () {
                            showAlert('Successfully enrolled in the course!', 'success');
                            loadAvailableCourses();
                        },
                        error: function (xhr) {
                            showAlert(xhr.responseText || 'Failed to enroll in course', 'error');
                        }
                    });
                }

                function continueCourse(courseId) {
                    alert(`Continuing course ${courseId}. Learning interface coming soon!`);
                }

                function viewCourseDetails(courseId) {
                    $("#courseModal").show();
                    $("#modalCourseContent").html("<p>Loading course details...</p>");

                    $.ajax({
                        url: `/Secure-Online-Learning-Platform/courses/${courseId}`,
                        method: "GET",
                        headers: { "Authorization": "Bearer " + authToken },
                        success: function (course) {
                            const instructorName = course.instructor ? course.instructor.fullName : 'Unknown';
                            $("#modalCourseTitle").text(course.title);
                            $("#modalCourseContent").html(`
                        <p><strong>Instructor:</strong> ${escapeHtml(instructorName)}</p>
                        <p><strong>Category:</strong> ${escapeHtml(course.category)}</p>
                        <p><strong>Difficulty:</strong> ${escapeHtml(course.difficulty)}</p>
                        <p><strong>Description:</strong></p>
                        <p>${escapeHtml(course.description)}</p>
                    `);
                        },
                        error: function () {
                            $("#modalCourseContent").html("<p>Error loading course details.</p>");
                        }
                    });
                }

                function closeModal() {
                    $("#courseModal").hide();
                }

                function showAlert(message, type) {
                    const alertContainer = $("#alertContainer");
                    if (!message) {
                        alertContainer.html('');
                        return;
                    }
                    const alertClass = type === 'error' ? 'alert-error' : 'alert-success';
                    alertContainer.html(`<div class="alert ${alertClass}">${message}</div>`);
                    if (type === 'success') {
                        setTimeout(() => alertContainer.html(''), 5000);
                    }
                }

                function escapeHtml(text) {
                    const map = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' };
                    return text.replace(/[&<>"']/g, m => map[m]);
                }

                function getCookie(name) {
                    const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
                    return match ? match[2] : null;
                }

                function logout() {
                    if (confirm('Are you sure you want to logout?')) {
                        document.cookie = 'token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
                        localStorage.removeItem('authToken');
                        window.location.href = '/Secure-Online-Learning-Platform';
                    }
                }

                $(window).click(function (event) {
                    if (event.target.id === 'courseModal') {
                        closeModal();
                    }
                });
            </script>
        </body>

        </html>