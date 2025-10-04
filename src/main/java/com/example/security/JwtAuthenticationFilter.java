package com.example.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import com.example.service.UserService;
import com.example.entity.User;

/* 
 * JWT Authentication filter that validates JWT tokens on each request.
 * Extracts JWT from Authorization header and sets authentication in security context.
 */
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil = new JwtUtil();
    
    @Autowired
    private UserService userService;

    /* 
     * Filters incoming HTTP requests to validate JWT tokens.
     * Skips authentication for public endpoints like /auth/ and /register.
     * Sets security context if valid JWT token is present.
     * @param request HTTP servlet request containing headers and path
     * @param response HTTP servlet response for sending data back
     * @param filterChain Chain of filters to continue processing
     * @throws ServletException if servlet processing error occurs
     * @throws IOException if input/output error occurs
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
                                    throws ServletException, IOException {
    
        String path = request.getRequestURI();
        
        /* Skip JWT validation for public authentication endpoints */
        if (path.startsWith("/auth/") || path.startsWith("/register") || path.startsWith("/users/")) {
            filterChain.doFilter(request, response);
            return;
        }

        System.out.println("Hello Filter");
        String header = request.getHeader("Authorization");
        
        /* Extract and validate JWT token from Authorization header */
        if (header != null && header.startsWith("Bearer ")) {
            String token = header.substring(7);
            String email = jwtUtil.getEmail(token);
            System.out.println(email);
            
            /* Set authentication in security context if token is valid */
            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                if (jwtUtil.validateToken(token)) {
                    // Get user from database to get the actual role
                    User dbUser = userService.findByEmail(email);
                    if (dbUser != null) {
                        String role = dbUser.getRole();
                        UserDetails user = User.withUsername(email)
                                .password("")  // password not needed here
                                .roles(role)
                                .build();

                        UsernamePasswordAuthenticationToken auth =
                                new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
                        SecurityContextHolder.getContext().setAuthentication(auth);
                    }
                }
            }
        }

        filterChain.doFilter(request, response);
    }
}
