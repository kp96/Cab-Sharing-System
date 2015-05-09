
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%try {

Class.forName("com.mysql.jdbc.Driver");
System.out.println("Done bro nigga");
try {
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taxi", "root", "");
    PreparedStatement ps = con.prepareStatement("INSERT INTO users VALUES (?,?,?)");
    ps.setString(1,request.getParameter("email"));
    ps.setString(2,request.getParameter("username"));
    ps.setString(3, request.getParameter("password"));
    ps.execute();
    %>
    <h1>User Registered Successfully</h1>
    <%
} catch (SQLException sql) {
    out.println(sql);
}

} catch (ClassNotFoundException cnfe) {
    out.println(cnfe);
}%>
</body>
</html>
