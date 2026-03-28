<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Docker Java App</title>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --bg: #f8fafc;
            --surface: #ffffff;
            --text: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            line-height: 1.5;
            margin: 0;
            padding: 2rem;
            display: flex;
            justify-content: center;
        }
        .container {
            background: var(--surface);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            width: 100%;
            max-width: 600px;
        }
        h2 { margin-top: 0; color: var(--text); }
        h3 { 
            color: var(--text-muted); 
            font-size: 1.1rem; 
            border-bottom: 1px solid var(--border); 
            padding-bottom: 0.5rem; 
        }
        .error {
            background: #fee2e2; 
            color: #991b1b; 
            padding: 0.75rem; 
            border-radius: 6px; 
            font-weight: 500; 
            font-size: 0.9rem; 
            margin-bottom: 1rem;
        }
        form { 
            display: flex; 
            gap: 0.5rem; 
            margin-bottom: 2rem; 
        }
        input[type="text"] {
            flex: 1; 
            padding: 0.75rem 1rem; 
            border: 1px solid var(--border); 
            border-radius: 6px; 
            font-size: 1rem; 
            transition: border-color 0.15s, box-shadow 0.15s;
        }
        input[type="text"]:focus { 
            outline: none; 
            border-color: var(--primary); 
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1); 
        }
        button {
            background: var(--primary); 
            color: white; 
            border: none; 
            padding: 0.75rem 1.5rem; 
            border-radius: 6px; 
            font-weight: 600; 
            cursor: pointer; 
            transition: background-color 0.15s;
        }
        button:hover { background: var(--primary-hover); }
        ul { 
            list-style: none; 
            padding: 0; 
            margin: 0; 
            display: flex; 
            flex-direction: column; 
            gap: 0.5rem; 
        }
        li { 
            background: var(--bg); 
            padding: 1rem; 
            border-radius: 6px; 
            border: 1px solid var(--border); 
            font-size: 0.95rem; 
        }
        .empty { color: var(--text-muted); font-style: italic; }
    </style>
</head>
<body>
    <div class="container">
        <h2>System Log</h2>
        
        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error"><b>Error:</b> <%= error %></div>
        <% } %>

        <form action="messages" method="POST">
            <input type="text" name="content" placeholder="Enter a message..." required>
            <button type="submit">Submit</button>
        </form>

        <h3>Messages from MySQL</h3>
        <ul>
            <% List<String> messages = (List<String>) request.getAttribute("messages");
               if (messages != null && !messages.isEmpty()) {
                   for (String msg : messages) { %>
                       <li><%= msg %></li>
            <%     }
               } else { %>
                   <div class="empty">No messages found in the database.</div>
            <% } %>
        </ul>
    </div>
</body>
</html>