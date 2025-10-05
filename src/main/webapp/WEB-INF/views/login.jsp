<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LearnHub - Login</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0;
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            padding: 50px;
            width: 100%;
            max-width: 450px;
            margin: 20px auto;
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            color: #333;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header p {
            color: #666;
            font-size: 16px;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            width: 100%;
            padding: 16px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background-color: #f8f9ff;
            position: relative;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            background-color: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .form-control:hover {
            border-color: #c1c8d3;
            transform: translateY(-1px);
        }

        select.form-control {
            cursor: pointer;
        }

        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
            font-size: 18px;
            user-select: none;
            padding: 5px;
        }

        .password-toggle:hover {
            color: #667eea;
        }

        .login-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 18px 30px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .login-btn:active {
            transform: translateY(-1px);
        }

        .login-btn:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .forgot-password {
            text-align: center;
            margin-top: 25px;
        }

        .forgot-password a {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .forgot-password a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .register-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid #e1e5e9;
            color: #666;
        }

        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .register-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .error {
            color: #e74c3c;
            font-size: 13px;
            margin-top: 8px;
            display: none;
            padding: 8px;
            background-color: #fdf2f2;
            border-radius: 6px;
            border: 1px solid #fecaca;
        }

        .success {
            color: #27ae60;
            font-size: 13px;
            margin-top: 8px;
            display: none;
            padding: 8px;
            background-color: #f0f9f4;
            border-radius: 6px;
            border: 1px solid #a7f3d0;
        }

        .required {
            color: #e74c3c;
        }

        .loading {
            display: none;
            text-align: center;
            margin-top: 20px;
        }

        .loading::after {
            content: '';
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #667eea;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .form-control.error-input {
            border-color: #e74c3c;
            background-color: #fdf2f2;
        }

        .form-control.success-input {
            border-color: #27ae60;
            background-color: #f0f9f4;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 16px;
        }

        .form-control.with-icon {
            padding-left: 50px;
        }

        .back-home {
            text-align: center;
            margin-bottom: 20px;
        }

        .back-home a {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: color 0.3s ease;
        }

        .back-home a:hover {
            color: #764ba2;
        }

        @media (max-width: 768px) {
            .login-container {
                padding: 30px 25px;
                margin: 10px;
                border-radius: 15px;
            }

            .header h1 {
                font-size: 28px;
            }

            .form-control {
                padding: 14px 16px;
                font-size: 14px;
            }

            .login-btn {
                padding: 16px 25px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="back-home">
            <a href="/Secure-Online-Learning-Platform">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
        </div>

        <div class="header">
            <h1>Welcome Back</h1>
            <p>Sign in to continue your learning journey</p>
        </div>

        <form id="loginForm" action="authenticateUser.jsp" method="POST">
            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <div style="position: relative;">
                    <span class="input-icon">📧</span>
                    <input type="email" id="email" name="email" class="form-control with-icon" 
                           placeholder="Enter your email address" required autocomplete="email">
                </div>
                <div class="error" id="emailError">Please enter a valid email address</div>
            </div>

            <div class="form-group">
                <label for="password">Password <span class="required">*</span></label>
                <div class="password-container">
                    <span class="input-icon">🔒</span>
                    <input type="password" id="password" name="password" class="form-control with-icon" 
                           placeholder="Enter your password" required autocomplete="current-password">
                    <span class="password-toggle" onclick="togglePassword()">👁️</span>
                </div>
                <div class="error" id="passwordError">Password is required</div>
            </div>

            <div class="form-group">
                <label for="userRole">Login As <span class="required">*</span></label>
                <select id="userRole" name="userRole" class="form-control" required>
                    <option value="">Select your role...</option>
                    <option value="student">🎓 Student</option>
                    <option value="instructor">👨‍🏫 Instructor</option>
                </select>
                <div class="error" id="roleError">Please select your role</div>
            </div>

            <div class="loading" id="loading">
                Signing you in...
            </div>

            <button type="submit" class="login-btn" id="loginButton">
                Sign In
            </button>

            <div class="success" id="loginSuccess">
                Login successful! Redirecting...
            </div>

            <div class="error" id="loginError">
                Invalid credentials or role mismatch. Please try again.
            </div>
        </form>

      
        <div class="register-link">
            Don't have an account? <a href="register">Create one here</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    // Clear any old tokens on page load
    document.cookie = 'token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
    localStorage.removeItem('authToken');

    // Toggle password visibility
    window.togglePassword = function() {
        let pw = $('#password');
        let toggle = $('.password-toggle');
        if(pw.attr('type') === 'password'){
            pw.attr('type', 'text');
            toggle.text('🙈');
        } else {
            pw.attr('type', 'password');
            toggle.text('👁️');
        }
    };

    // Real-time validation clears errors
    $('#email, #password, #userRole').on('input change', function(){
        $(this).removeClass('error-input success-input');
        $('#' + this.id + 'Error').hide();
    });

    // Form submit handler
    $('#loginForm').on('submit', function(e){
        e.preventDefault();

        let email = $('#email').val().trim(),
            password = $('#password').val(),
            role = $('#userRole').val();

        // Simple validation before AJAX:
        let valid = true;
        $('.error').hide();
        $('.form-control').removeClass('error-input success-input');

        if(!email){
            $('#emailError').text('Email is required').show();
            $('#email').addClass('error-input');
            valid = false;
        } else if(!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)){
            $('#emailError').text('Enter a valid email').show();
            $('#email').addClass('error-input');
            valid = false;
        } else {
            $('#email').addClass('success-input');
        }

        if(!password){
            $('#passwordError').text('Password is required').show();
            $('#password').addClass('error-input');
            valid = false;
        } else if(password.length < 6){
            $('#passwordError').text('Password must be at least 6 characters').show();
            $('#password').addClass('error-input');
            valid = false;
        } else {
            $('#password').addClass('success-input');
        }

        if(!role){
            $('#roleError').text('Please select a role').show();
            $('#userRole').addClass('error-input');
            valid = false;
        } else {
            $('#userRole').addClass('success-input');
        }

        if(!valid) return;

        // ✅ CREATE loginData object
        const loginData = {
            email: email,
            password: password,
            role: role.toUpperCase() // Convert to uppercase to match backend expectations
        };

        // Cookie setter helper
        function setCookie(name, value, days){
            let expires = "";
            if(days){
                let d = new Date();
                d.setTime(d.getTime() + (days*24*60*60*1000));
                expires = "; expires=" + d.toUTCString();
            }
            document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/";
        }

        $('#loginButton').attr('disabled', true).text('Signing in...');
        $('#loading').show();

        $.ajax({
            url: "/Secure-Online-Learning-Platform/auth/login",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(loginData), // ✅ Now loginData is defined!
            success: function(response) {
                $('#loading').hide();
                if (response.status === 'success') {
                    $('#loginSuccess').show();
                    
                    // ✅ CLEAR OLD TOKEN FIRST
                    document.cookie = 'token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
                    
                    // ✅ SET NEW TOKEN
                    setCookie('token', response.token, 1);
                    
                    // Redirect based on role
                    if (response.role === 'INSTRUCTOR') {
                        window.location.href = '/Secure-Online-Learning-Platform/instructorDashboard';
                    } else if (response.role === 'STUDENT') {
                        window.location.href = '/Secure-Online-Learning-Platform/studentDashboard';
                    } else {
                        alert('Unknown user role: ' + response.role);
                    }
                } else {
                    $('#loginError').text(response.message || 'Login failed').show();
                    $('#loginButton').attr('disabled', false).text('Sign In');
                }
            },
            error: function(xhr, status, error) {
                $('#loading').hide();
                let errMsg = 'Invalid Email or Password';
                if (xhr.responseJSON && xhr.responseJSON.message) {
                    errMsg = xhr.responseJSON.message;
                } else if (xhr.status >= 500) {
                    errMsg = 'Server error. Please try again later.';
                }
                $('#loginError').text(errMsg).show();
                console.error('Login failed:', error, xhr.responseText);
                $('#loginButton').attr('disabled', false).text('Sign In');
            }
        });
    });
});
</script>

</body>
</html>