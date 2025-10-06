# Secure Online Learning Platform - Complete Documentation

## Project Overview

**Architecture**: Spring MVC + Hibernate (SessionFactory) + JWT Authentication  
**Purpose**: E-Learning platform with role-based access (Students & Instructors)  
**Database**: PostgreSQL with Hibernate ORM  
**Security**: JWT token-based authentication with role-based authorization  

***

## Entity Relationships

```
User (1) ←→ (0..1) Student
User (1) ←→ (0..1) Instructor  
Instructor (1) → (*) Course
Student (1) → (*) Enrollment
Course (1) → (*) Enrollment
Enrollment (1) → (*) Progress
```

***

## Complete API Endpoints Summary

### Authentication Endpoints (`/auth`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/auth/register` | User registration (Student/Instructor) | No |
| POST | `/auth/login` | User login with role validation | No |
| GET | `/auth/user/me` | Get current authenticated user details | Yes |

### Course Endpoints (`/courses`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/courses/create` | Create course | Yes (Instructor) |
| GET | `/courses/list` | Get all courses | Yes |
| GET | `/courses/search` | Search courses with filters (category, difficulty, title) | Yes |
| GET | `/courses/{id}` | Get course by ID | Yes |
| PUT | `/courses/{id}` | Update course | Yes (Instructor - own courses) |
| DELETE | `/courses/{id}` | Delete course | Yes (Instructor - own courses) |
| GET | `/courses/instructor/my-courses` | Get instructor's created courses | Yes (Instructor) |

### Enrollment Endpoints (`/enrollments`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/enrollments/enroll` | Enroll in a course | Yes (Student) |
| GET | `/enrollments/my-enrollments` | Get student's enrollments with course details | Yes (Student) |
| GET | `/enrollments/instructor/students` | Get students enrolled in instructor's courses | Yes (Instructor) |
| DELETE | `/enrollments/{enrollmentId}` | Withdraw from course (unenroll) | Yes (Student - own enrollments) |

### Progress Endpoints (`/progress`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/progress/update` | Update video watch progress | Yes (Student) |

### File Upload Endpoints (`/upload`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/upload/course-content` | Upload course video/materials | Yes (Instructor) |

### Video Streaming Endpoints (`/videos`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/videos/{courseId}/{filename}` | Stream course video content | No (Dev mode) |

> ⚠️ **Development Note**: Video streaming is currently public (`security="none"`) because browser `<video>` tags cannot send JWT headers. For production, implement secure streaming with enrollment verification.

***

## Postman Testing JSON Examples

### 1. Register Student

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/auth/register
Content-Type: application/json
```

**Request Body:**
```json
{
  "fullName": "John Doe",
  "email": "john.doe@example.com",
  "password": "Password@123",
  "role": "STUDENT",
  "student": {
    "bio": "Passionate learner interested in web development and data science"
  }
}
```

**Expected Response (200 OK):**
```json
{
  "userId": 1,
  "email": "john.doe@example.com",
  "fullName": "John Doe",
  "role": "STUDENT"
}
```

***

### 2. Register Instructor

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/auth/register
Content-Type: application/json
```

**Request Body:**
```json
{
  "fullName": "Dr. Sarah Smith",
  "email": "sarah.smith@example.com",
  "password": "SecurePass@456",
  "role": "INSTRUCTOR",
  "instructor": {
    "areaOfExpertise": "Web Development, JavaScript, React",
    "professionalBio": "10+ years of experience in full-stack development. Former lead developer at tech companies. Passionate about teaching modern web technologies."
  }
}
```

***

### 3. Login Student

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/auth/login
Content-Type: application/json
```

**Request Body:**
```json
{
  "email": "john.doe@example.com",
  "password": "Password@123",
  "role": "STUDENT"
}
```

**Expected Response (200 OK):**
```json
{
  "status": "success",
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqb2huLmRvZUBleGFtcGxlLmNvbSIsImV4cCI6MTczNTcwNjgwM30.xYz123...",
  "role": "STUDENT"
}
```

**💡 Important:** Save the token and use it in all subsequent requests:
```
Authorization: Bearer {token}
```

***

### 4. Login Instructor

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/auth/login
Content-Type: application/json
```

**Request Body:**
```json
{
  "email": "sarah.smith@example.com",
  "password": "SecurePass@456",
  "role": "INSTRUCTOR"
}
```

**Expected Response (200 OK):**
```json
{
  "status": "success",
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzYXJhaC5zbWl0aEBleGFtcGxlLmNvbSIsImV4cCI6MTczNTcwNjgwM30.aBc456...",
  "role": "INSTRUCTOR"
}
```

***

### 5. Get Current User Info

```http
GET http://localhost:8080/Secure-Online-Learning-Platform/auth/user/me
Authorization: Bearer {JWT_TOKEN}
```

**Expected Response (200 OK):**
```json
{
  "userId": 1,
  "email": "john.doe@example.com",
  "fullName": "John Doe",
  "role": "STUDENT",
  "bio": "Passionate learner interested in web development and data science"
}
```

***

### 6. Create Course (Instructor)

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/courses/create
Content-Type: application/json
Authorization: Bearer {INSTRUCTOR_JWT_TOKEN}
```

**Request Body:**
```json
{
  "title": "Complete Web Development Bootcamp",
  "description": "Learn HTML, CSS, JavaScript, React, Node.js, and MongoDB from scratch. Build real-world projects and deploy them to production.",
  "category": "Programming",
  "difficulty": "Beginner",
  "contentPath": null
}
```

**Available Categories:**
- Programming
- Design
- Business
- Marketing
- Data Science
- Personal Development

**Difficulty Levels:**
- Beginner
- Intermediate
- Advanced

**Expected Response (200 OK):**
```json
{
  "courseId": 1,
  "title": "Complete Web Development Bootcamp",
  "description": "Learn HTML, CSS, JavaScript...",
  "category": "Programming",
  "difficulty": "Beginner",
  "instructorId": 2,
  "instructorName": "Dr. Sarah Smith",
  "contentPath": null,
  "createdAt": "2025-10-06T10:30:00",
  "enrollmentCount": 0
}
```

> **Note:** `contentPath` is set after uploading course video via `/upload/course-content`

***

### 7. Upload Course Content (Instructor)

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/upload/course-content
Authorization: Bearer {INSTRUCTOR_JWT_TOKEN}
Content-Type: multipart/form-data
```

**Form Data:**
- `file`: [Select video/PDF file]
- `courseName`: "Complete Web Development Bootcamp"

**Accepted File Types:** `.pdf`, `.zip`, `.mp4`, `.avi`, `.mov`, `.pptx`  
**Max File Size:** 100MB

**Expected Response (200 OK):**
```json
{
  "success": true,
  "filePath": "C:\\uploads\\course-content\\sarah_smith_example_com\\Complete_Web_Development_Bootcamp\\uuid.mp4",
  "fileName": "intro_video.mp4",
  "fileSize": 52428800,
  "message": "File uploaded successfully"
}
```

> **💡 Tip:** Copy the `filePath` from response and update the course's `contentPath` via `PUT /courses/{id}`

***

### 8. Get All Courses

```http
GET http://localhost:8080/Secure-Online-Learning-Platform/courses/list
Authorization: Bearer {JWT_TOKEN}
```

**Expected Response (200 OK):**
```json
[
  {
    "courseId": 1,
    "title": "Complete Web Development Bootcamp",
    "description": "Learn HTML, CSS, JavaScript...",
    "category": "Programming",
    "difficulty": "Beginner",
    "instructorId": 2,
    "instructorName": "Dr. Sarah Smith",
    "contentPath": "C:\\uploads\\course-content\\...",
    "createdAt": "2025-10-06T10:30:00",
    "enrollmentCount": 25
  }
]
```

***

### 9. Search Courses (Unified Dynamic Search)

```http
GET http://localhost:8080/Secure-Online-Learning-Platform/courses/search?category=Programming&difficulty=Beginner&title=Web
Authorization: Bearer {JWT_TOKEN}
```

**Query Parameters (all optional):**
- `category` - Filter by category
- `difficulty` - Filter by difficulty level
- `title` - Search in course title (case-insensitive, partial match)

**Example Queries:**
```
/courses/search?category=Programming
/courses/search?difficulty=Beginner
/courses/search?category=Programming&difficulty=Beginner
/courses/search?title=web
/courses/search  (returns all courses)
```

**Technology:** Uses Hibernate Criteria API for dynamic query building with type-safe predicates.

***

### 10. Get Instructor's Courses

```http
GET http://localhost:8080/Secure-Online-Learning-Platform/courses/instructor/my-courses
Authorization: Bearer {INSTRUCTOR_JWT_TOKEN}
```

**Expected Response (200 OK):**
```json
[
  {
    "courseId": 1,
    "title": "Complete Web Development Bootcamp",
    "description": "Learn HTML, CSS, JavaScript...",
    "category": "Programming",
    "difficulty": "Beginner",
    "instructorId": 2,
    "instructorName": "Dr. Sarah Smith",
    "contentPath": "C:\\uploads\\...",
    "createdAt": "2025-10-06T10:30:00",
    "enrollmentCount": 15
  }
]
```

***

### 11. Enroll in Course (Student)

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/enrollments/enroll
Content-Type: application/json
Authorization: Bearer {STUDENT_JWT_TOKEN}
```

**Request Body:**
```json
{
  "courseId": 1
}
```

**Expected Response (200 OK):**
```json
{
  "enrollmentId": 10,
  "studentId": 1,
  "courseId": 1,
  "courseTitle": "Complete Web Development Bootcamp",
  "category": "Programming",
  "difficulty": "Beginner",
  "description": "Learn HTML, CSS, JavaScript...",
  "instructorName": "Dr. Sarah Smith",
  "contentPath": "C:\\uploads\\...",
  "enrolledAt": "2025-10-06T14:30:00",
  "status": "ACTIVE",
  "progressPercentage": 0.0
}
```

***

### 12. Get My Enrollments (Student)

```http
GET http://localhost:8080/Secure-Online-Learning-Platform/enrollments/my-enrollments
Authorization: Bearer {STUDENT_JWT_TOKEN}
```

**Expected Response (200 OK):**
```json
[
  {
    "enrollmentId": 10,
    "studentId": 1,
    "courseId": 1,
    "courseTitle": "Complete Web Development Bootcamp",
    "instructorName": "Dr. Sarah Smith",
    "category": "Programming",
    "difficulty": "Beginner",
    "description": "Learn HTML, CSS, JavaScript...",
    "contentPath": "C:\\uploads\\...",
    "enrolledAt": "2025-10-06T14:30:00",
    "status": "ACTIVE",
    "progressPercentage": 35.5
  }
]
```

***

### 13. Update Video Progress (Student)

```http
POST http://localhost:8080/Secure-Online-Learning-Platform/progress/update
Content-Type: application/json
Authorization: Bearer {STUDENT_JWT_TOKEN}
```

**Request Body:**
```json
{
  "enrollmentId": 10,
  "watchedPercent": 45.8
}
```

**Expected Response (200 OK):**
```json
{
  "success": true,
  "progress": 45.8
}
```

> **Note:** Progress is automatically tracked every 5 seconds while watching videos in the Student Dashboard.

***

### 14. Stream Course Video

```http
GET http://localhost:8080/Secure-Online-Learning-Platform/videos/1/uuid-filename.mp4
```

**Response:** Video stream (video/mp4)

> ⚠️ **Security Note:** Currently public access (no authentication required). The endpoint does NOT verify enrollment. For production, implement secure streaming with enrollment checks.

***

### 15. Get Students Enrolled in My Courses (Instructor)

```http
GET http://localhost:8080/Secure-Online-Learning-Platform/enrollments/instructor/students
Authorization: Bearer {INSTRUCTOR_JWT_TOKEN}
```

**Expected Response (200 OK):**
```json
[
  {
    "enrollmentId": 10,
    "studentId": 1,
    "studentName": "John Doe",
    "courseId": 1,
    "courseTitle": "Complete Web Development Bootcamp",
    "enrolledAt": "2025-10-06T14:30:00",
    "status": "ACTIVE",
    "progressPercentage": 45.8
  }
]
```

***

### 16. Update Course (Instructor)

```http
PUT http://localhost:8080/Secure-Online-Learning-Platform/courses/1
Content-Type: application/json
Authorization: Bearer {INSTRUCTOR_JWT_TOKEN}
```

**Request Body:**
```json
{
  "title": "Complete Web Development Bootcamp 2025",
  "description": "Updated course content with latest web technologies...",
  "category": "Programming",
  "difficulty": "Intermediate",
  "contentPath": "C:\\uploads\\..."
}
```

**Expected Response (200 OK):** Updated course object  
**Error Response (403 Forbidden):** Not the course owner

***

### 17. Delete Course (Instructor)

```http
DELETE http://localhost:8080/Secure-Online-Learning-Platform/courses/1
Authorization: Bearer {INSTRUCTOR_JWT_TOKEN}
```

**Expected Response (200 OK):** Empty body  
**Error Response (403 Forbidden):** Not the course owner

***

### 18. Withdraw from Course (Student) 🆕

```http
DELETE http://localhost:8080/Secure-Online-Learning-Platform/enrollments/10
Authorization: Bearer {STUDENT_JWT_TOKEN}
```

**Expected Response (200 OK):** Empty body or success message  
**Error Response (403 Forbidden):** Not the enrollment owner  
**Error Response (404 Not Found):** Enrollment not found

**Frontend Implementation:**
```javascript
function unenrollCourse(enrollmentId, courseTitle) {
    if (!confirm(`Are you sure you want to withdraw from "${courseTitle}"?`)) return;

    $.ajax({
        url: `/Secure-Online-Learning-Platform/enrollments/${enrollmentId}`,
        method: "DELETE",
        headers: { "Authorization": "Bearer " + authToken },
        success: function() {
            showAlert('Successfully withdrawn from course', 'success');
            loadEnrolledCourses();  // Refresh list
        },
        error: function(xhr) {
            showAlert('Failed to withdraw: ' + xhr.responseText, 'error');
        }
    });
}
```

***

## Validation & Exception Handling

### Bean Validation Annotations

#### User Entity Validations
- `@NotBlank(message="Full name is required")` - fullName
- `@NotBlank(message="Email is required")` + `@Email` - email
- `@Size(min=8, message="Password must be at least 8 characters")` - password
- `@NotNull(message="Role is required")` - role

#### Course Entity Validations
- `@NotBlank` + `@Size(min=3, max=200)` - title
- `@NotBlank` + `@Size(max=2000)` - description
- `@NotBlank` - category, difficulty

#### Student/Instructor Profile Validations
- `@NotBlank` - bio (Student)
- `@NotBlank` - areaOfExpertise, professionalBio (Instructor)

### Custom Business Validations

- **Role-based access control** - Controllers validate user roles before operations
- **JWT token validation** - JwtAuthenticationFilter validates and authenticates requests
- **Duplicate enrollment check** - Students cannot enroll in the same course twice
- **Course ownership validation** - Instructors can only modify/delete their own courses
- **Enrollment ownership validation** - Students can only withdraw from their own enrollments
- **File upload validation** - Only instructors can upload course content; file type and size restrictions apply

### HTTP Status Codes Used

| Code | Meaning | Usage |
|------|---------|-------|
| 200 | OK | Successful operations |
| 201 | Created | Successful resource creation |
| 400 | Bad Request | Validation errors |
| 401 | Unauthorized | Invalid/missing JWT token |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 409 | Conflict | Duplicate enrollment |
| 500 | Internal Server Error | Server errors |

***

## Security Implementation

### JWT Authentication Flow

1. User registers with role (Student/Instructor)
2. User logs in with email, password, and role
3. Backend validates credentials using Spring Security
4. JWT token generated with user email as subject
5. Token returned to client with **24-hour expiration**
6. Client stores token in **cookie** or localStorage
7. Subsequent requests include `Authorization: Bearer {token}` header
8. **JwtAuthenticationFilter** intercepts requests:
   - Extracts token from `Authorization` header
   - Validates token signature and expiration
   - Extracts email from token's `subject` claim
   - Loads user details from database
   - Creates `UserDetails` with email as username
   - Sets `Authentication` in `SecurityContext`
9. Controllers access authenticated user via `Authentication` parameter
10. `authentication.getName()` returns the user's **email**

### Role-Based Access Control

#### Student Role:
- Browse and search courses
- Enroll in courses
- Watch course videos
- Track learning progress
- View own enrollments
- **Withdraw from courses (unenroll)**

#### Instructor Role:
- Create courses
- Upload course content
- Update/delete own courses
- View students enrolled in their courses
- Cannot enroll in courses

### Security Configuration

```xml
<!-- Public endpoints (no authentication required) -->
<security:http pattern="/auth/login" security="none"/>
<security:http pattern="/auth/register" security="none"/>
<security:http pattern="/index" security="none"/>
<security:http pattern="/studentDashboard" security="none"/>
<security:http pattern="/instructorDashboard" security="none"/>
<security:http pattern="/videos/**" security="none"/> <!-- Dev only -->

<!-- Protected endpoints -->
<security:http entry-point-ref="jwtAuthEntryPoint" 
               create-session="stateless" 
               authentication-manager-ref="authenticationManager" 
               use-expressions="true">
    
    <security:custom-filter ref="jwtFilter" before="FORM_LOGIN_FILTER"/>
    
    <security:intercept-url pattern="/courses/**" access="isAuthenticated()"/>
    <security:intercept-url pattern="/enrollments/**" access="isAuthenticated()"/>
    <security:intercept-url pattern="/progress/**" access="isAuthenticated()"/>
    <security:intercept-url pattern="/upload/**" access="isAuthenticated()"/>
    <security:intercept-url pattern="/auth/user/me" access="isAuthenticated()"/>
    
    <security:csrf disabled="true"/>
</security:http>
```

***

## Database Design & Hibernate Features

### Key Hibernate Features Used

| Feature | Description | Purpose |
|---------|-------------|---------|
| **SessionFactory & Session Management** | Database connection pooling | Efficient database connections |
| **Criteria API** | Dynamic query building | Type-safe course search with optional filters |
| **HQL (Hibernate Query Language)** | Complex queries with joins | Database-independent queries |
| **JOIN FETCH** | Eager loading associations | **Prevents LazyInitializationException** |
| **Cascade Operations** | `CascadeType.ALL` | Auto-save/delete related entities |
| **Lazy/Eager Loading** | `FetchType.LAZY` / `FetchType.EAGER` | Optimized data loading |
| **Transaction Management** | HibernateUtil wrapper | Automatic commit/rollback |
| **Inheritance Mapping** | `JOINED` strategy | User-Student-Instructor hierarchy |

### Important Mappings

```java
// User ↔ Student/Instructor (One-to-One with Cascade)
@OneToOne(mappedBy="user", cascade=CascadeType.ALL)
private Student student;

// Course → Instructor (Many-to-One)
@ManyToOne(fetch=FetchType.LAZY)
@JoinColumn(name="instructor_id", nullable=false)
private User instructor;

// Enrollment → Student/Course (Many-to-One)
@ManyToOne(fetch=FetchType.LAZY)
@JoinColumn(name="student_id", nullable=false)
private User student;

// Course → Enrollments (One-to-Many)
@OneToMany(mappedBy="course", fetch=FetchType.LAZY)
@JsonIgnore  // Prevent infinite recursion
private List<Enrollment> enrollments;

// Enrollment → Progress (One-to-Many)
@OneToMany(mappedBy="enrollment", fetch=FetchType.LAZY)
private List<Progress> progressList;
```

### Critical Pattern: Avoiding LazyInitializationException

**Always use `JOIN FETCH` in DAO queries that populate DTOs:**

```java
@Override
public List<Course> searchCourses(String category, String difficulty, String title) {
    return hibernateUtil.executeReadOnly(session -> {
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Course> cq = cb.createQuery(Course.class);
        Root<Course> course = cq.from(Course.class);
        
        // ✅ Always fetch instructor to avoid LazyInitializationException
        course.fetch("instructor", JoinType.LEFT);
        
        // Build dynamic predicates...
        
        return session.createQuery(cq).getResultList();
    });
}
```

***

## Testing Workflow in Postman

1. **Register users** (Student and Instructor with different emails)
2. **Login** to get JWT tokens → Save tokens as Postman environment variables
3. **Create courses** as Instructor
4. **Upload course videos** as Instructor
5. **Browse and search courses** as Student
6. **Enroll in courses** as Student
7. **Stream videos and track progress** as Student
8. **View enrollments** from both Student and Instructor perspectives
9. **Withdraw from course** as Student
10. **Update/delete courses** as Instructor
11. **Test authorization** by accessing endpoints with wrong roles (should fail with 403)
12. **Test duplicate enrollment** prevention (should return 409)

***

## Frontend Pages Integration

### Cookie-Based Authentication

Both dashboards use cookies to store JWT tokens:

```javascript
// Store token after login
document.cookie = 'token=' + response.token + '; path=/; max-age=86400';

// Retrieve token
function getCookie(name) {
    const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    return match ? match[2] : null;
}

// Check authentication on page load
$(document).ready(function() {
    authToken = getCookie('token') || localStorage.getItem('authToken');
    if (!authToken) {
        alert('Please login first!');
        window.location.href = '/Secure-Online-Learning-Platform/login';
        return;
    }
    loadUserInfo();
});
```

### AJAX Request Pattern

```javascript
$.ajax({
    url: "/Secure-Online-Learning-Platform/courses/list",
    method: "GET",
    headers: { 
        "Authorization": "Bearer " + authToken 
    },
    success: function(data) {
        // Handle response
    },
    error: function(xhr) {
        if (xhr.status === 401) {
            alert('Session expired. Please login again.');
            window.location.href = '/Secure-Online-Learning-Platform/login';
        } else {
            console.error("Error:", xhr);
        }
    }
});
```

### Video Progress Auto-Tracking

```javascript
function trackVideoProgress(courseId, enrollmentId) {
    const video = document.getElementById(`video-${courseId}`);
    if (!video || !video.duration) return;
    
    const watchedPercent = (video.currentTime / video.duration) * 100;
    const now = Date.now();
    const lastUpdate = parseInt(video.dataset.lastUpdate || 0);
    
    // Update server every 5 seconds
    if (now - lastUpdate > 5000) {
        video.dataset.lastUpdate = now;
        updateProgress(enrollmentId, watchedPercent);
    }
}
```

***

## Project Setup

### Prerequisites
- Java 11 or higher
- Apache Tomcat 9.x
- PostgreSQL database
- Maven for dependency management

### Configuration

1. **Database Setup**
   ```sql
   CREATE DATABASE learning_platform;
   ```

2. **Update `hibernate.cfg.xml`**
   ```xml
   <property name="hibernate.connection.url">jdbc:postgresql://localhost:5432/learning_platform</property>
   <property name="hibernate.connection.username">your_username</property>
   <property name="hibernate.connection.password">your_password</property>
   ```

3. **Configure JWT Secret** (in `JwtUtil.java`)
   ```java
   private static final String SECRET = "YourSecureSecretKeyHere";
   ```

4. **Set Upload Directory** (in `FileUploadController.java`)
   ```java
   private static final String BASE_UPLOAD_PATH = "C:/uploads/course-content";
   ```

5. **Build and Deploy**
   ```bash
   mvn clean package
   # Deploy WAR to Tomcat webapps/
   ```

***

## Key Features Summary

### Instructor Features
✅ Register and login  
✅ Create courses with details  
✅ Upload course videos/materials  
✅ View all created courses  
✅ Edit/delete own courses  
✅ View enrolled students with progress  

### Student Features
✅ Register and login  
✅ Browse all courses  
✅ Search courses (by title, category, difficulty)  
✅ Enroll in courses  
✅ Watch course videos  
✅ Auto-tracked video progress (every 5 seconds)  
✅ View enrolled courses  
✅ View learning progress  
✅ **Withdraw from courses (unenroll)** 🆕  

### Security Features
✅ JWT-based authentication (24-hour expiration)  
✅ Role-based access control (Student/Instructor)  
✅ Cookie-based token storage  
✅ Secure file upload with validation  
✅ XSS prevention (HTML escaping)  
✅ CSRF protection disabled (stateless REST API)  

***

**Document Version:** 1.2  
**Last Updated:** October 6, 2025  
**Note:** Replace `{JWT_TOKEN}`, `{STUDENT_JWT_TOKEN}`, and `{INSTRUCTOR_JWT_TOKEN}` with actual tokens from login responses in all authenticated requests.
