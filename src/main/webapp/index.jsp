<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Docker Java App</title>
</head>
<body>
    <h2>System Log</h2>
    
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <p style="color:red;"><b>Error:</b> <%= error %></p>
    <% } %>

    <form action="messages" method="POST">
        <input type="text" name="content" placeholder="Enter a message..." required>
        <button type="submit">Submit</button>
    </form>

    <hr>
    <h3>Messages from MySQL:</h3>
    <ul>
        <% List<String> messages = (List<String>) request.getAttribute("messages");
           if (messages != null && !messages.isEmpty()) {
               for (String msg : messages) { %>
                   <li><%= msg %></li>
        <%     }
           } else { %>
               <p>No messages found in the database.</p>
        <% } %>
    </ul>
</body>
</html>