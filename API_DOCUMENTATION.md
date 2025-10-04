# Secure Online Learning Platform - API Documentation

## Overview
This is a comprehensive REST API for a secure online learning platform built with Spring MVC, Hibernate, PostgreSQL, and JWT authentication.

## Authentication
All endpoints (except `/auth/*` and `/register`) require JWT authentication via the `Authorization: Bearer <token>` header.

## Base URL
```
http://localhost:8080/Secure-Online-Learning-Platform
```

## API Endpoints

### Authentication Endpoints

#### POST `/auth/login`
Authenticate user and get JWT token.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123",
  "role": "STUDENT" // or "INSTRUCTOR"
}
```

**Response:**
```json
{
  "status": "success",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "role": "STUDENT"
}
```

#### POST `/auth/register`
Register a new user.

**Request Body:**
```json
{
  "fullName": "John Doe",
  "email": "john@example.com",
  "password": "SecurePass123!",
  "role": "STUDENT",
  "student": {
    "bio": "I love learning new technologies"
  }
}
```

**Response:**
```json
{
  "userId": 1,
  "fullName": "John Doe",
  "email": "john@example.com",
  "role": "STUDENT"
}
```

#### GET `/auth/user/me`
Get current user information.

**Response:**
```json
{
  "email": "john@example.com",
  "fullName": "John Doe",
  "role": "STUDENT"
}
```

### Course Management Endpoints

#### POST `/courses/create`
Create a new course (Instructor only).

**Request Body:**
```json
{
  "title": "Introduction to Java",
  "description": "Learn Java programming from scratch",
  "category": "Programming",
  "difficulty": "Beginner",
  "contentPath": "/uploads/courses/java-intro.pdf"
}
```

#### GET `/courses/list`
Get all available courses.

**Response:**
```json
[
  {
    "courseId": 1,
    "title": "Introduction to Java",
    "description": "Learn Java programming from scratch",
    "category": "Programming",
    "difficulty": "Beginner",
    "contentPath": "/uploads/courses/java-intro.pdf",
    "createdAt": "2024-01-15T10:30:00",
    "instructorId": 2,
    "instructorName": "Jane Smith",
    "enrollmentCount": 15
  }
]
```

#### GET `/courses/{courseId}`
Get course by ID.

#### PUT `/courses/{courseId}`
Update course (Instructor owner only).

#### DELETE `/courses/{courseId}`
Delete course (Instructor owner only).

#### GET `/courses/instructor/my-courses`
Get courses created by current instructor.

#### GET `/courses/category/{category}`
Filter courses by category.

#### GET `/courses/difficulty/{difficulty}`
Filter courses by difficulty.

#### GET `/courses/filter?category=Programming&difficulty=Beginner`
Filter courses by multiple criteria.

#### GET `/courses/search?title=java`
Search courses by title.

### Enrollment Endpoints

#### POST `/enrollments/enroll`
Enroll in a course (Student only).

**Request Body:**
```json
{
  "courseId": 1
}
```

**Response:**
```json
{
  "enrollmentId": 1,
  "studentId": 1,
  "courseId": 1,
  "enrolledAt": "2024-01-15T11:00:00",
  "status": "ACTIVE",
  "studentName": "John Doe",
  "courseTitle": "Introduction to Java",
  "progressPercentage": 0.0
}
```

#### GET `/enrollments/my-enrollments`
Get current student's enrollments.

#### GET `/enrollments/instructor/students`
Get enrollments for instructor's courses.

### Progress Tracking Endpoints

#### POST `/progress/add/{enrollmentId}`
Add progress for a course module.

**Request Body:**
```json
{
  "moduleId": "module-1",
  "completedPercent": 75.0,
  "notes": "Completed basic concepts"
}
```

#### GET `/progress/enrollment/{enrollmentId}`
Get all progress for an enrollment.

#### GET `/progress/enrollment/{enrollmentId}/overall`
Get overall progress percentage.

**Response:**
```json
{
  "enrollmentId": 1,
  "overallProgress": 65.5,
  "progressPercentage": "65.50%"
}
```

#### PUT `/progress/update/{progressId}`
Update progress entry.

#### GET `/progress/{progressId}`
Get specific progress entry.

#### DELETE `/progress/{progressId}`
Delete progress entry.

### File Upload Endpoints

#### POST `/upload/course-content`
Upload course content file (Instructor only).

**Request:** Multipart form data with `file` field.

**Response:**
```json
{
  "success": true,
  "filePath": "/uploads/instructors/2/courses/uuid-filename.pdf",
  "fileName": "course-material.pdf",
  "fileSize": 1024000
}
```

#### POST `/upload/profile-image`
Upload profile image.

**Request:** Multipart form data with `file` field (images only).

#### DELETE `/upload/file?filePath=/path/to/file`
Delete uploaded file.

## Error Responses

### 401 Unauthorized
```json
{
  "message": "Invalid email or password"
}
```

### 403 Forbidden
```json
{
  "message": "Access denied"
}
```

### 404 Not Found
```json
{
  "message": "Resource not found"
}
```

### 409 Conflict
```json
{
  "message": "Email address already exists"
}
```

## File Upload Specifications

### Supported File Types for Course Content:
- Documents: PDF, DOC, DOCX, PPT, PPTX, TXT
- Videos: MP4, AVI, MOV
- Archives: ZIP, RAR

### Supported File Types for Profile Images:
- Images: JPG, JPEG, PNG, GIF

### File Size Limits:
- Maximum file size: 100MB

## Security Features

1. **JWT Authentication**: All endpoints (except auth) require valid JWT token
2. **Role-based Access Control**: Different permissions for STUDENT and INSTRUCTOR roles
3. **File Upload Security**: File type validation and size limits
4. **Password Requirements**: Strong password validation
5. **SQL Injection Protection**: Hibernate ORM with parameterized queries

## Database Schema

### Users Table
- userId (Primary Key)
- fullName
- email (Unique)
- passwordHash
- role (INSTRUCTOR/STUDENT)

### Courses Table
- courseId (Primary Key)
- title
- description
- category
- difficulty
- contentPath
- createdAt
- instructor_id (Foreign Key)

### Enrollments Table
- enrollmentId (Primary Key)
- student_id (Foreign Key)
- course_id (Foreign Key)
- enrolledAt
- status (ACTIVE/COMPLETED)

### Progress Table
- progressId (Primary Key)
- enrollment_id (Foreign Key)
- moduleId
- completedPercent
- lastAccessedAt
- notes

## Usage Examples

### Complete Student Workflow:

1. **Register as Student:**
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/auth/register \
  -H "Content-Type: application/json" \
  -d '{"fullName":"John Doe","email":"john@example.com","password":"SecurePass123!","role":"STUDENT","student":{"bio":"Learning enthusiast"}}'
```

2. **Login:**
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"john@example.com","password":"SecurePass123!","role":"STUDENT"}'
```

3. **Browse Courses:**
```bash
curl -X GET http://localhost:8080/Secure-Online-Learning-Platform/courses/list \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

4. **Enroll in Course:**
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/enrollments/enroll \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"courseId":1}'
```

5. **Track Progress:**
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/progress/add/1 \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"moduleId":"module-1","completedPercent":50.0,"notes":"Halfway through"}'
```

### Complete Instructor Workflow:

1. **Register as Instructor:**
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/auth/register \
  -H "Content-Type: application/json" \
  -d '{"fullName":"Jane Smith","email":"jane@example.com","password":"SecurePass123!","role":"INSTRUCTOR","instructor":{"areaOfExpertise":"Java Programming","professionalBio":"Senior Java Developer with 10 years experience"}}'
```

2. **Create Course:**
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/courses/create \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Advanced Java","description":"Deep dive into Java","category":"Programming","difficulty":"Advanced","contentPath":"/uploads/courses/advanced-java.pdf"}'
```

3. **Upload Course Content:**
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/upload/course-content \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -F "file=@course-material.pdf"
```

4. **View Student Enrollments:**
```bash
curl -X GET http://localhost:8080/Secure-Online-Learning-Platform/enrollments/instructor/students \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```
