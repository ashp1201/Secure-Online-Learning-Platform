<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard - LearnHub</title>
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

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e1e1;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #8b5cf6;
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
        }

        .form-row {
            display: flex;
            gap: 20px;
        }

        .form-row .form-group {
            flex: 1;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.3);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .btn-small {
            padding: 6px 12px;
            font-size: 12px;
        }

        .btn-danger {
            background: #e74c3c;
            color: white;
        }

        .btn-info {
            background: #3498db;
            color: white;
        }

        .course-card {
            background: #faf5ff;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #8b5cf6;
            transition: all 0.3s ease;
        }

        .course-card:hover {
            transform: translateX(5px);
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.2);
        }

        .course-title {
            font-size: 20px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }

        .course-details {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .course-detail {
            background: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            color: #666;
            border: 1px solid #e1e1e1;
        }

        .course-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            font-weight: 600;
            animation: slideIn 0.3s ease-out;
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

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }

            .dashboard-nav {
                flex-direction: column;
            }

            .form-row {
                flex-direction: column;
            }

            .course-details {
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
                LearnHub - Instructor
            </div>
            <div class="user-info">
                <span>Welcome, <strong id="instructorName"></strong></span>
                <button class="logout-btn" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </div>
        </div>
    </header>

    <div class="dashboard-container">
        <div class="dashboard-nav">
            <button class="nav-tab active" onclick="showTab('create-course', event)">
                <i class="fas fa-plus-circle"></i> Create Course
            </button>
            <button class="nav-tab" onclick="showTab('my-courses', event)">
                <i class="fas fa-book"></i> My Courses
            </button>
            <button class="nav-tab" onclick="showTab('enrollments', event)">
                <i class="fas fa-users"></i> Enrollments
            </button>
        </div>

        <!-- Create Course Tab -->
        <div id="create-course" class="tab-content active">
            <h2 class="section-title">Create New Course</h2>

            <div id="alertContainer"></div>

            <form id="courseForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="courseTitle">Course Title *</label>
                        <input type="text" id="courseTitle" name="title" class="form-control"
                            placeholder="e.g., Introduction to Web Development" required>
                    </div>
                    <div class="form-group">
                        <label for="category">Category *</label>
                        <select id="category" name="category" class="form-control" required>
                            <option value="">Select category...</option>
                            <option value="Programming">Programming</option>
                            <option value="Design">Design</option>
                            <option value="Business">Business</option>
                            <option value="Marketing">Marketing</option>
                            <option value="Data Science">Data Science</option>
                            <option value="Personal Development">Personal Development</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="difficulty">Difficulty Level *</label>
                        <select id="difficulty" name="difficulty" class="form-control" required>
                            <option value="">Select difficulty...</option>
                            <option value="Beginner">Beginner</option>
                            <option value="Intermediate">Intermediate</option>
                            <option value="Advanced">Advanced</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="contentPath">Course Materials/Files (Max 100MB)</label>
                        <input type="file" id="contentPath" name="contentPath" class="form-control"
                            accept=".pdf,.zip,.mp4,.pptx,.avi,.mov,.doc,.docx,.txt">
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Course Description *</label>
                    <textarea id="description" name="description" class="form-control" required
                        placeholder="Describe what students will learn in this course..."></textarea>
                </div>

                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <span id="submitText"><i class="fas fa-save"></i> Create Course</span>
                </button>
            </form>
        </div>

        <!-- My Courses Tab -->
        <div id="my-courses" class="tab-content">
            <h2 class="section-title">My Courses</h2>
            <div id="coursesList">
                <p>Loading courses...</p>
            </div>
        </div>

        <!-- Enrollments Tab -->
        <div id="enrollments" class="tab-content">
            <h2 class="section-title">Student Enrollments</h2>
            <div id="enrollmentsList">
                <p>Loading enrollments...</p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        let authToken = null;

        $(document).ready(function () {
            authToken = getCookie('token');
            
            if (!authToken) {
                alert('Please login first!');
                window.location.href = '/Secure-Online-Learning-Platform/login';
                return;
            }
            
            loadUserInfo();

            $("#courseForm").submit(function (e) {
                e.preventDefault();
                createCourse();
            });
        });

        function showTab(tabId, event) {
            $(".tab-content").removeClass("active");
            $(".nav-tab").removeClass("active");

            $("#" + tabId).addClass("active");
            if (event) $(event.target).addClass("active");

            if (tabId === 'my-courses') {
                loadMyCourses();
            } else if (tabId === 'enrollments') {
                loadEnrollments();
            }
        }

        function loadUserInfo() {
            $.ajax({
                url: "/Secure-Online-Learning-Platform/auth/user/me?t=" + new Date().getTime(),
                method: "GET",
                headers: { "Authorization": "Bearer " + authToken },
                cache: false,
                success: function (data) {
                    let displayName = data.fullName || data.email;
                    $("#instructorName").text(displayName);
                },
                error: function (xhr) {
                    $("#instructorName").text("Instructor");
                }
            });
        }

        function createCourse() {
            const title = $('#courseTitle').val().trim();
            const description = $('#description').val().trim();
            const category = $('#category').val();
            const difficulty = $('#difficulty').val();
            const fileInput = $('#contentPath')[0];
            const file = fileInput?.files[0];

            // Validation
            if (!title || !description || !category || !difficulty) {
                showAlert('Please fill in all required fields', 'error');
                return;
            }

            $('#submitBtn').prop('disabled', true);
            $('#submitText').html('<i class="fas fa-spinner fa-spin"></i> Creating...');
            showAlert('', '');

            let courseData = {
                title: title,
                description: description,
                category: category,
                difficulty: difficulty,
                contentPath: null
            };

            // If file is selected, upload it first
            if (file) {
                // ✅ Validate file size on client side (100MB)
                const maxSize = 100 * 1024 * 1024;
                if (file.size > maxSize) {
                    showAlert('File size exceeds 100 MB limit. Please upload a smaller file.', 'error');
                    $('#submitBtn').prop('disabled', false);
                    $('#submitText').html('<i class="fas fa-save"></i> Create Course');
                    return;
                }

                uploadCourseFile(file, title)
                    .done(function(response) {
                        if (response.success && response.filePath) {
                            courseData.contentPath = response.filePath;
                            saveCourse(courseData);
                        } else {
                            showAlert(response.error || 'Failed to upload file', 'error');
                            $('#submitBtn').prop('disabled', false);
                            $('#submitText').html('<i class="fas fa-save"></i> Create Course');
                        }
                    })
                    .fail(function() {
                        $('#submitBtn').prop('disabled', false);
                        $('#submitText').html('<i class="fas fa-save"></i> Create Course');
                    });
            } else {
                saveCourse(courseData);
            }
        }

        function uploadCourseFile(file, courseName) {
            const formData = new FormData();
            formData.append('file', file);
            formData.append('courseName', courseName);

            return $.ajax({
                url: '/Secure-Online-Learning-Platform/upload/course-content',
                method: 'POST',
                headers: { 'Authorization': 'Bearer ' + authToken },
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    if (response.success) {
                        console.log('File uploaded successfully:', response.filePath);
                        return response;
                    } else {
                        showAlert(response.error || 'File upload failed', 'error');
                        throw new Error(response.error || 'File upload failed');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Upload error:', xhr);
                    
                    let errorMessage = 'Failed to upload file';
                    
                    // ✅ Extract error message from response
                    if (xhr.responseJSON) {
                        errorMessage = xhr.responseJSON.error || xhr.responseJSON.message || errorMessage;
                    } else if (xhr.responseText) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            errorMessage = response.error || response.message || errorMessage;
                        } catch (e) {
                            errorMessage = xhr.responseText || errorMessage;
                        }
                    }
                    
                    showAlert(errorMessage, 'error');
                    throw new Error(errorMessage);
                }
            });
        }

        function saveCourse(courseData) {
            $.ajax({
                url: '/Secure-Online-Learning-Platform/courses/create',
                method: 'POST',
                headers: {
                    'Authorization': 'Bearer ' + authToken,
                    'Content-Type': 'application/json'
                },
                data: JSON.stringify(courseData),
                success: function(response) {
                    showAlert('Course created successfully!', 'success');
                    $('#courseForm')[0].reset();
                    $('#submitBtn').prop('disabled', false);
                    $('#submitText').html('<i class="fas fa-save"></i> Create Course');
                    
                    setTimeout(function() {
                        showTab('my-courses');
                        loadMyCourses();
                    }, 2000);
                },
                error: function(xhr) {
                    let errorMsg = 'Failed to create course';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg = xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        errorMsg = xhr.responseText;
                    }
                    showAlert(errorMsg, 'error');
                    $('#submitBtn').prop('disabled', false);
                    $('#submitText').html('<i class="fas fa-save"></i> Create Course');
                }
            });
        }

        function showAlert(message, type) {
            const alertContainer = $("#alertContainer");
            if (!message) {
                alertContainer.html('');
                return;
            }
            
            const alertClass = type === 'error' ? 'alert-error' : 'alert-success';
            const icon = type === 'error' ? '❌' : '✅';
            
            alertContainer.html(`<div class="alert ${alertClass}">${icon} ${message}</div>`);
            
            if (type === 'success') {
                setTimeout(() => alertContainer.html(''), 5000);
            }
        }

        function getCookie(name) {
            const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
            return match ? match[2] : null;
        }

        function loadMyCourses() {
            const coursesList = $("#coursesList");
            coursesList.html("<p>Loading courses...</p>");

            $.ajax({
                url: "/Secure-Online-Learning-Platform/courses/instructor/my-courses",
                method: "GET",
                headers: { "Authorization": "Bearer " + authToken },
                success: function (courses) {
                    coursesList.html("");
                    if (!courses || courses.length === 0) {
                        coursesList.html("<p>No courses created yet. <a href='#' onclick=\"showTab('create-course', event)\">Create your first course</a>!</p>");
                        return;
                    }
                    courses.forEach(course => {
                        const courseCard = `
                        <div class="course-card">
                            <div class="course-title">${escapeHtml(course.title)}</div>
                            <div class="course-details">
                                <div class="course-detail"><i class="fas fa-tag"></i> ${escapeHtml(course.category)}</div>
                                <div class="course-detail"><i class="fas fa-signal"></i> ${escapeHtml(course.difficulty)}</div>
                                <div class="course-detail"><i class="fas fa-users"></i> ${course.enrollmentCount || 0} students</div>
                            </div>
                            <p>${escapeHtml(course.description)}</p>
                            <div class="course-actions">
                                <button class="btn btn-danger btn-small" onclick="deleteCourse(${course.courseId})">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </div>
                        </div>`;
                        coursesList.append(courseCard);
                    });
                },
                error: function () {
                    coursesList.html("<p>Error loading courses. Please try again.</p>");
                }
            });
        }

        function loadEnrollments() {
            const enrollmentsList = $("#enrollmentsList");
            enrollmentsList.html("<p>Loading enrollments...</p>");

            $.ajax({
                url: "/Secure-Online-Learning-Platform/enrollments/instructor/students",
                method: "GET",
                headers: { "Authorization": "Bearer " + authToken },
                success: function (enrollments) {
                    enrollmentsList.html("");
                    if (!enrollments || enrollments.length === 0) {
                        enrollmentsList.html("<p>No student enrollments yet.</p>");
                        return;
                    }
                    enrollmentsList.html(`<p>${enrollments.length} student(s) enrolled in your courses.</p>`);
                },
                error: function () {
                    enrollmentsList.html("<p>Error loading enrollments. Please try again.</p>");
                }
            });
        }

        function escapeHtml(text) {
            if (!text) return '';
            const map = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' };
            return text.replace(/[&<>"']/g, m => map[m]);
        }

        function deleteCourse(courseId) {
            if (confirm('Are you sure you want to delete this course?')) {
                $.ajax({
                    url: `/Secure-Online-Learning-Platform/courses/${courseId}`,
                    method: "DELETE",
                    headers: { "Authorization": "Bearer " + authToken },
                    success: function () {
                        showAlert('Course deleted successfully!', 'success');
                        loadMyCourses();
                    },
                    error: function () {
                        showAlert('Error: Failed to delete course', 'error');
                    }
                });
            }
        }

        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                document.cookie = 'token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
                localStorage.removeItem('authToken');
                window.location.href = '/Secure-Online-Learning-Platform';
            }
        }
    </script>
</body>

</html>
