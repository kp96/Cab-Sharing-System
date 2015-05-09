<%-- 
    Document   : store
    Created on : 30 Apr, 2015, 2:36:38 PM
    Author     : Krishna Kalubandi
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notification sent!</title>
    </head>
    <body>
        <% if (session.getAttribute("username") != null) {%>
        <%try {

                Class.forName("com.mysql.jdbc.Driver");
                System.out.println("Done bro nigga");
                try {
                    Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/taxi", "root", "");
                    PreparedStatement ps = con.prepareStatement("INSERT INTO `request`(`username`, `place`, `date`, `time`) "
                            + "VALUES (?,?,?,?)");
                    ps.setString(1, session.getAttribute("username").toString() );
                    ps.setString(2, request.getParameter("opt1"));
                    ps.setString(3, request.getParameter("date"));
                    ps.setString(4, request.getParameter("time"));
                    ps.execute();
        %>
        <h1>Added request successfully.<a href="dashboard.jsp">Please wait while you are being redirected</a> </h1>
        <script>
            setTimeout(function(){
                self.location="dashboard.jsp"
            },2000);
        </script>
        <%
                } catch (SQLException sql) {
                    out.println(sql);
                }

            } catch (ClassNotFoundException cnfe) {
                out.println(cnfe);
            }%>
            <%} else {%>
        <h1 style="color:red">Session Expired please login in again</h1>
        <a href="login.html">Click here to login!</a>
        <%}%>
    </body>
</html>
