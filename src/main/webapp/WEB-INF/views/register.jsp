<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>LearnHub - User Registration</title>
        <style>
            /* Your existing styles from the provided code */
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
                padding: 20px 0;
            }

            .registration-container {
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 25px 50px rgba(0, 0, 0, .15);
                padding: 50px;
                width: 100%;
                max-width: 700px;
                margin: 20px;
                position: relative;
                overflow: hidden;
            }

            .registration-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

            .header {
                text-align: center;
                margin-bottom: 35px;
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
            }

            .form-group {
                margin-bottom: 25px;
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
                transition: all .3s cubic-bezier(0.4, 0, 0.2, 1);
                background-color: #f8f9ff;
            }

            .form-control:focus {
                outline: none;
                border-color: #667eea;
                background: #fff;
                box-shadow: 0 0 0 4px rgba(102, 126, 234, .1);
                transform: translateY(-2px);
            }

            .form-control:hover {
                border-color: #c1c8d3;
                transform: translateY(-1px);
            }

            select.form-control {
                cursor: pointer;
            }

            textarea.form-control {
                resize: vertical;
                min-height: 120px;
            }

            .form-row {
                display: flex;
                gap: 20px;
            }

            .form-row .form-group {
                flex: 1;
            }

            .role-specific-section {
                background: #f8f9ff;
                border-radius: 12px;
                padding: 25px;
                margin-top: 25px;
                border-left: 4px solid #667eea;
                display: none;
                animation: slideDown .4s ease-out;
            }

            .role-specific-section.show {
                display: block;
            }

            .section-title {
                color: #667eea;
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
            }

            .section-title:before {
                content: '';
                display: inline-block;
                width: 4px;
                height: 20px;
                background: #667eea;
                margin-right: 10px;
                border-radius: 2px;
            }

            .submit-btn {
                width: 100%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: #fff;
                border: none;
                padding: 18px 30px;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all .3s cubic-bezier(0.4, 0, 0.2, 1);
                margin-top: 25px;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .submit-btn:hover:not(:disabled) {
                transform: translateY(-3px);
                box-shadow: 0 15px 35px rgba(102, 126, 234, .4);
            }

            .submit-btn:active {
                transform: translateY(-1px);
            }

            .submit-btn:disabled {
                opacity: .7;
                cursor: not-allowed;
                transform: none;
            }

            .loading-spinner {
                display: none;
                width: 20px;
                height: 20px;
                border: 2px solid #fff;
                border-top: 2px solid transparent;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin-right: 10px;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0)
                }

                100% {
                    transform: rotate(360deg)
                }
            }

            .login-link {
                text-align: center;
                margin-top: 30px;
                padding-top: 25px;
                border-top: 1px solid #e1e5e9;
                color: #666;
            }

            .login-link a {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
            }

            .login-link a:hover {
                text-decoration: underline;
                color: #764ba2;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px)
                }

                to {
                    opacity: 1;
                    transform: translateY(0)
                }
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

            .required {
                color: #e74c3c;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 8px;
                display: none;
                animation: slideDown .3s ease-out;
                position: relative;
            }

            .alert.success {
                background: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
            }

            .alert.error {
                background: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
            }

            .alert-close {
                position: absolute;
                right: 10px;
                top: 10px;
                cursor: pointer;
                font-size: 18px;
                line-height: 1;
                color: inherit;
                opacity: .7;
            }

            .alert-close:hover {
                opacity: 1;
            }

            .form-control.error-input {
                border-color: #e74c3c;
                background-color: #fdf2f2;
            }

            .form-control.success-input {
                border-color: #27ae60;
                background-color: #f0f9f4;
            }

            @media (max-width:768px) {
                .registration-container {
                    padding: 30px 25px;
                    margin: 10px;
                    border-radius: 15px;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }

                .header h1 {
                    font-size: 28px;
                }

                .form-control {
                    padding: 14px 16px;
                    font-size: 14px;
                }

                .submit-btn {
                    padding: 16px 25px;
                    font-size: 14px;
                }
            }
        </style>
    </head>

    <body>
        <div class="registration-container">
            <div class="back-home">
                <a href="/Secure-Online-Learning-Platform">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>
            </div>

            <div class="header">
                <h1>Create Your Account</h1>
                <p>Join LearnHub and start your learning journey today</p>
            </div>

            <div id="alertMessage" class="alert">
                <span class="alert-close" onclick="closeAlert()">&times;</span>
                <div id="alertText"></div>
            </div>

            <form id="registrationForm" novalidate>
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Full Name <span class="required">*</span></label>
                        <input type="text" id="fullName" name="fullName" class="form-control"
                            placeholder="Enter your full name" required />
                        <div class="error" id="fullNameError">Full name is required</div>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address <span class="required">*</span></label>
                        <input type="email" id="email" name="email" class="form-control"
                            placeholder="your.email@example.com" required />
                        <div class="error" id="emailError">Valid email is required</div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password <span class="required">*</span></label>
                        <input type="password" id="password" name="password" class="form-control"
                            placeholder="Minimum 8 characters" required minlength="8" />
                        <div class="error" id="passwordError">Password must be at least 8 characters</div>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                            placeholder="Re-enter password" required />
                        <div class="error" id="confirmPasswordError">Passwords must match</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="userRole">Select Your Role <span class="required">*</span></label>
                    <select id="userRole" name="role" class="form-control" required
                        onchange="showRoleSpecificSection()">
                        <option value="">Choose your role...</option>
                        <option value="STUDENT">🎓 Student - Learn from expert instructors</option>
                        <option value="INSTRUCTOR">👨‍🏫 Instructor - Share your knowledge</option>
                    </select>
                    <div class="error" id="userRoleError">Please select a role</div>
                </div>

                <!-- Student Specific Fields -->
                <div id="studentSection" class="role-specific-section">
                    <div class="section-title">Student Information</div>

                    <div class="form-group">
                        <label for="bio">Bio / About You <span class="required">*</span></label>
                        <textarea id="bio" name="bio" class="form-control"
                            placeholder="Tell us about yourself, your interests, and learning goals..."
                            rows="4"></textarea>
                        <div class="error" id="bioError">Please provide a brief bio</div>
                    </div>
                </div>

                <!-- Instructor Specific Fields -->
                <div id="instructorSection" class="role-specific-section">
                    <div class="section-title">Instructor Information</div>

                    <div class="form-group">
                        <label for="expertise">Area of Expertise <span class="required">*</span></label>
                        <input type="text" id="expertise" name="expertise" class="form-control"
                            placeholder="e.g., Web Development, Data Science, Digital Marketing" />
                        <div class="error" id="expertiseError">Area of expertise is required</div>
                    </div>

                    <div class="form-group">
                        <label for="instructorBio">Professional Bio <span class="required">*</span></label>
                        <textarea id="instructorBio" name="instructorBio" class="form-control"
                            placeholder="Describe your professional background, experience, and teaching philosophy..."
                            rows="5"></textarea>
                        <div class="error" id="instructorBioError">Professional bio is required</div>
                    </div>
                </div>

                <button type="submit" class="submit-btn" id="submitBtn">
                    <div class="loading-spinner" id="loadingSpinner"></div>
                    <span id="submitText">Create Account</span>
                </button>
            </form>

            <div class="login-link">
                Already have an account? <a href="login">Sign in here</a>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            const API_BASE_URL = 'http://localhost:8080/Secure-Online-Learning-Platform';
            const REGISTRATION_ENDPOINT = API_BASE_URL + '/auth/register';

            function showRoleSpecificSection() {
                const role = document.getElementById('userRole').value;
                const studentSection = document.getElementById('studentSection');
                const instructorSection = document.getElementById('instructorSection');

                if (role === 'STUDENT') {
                    studentSection.classList.add('show');
                    instructorSection.classList.remove('show');
                } else if (role === 'INSTRUCTOR') {
                    instructorSection.classList.add('show');
                    studentSection.classList.remove('show');
                } else {
                    studentSection.classList.remove('show');
                    instructorSection.classList.remove('show');
                }
            }

            function closeAlert() {
                const alertBox = document.getElementById('alertMessage');
                alertBox.style.display = 'none';
            }

            $(document).ready(function () {
                // Clear errors on input
                $('#registrationForm input, #registrationForm select, #registrationForm textarea').on('input change', function () {
                    $(this).removeClass('error-input success-input');
                    $('#' + this.id + 'Error').hide();
                    $('#alertMessage').hide();
                });

                $('#registrationForm').on('submit', function (e) {
                    e.preventDefault();

                    let valid = true;

                    const fullName = $('#fullName');
                    const email = $('#email');
                    const password = $('#password');
                    const confirmPassword = $('#confirmPassword');
                    const userRole = $('#userRole');
                    const bio = $('#bio');
                    const expertise = $('#expertise');
                    const instructorBio = $('#instructorBio');

                    function setError(inputElem, message) {
                        inputElem.addClass('error-input');
                        $('#' + inputElem.attr('id') + 'Error').text(message).show();
                        valid = false;
                    }
                    function clearError(inputElem) {
                        inputElem.removeClass('error-input').addClass('success-input');
                        $('#' + inputElem.attr('id') + 'Error').hide();
                    }

                    // Full name validation
                    if (!fullName.val().trim()) {
                        setError(fullName, 'Full name is required');
                    } else {
                        clearError(fullName);
                    }

                    // Email validation
                    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!email.val().trim() || !emailPattern.test(email.val())) {
                        setError(email, 'Valid email is required');
                    } else {
                        clearError(email);
                    }

                    // Password validation
                    if (password.val().length < 8) {
                        setError(password, 'Password must be at least 8 characters');
                    } else {
                        clearError(password);
                    }

                    // Confirm password validation
                    if (confirmPassword.val() !== password.val()) {
                        setError(confirmPassword, 'Passwords must match');
                    } else {
                        clearError(confirmPassword);
                    }

                    // Role validation
                    if (!userRole.val()) {
                        setError(userRole, 'Please select a role');
                    } else {
                        clearError(userRole);
                    }

                    // Role-specific validations
                    if (userRole.val() === 'STUDENT') {
                        if (!bio.val().trim()) {
                            setError(bio, 'Please provide a brief bio');
                        } else {
                            clearError(bio);
                        }
                    }
                    if (userRole.val() === 'INSTRUCTOR') {
                        if (!expertise.val().trim()) {
                            setError(expertise, 'Area of expertise is required');
                        } else {
                            clearError(expertise);
                        }
                        if (!instructorBio.val().trim()) {
                            setError(instructorBio, 'Professional bio is required');
                        } else {
                            clearError(instructorBio);
                        }
                    }

                    if (!valid) return;

                    // Disable submit and show loading spinner
                    $('#submitBtn').attr('disabled', true);
                    $('#loadingSpinner').show();
                    $('#submitText').text('Creating...');

                    // ✅ CORRECTED: Prepare data with nested objects
                    const role = userRole.val();
                    const data = {
                        fullName: fullName.val().trim(),
                        email: email.val().trim(),
                        password: password.val(),
                        role: role
                    };

                    // Add role-specific nested objects
                    if (role === 'STUDENT') {
                        data.student = {
                            bio: bio.val().trim()
                        };
                    } else if (role === 'INSTRUCTOR') {
                        data.instructor = {
                            areaOfExpertise: expertise.val().trim(),
                            professionalBio: instructorBio.val().trim()
                        };
                    }

                    console.log('Sending payload:', JSON.stringify(data, null, 2)); // Debug log

                    // AJAX POST request
                    $.ajax({
                        url: REGISTRATION_ENDPOINT,
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(data),
                        success: function (response) {
                            $('#loadingSpinner').hide();
                            $('#submitBtn').attr('disabled', false);
                            $('#submitText').text('Create Account');

                            // Handle success (response might be the User object directly)
                            $('#alertMessage').removeClass('error').addClass('alert success').show();
                            $('#alertText').text('Account created successfully! Redirecting to login...');
                            setTimeout(function () {
                                window.location.href = 'login';
                            }, 2000);
                        },
                        error: function (xhr) {
                            $('#loadingSpinner').hide();
                            $('#submitBtn').attr('disabled', false);
                            $('#submitText').text('Create Account');
                            $('#alertMessage').removeClass('success').addClass('alert error').show();

                            let errMsg = 'Error occurred during registration, please try again.';
                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errMsg = xhr.responseJSON.message;
                            } else if (xhr.responseText) {
                                errMsg = xhr.responseText;
                            }

                            console.error('Registration error:', xhr); // Debug log
                            $('#alertText').text(errMsg);
                        }
                    });
                });
            });

        </script>
    </body>

    </html>