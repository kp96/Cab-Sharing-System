<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sharers</title>
        <script>
            function validateForm(){
                var x = document.forms["note"]["mobile"].value;
                var pattern = /\d{10}/i;
                if(pattern.test(x))
                    return true;
                else{
                    alert("Please enter valid mobile number");
                    return false;
                }
            }
        </script>
        <style>
            table{
                border-collapse: collapse;
                text-align: center;
            }
            th{
                background-color: yellow;
            }
            ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                overflow: hidden;
            }
            #form1{
                margin-top:10%;
                margin-left: 20%;
                margin-right: 20%;
                padding: 5%;
                border: 2px dashed red;
            }
            li {
                float: left;
            }

            a:link, a:visited {
                margin-left: 21%;
                display: block;
                width: 300px;
                font-weight: bold;
                color: #FFFFFF;
                background-color: #98bf21;
                text-align: center;
                padding: 4px;
                text-decoration: none;
                text-transform: uppercase;
            }

            a:hover, a:active {
                background-color: #7A991A;
            }
        </style>
    </head>
    <body>
        
        <% if (session.getAttribute("username") != null) {%>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/taxi", "root", "");
                Statement s = con.createStatement();
                ResultSet res = s.executeQuery("SELECT * FROM request");%>
                <nav class="navbar">
            <ul>
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="everyone.jsp">Sharers</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav><br><br>
        <table id="data" border="2" cellspacing=15 cellpadding="15" align="center">
            <tr>
                <th>ID</th>
                <th>UserName</th>
                <th>Place</th>
                <th>Date</th>
                <th>Time</th>
            </tr>

            <%while (res.next()) {%>
            <tr>
                <td><%=res.getString(1)%></td>
                <td><%=res.getString(2)%></td>
                <td><%=res.getString(3)%></td>
                <td><%=res.getString(4)%></td>
                <td><%=res.getString(5)%></td>
            </tr>


            <%}%></table><%
                } catch (Exception e) {
                    System.out.println(e);

                }
            %>

            <form id="form1" name="note" action="notify.jsp" method="get" onsubmit="return validateForm()">
            <h2>Ask any of your friend's to share a cab. Simply enter the id of the friend</h2>
            Message:  <input type="text" required name="message"/><br><br>
            Mobile No:<input type="int" required name="mobile"/><br><br>
            Unique id:(Can be seen from the table):<input type="int"  required name="id"/><br><br>
            <input type="submit" value="Ask Friend!"/><br>
        </form>
        <%} else {%>
        <h1 style="color:red">Session Expired please login in again</h1>
        <a href="login.html">Click here to login!</a>
        <%}%>
    </body>
</html>
