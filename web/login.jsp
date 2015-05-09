<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con =(Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/taxi", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT  * FROM users WHERE " +
                    "username = ? AND password = ?");
            ps.setString(1,request.getParameter("username"));
            ps.setString(2,request.getParameter("password"));
            ResultSet res = ps.executeQuery();
            if(res.first()){%>
            <h1>Logged In successfully</h1>
            <%
            session.setAttribute("username", request.getParameter("username"));
            %>
            <a href="dashboard.jsp">Click here or please while wait to redirect</a>
            <script>
                setTimeout(function(){
                self.location="dashboard.jsp"
            },2000);
            </script>
            <%}else{%>
            <h1>Login failed! Please check your username or password</h1>
            <%}
        }catch (Exception e){
            System.out.println(e);
            
        }
%>
</body>
</html>
