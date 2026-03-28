package com.app;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> messages = new ArrayList<>();
        
        try (Connection conn = DBManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT content FROM messages ORDER BY id DESC")) {
            
            while (rs.next()) {
                messages.add(rs.getString("content"));
            }
        } catch (Exception e) {
            request.setAttribute("error", "Database connection failed: " + e.getMessage());
        }
        
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String content = request.getParameter("content");
        
        if (content != null && !content.trim().isEmpty()) {
            try (Connection conn = DBManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement("INSERT INTO messages (content) VALUES (?)")) {
                
                pstmt.setString(1, content);
                pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/messages");
    }
}