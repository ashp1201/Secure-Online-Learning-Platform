# Troubleshooting Guide - Authentication Issues

## Issue: HTTP Status 500 - Authentication is null

### Problem Description
The error occurs when trying to access protected endpoints because the `Authentication` parameter is null in controller methods.

### Root Cause
The JWT authentication filter is not properly setting the authentication context, or the security configuration is not correctly applied.

## Solutions

### 1. **Verify JWT Token Format**
Make sure you're sending the JWT token in the correct format:

```bash
# Correct format
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Wrong formats
Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Authorization: Bearer: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 2. **Test Authentication Step by Step**

#### Step 1: Register a User
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Test User",
    "email": "test@example.com",
    "password": "SecurePass123!",
    "role": "INSTRUCTOR",
    "instructor": {
      "areaOfExpertise": "Java",
      "professionalBio": "Test instructor"
    }
  }'
```

#### Step 2: Login and Get Token
```bash
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "SecurePass123!",
    "role": "INSTRUCTOR"
  }'
```

#### Step 3: Test Authentication with Token
```bash
# Use the token from step 2
curl -X GET http://localhost:8080/Secure-Online-Learning-Platform/test/auth \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE"
```

Expected response:
```json
{
  "status": "success",
  "authenticated": true,
  "username": "test@example.com",
  "authorities": ["ROLE_INSTRUCTOR"]
}
```

### 3. **Check Security Configuration**

Verify that the security configuration in `dispatcher-servlet.xml` is correct:

```xml
<!-- Security configuration -->
<security:http pattern="/auth/*" security="none"/>
<security:http pattern="/register" security="none"/>
<security:http pattern="/users/*" security="none"/>

<!-- Protect all other endpoints with JWT authentication -->
<security:http entry-point-ref="jwtAuthEntryPoint">
    <security:custom-filter ref="jwtFilter" position="PRE_AUTH_FILTER"/>
    <security:intercept-url pattern="/courses/**" access="hasRole('INSTRUCTOR') or hasRole('STUDENT')"/>
    <security:intercept-url pattern="/enrollments/**" access="hasRole('INSTRUCTOR') or hasRole('STUDENT')"/>
    <security:intercept-url pattern="/progress/**" access="hasRole('INSTRUCTOR') or hasRole('STUDENT')"/>
    <security:intercept-url pattern="/upload/**" access="hasRole('INSTRUCTOR') or hasRole('STUDENT')"/>
    <security:intercept-url pattern="/test/**" access="hasRole('INSTRUCTOR') or hasRole('STUDENT')"/>
    <security:csrf disabled="true"/>
</security:http>
```

### 4. **Debug JWT Filter**

Add debug logging to see what's happening in the JWT filter. Check the console output for:
- "Hello Filter" message (indicates filter is running)
- Email extraction from token
- User lookup from database

### 5. **Common Issues and Fixes**

#### Issue: Token not being sent
**Solution**: Make sure the Authorization header is included in the request.

#### Issue: Invalid token format
**Solution**: Ensure the token starts with "Bearer " (note the space).

#### Issue: Token expired
**Solution**: Login again to get a new token.

#### Issue: User not found in database
**Solution**: Verify the user exists and the email matches exactly.

#### Issue: Role mismatch
**Solution**: Check that the user's role in the database matches the expected role.

### 6. **Database Verification**

Check that the user exists in the database:

```sql
SELECT user_id, full_name, email, role FROM users WHERE email = 'test@example.com';
```

### 7. **Complete Working Example**

Here's a complete working example:

```bash
# 1. Register
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "John Instructor",
    "email": "john@instructor.com",
    "password": "SecurePass123!",
    "role": "INSTRUCTOR",
    "instructor": {
      "areaOfExpertise": "Java Programming",
      "professionalBio": "Senior Java Developer"
    }
  }'

# 2. Login (save the token from response)
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@instructor.com",
    "password": "SecurePass123!",
    "role": "INSTRUCTOR"
  }'

# 3. Create course (replace YOUR_TOKEN with actual token)
curl -X POST http://localhost:8080/Secure-Online-Learning-Platform/courses/create \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Java Fundamentals",
    "description": "Learn Java basics",
    "category": "Programming",
    "difficulty": "Beginner",
    "contentPath": "/uploads/java-fundamentals.pdf"
  }'
```

### 8. **Error Responses**

#### 401 Unauthorized
- Token missing or invalid
- Token expired
- User not found

#### 403 Forbidden
- User doesn't have required role
- Trying to access resource owned by another user

#### 500 Internal Server Error
- Authentication is null (configuration issue)
- Database connection problem
- Missing dependencies

### 9. **Logging Configuration**

Add logging to see what's happening:

```xml
<!-- Add to dispatcher-servlet.xml -->
<bean id="loggingFilter" class="org.springframework.web.filter.CommonsRequestLoggingFilter">
    <property name="includeClientInfo" value="true"/>
    <property name="includeQueryString" value="true"/>
    <property name="includePayload" value="true"/>
    <property name="maxPayloadLength" value="1000"/>
</bean>
```

### 10. **Quick Fix Checklist**

- [ ] JWT token is in correct format: `Bearer <token>`
- [ ] User exists in database
- [ ] User role is correct (INSTRUCTOR/STUDENT)
- [ ] Security configuration is correct
- [ ] JWT filter is properly configured
- [ ] Database connection is working
- [ ] All dependencies are included

If all these are correct and you're still getting the error, check the server logs for more detailed error information.
