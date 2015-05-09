<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notification Sent</title>
    </head>
    <body>
        <% if (session.getAttribute("username") != null) {%>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/taxi", "root", "");
                String message = request.getParameter("message");
                String mobile = request.getParameter("mobile");
                String id = request.getParameter("id");
                String fromUser = session.getAttribute("username").toString();
                PreparedStatement p1 = con.prepareStatement("SELECT * FROM request WHERE `index`=?");
                p1.setString(1, id);
                ResultSet res = p1.executeQuery();
                res.first();
                String toUser = res.getString(2);
                PreparedStatement p2 = con.prepareStatement(
                "INSERT INTO `notification`(`touser`, `frommobile`, "
                        + "`message`, `fromuser`) VALUES (?,?,?,?)");
                p2.setString(1, toUser);
                p2.setString(2, mobile);
                p2.setString(3, message);
                p2.setString(4, fromUser);
                p2.execute();
                %>
                <h2 style="font-family: monospace">Message sent. Please wait while you are being redirected. 
                    Else <a href="everyone.jsp">Click here.</a></h2>
                <script>
                    setTimeout(function(){
                       self.location = "everyone.jsp"; 
                    },2000);
                </script>
            <% } catch (Exception e) {
                if(e.toString().equals("java.sql.SQLException: Illegal operation on empty result set."))
                    out.println("Invalid id please check again");

            }
        %>
        <%} else {%>
        <h1 style="color:red">Session Expired please login in again</h1>
        <a href="login.html">Click here to login!</a>
        <%}%>
    </body>
</html>
