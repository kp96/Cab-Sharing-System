<%-- 
    Document   : dashboard
    Created on : 29 Apr, 2015, 11:35:57 PM
    Author     : Krishna Kalubandi
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Dashboard</title>

        <style>
            body{
                border:2px dashed blue;
                padding:1%;
            }
            .f{
                font-family: 'Lobster',cursive;
                text-align: center;
            }
            #notification{
                margin-left: auto;
                margin-right: auto;
                width:90%;
                height:200px;
                background-color: #e0e0e0;
                border: 2px solid burlywood;
                padding:2%;
            }
            #request{
                margin-left: auto;
                margin-right: auto;
                width:90%;
                height:45%;
                padding:2%;
                border:2px solid aqua;
                background-color: cornsilk;
            }
            #fadd{
                padding:10px;
                margin-left:20%;
                visibility: hidden;
            }
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
        <script>
            function openForm() {
                document.getElementById("fadd").style.visibility = "visible";
            }
            function validate() {
                var pattern = /^[0-9]{2}-[0-9]{2}-[0-9]{4}$/gm;
                var date = document.forms["mf"]["date"].value;
                if (!pattern.test(date)) {
                    alert("Enter valid date format");
                    return false;
                }
                var timepattern = /^[0-9]{2}:[0-9]{2}$/gm;
                var time = document.forms["mf"]["time"].value;
                if (!timepattern.test(time)) {
                    alert("Enter valid time format");
                    return false;
                }
                return true;
            }
            
        </script>
    </head>
    <body>
        <% if (session.getAttribute("username") != null) {%>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/taxi", "root", "");%>
        <nav class="navbar">
            <ul>
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="everyone.jsp">Sharers</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>

        <h1 class="f">Hello <%=session.getAttribute("username")%> </h1> 
        <div id="notification">
            <h2 align="center" style="color:blue"><i>Your Notifications</i></h2>
            <ol>
                <%
                    PreparedStatement ps1 = con.prepareStatement("SELECT * FROM `notification`"
                            + "WHERE `touser`=?");
                    ps1.setString(1, session.getAttribute("username").toString());
                    ResultSet res2 = ps1.executeQuery();
                    while (res2.next()) {%>
                <%System.out.println("NIGGA");%>
                <li>User <%=res2.getString(4)%> messaged you "<%=res2.getString(3)%>". If you are 
                    interested contact him/her on <%=res2.getString(2)%>.</li>
                    <%}%>
            </ol>
        </div><br><br>
        <div id="request">
            <h2 align="center" style="color:blue"><i>Your cab requests</i></h2>
            <div class="available">

                <%PreparedStatement ps = con.prepareStatement("SELECT * FROM `request` WHERE "
                            + "`username`=?");
                    ps.setString(1, session.getAttribute("username").toString());
                    ResultSet res = ps.executeQuery();%>
                <table id="data" border="2" cellspacing=15 cellpadding="15" align="center">
                    <tr>
                        <th>Place</th>
                        <th>Date</th>
                        <th>Time</th>
                    </tr>

                    <%while (res.next()) {%>
                    <tr>
                        <td><%=res.getString(3)%></td>
                        <td><%=res.getString(4)%></td>
                        <td><%=res.getString(5)%></td>
                    </tr>


                    <%}%></table>
            </div>
            <div id="form"><br>
                <button onclick="openForm()" style="margin-left:40%">Add new request</button>
                <form id="fadd" action="store.jsp" name ="mf" method="get" onsubmit="return validate()" >
                    <b>Select station</b><br>
                    Chennai Airport:<input type="radio" name="opt1" value="ChennaiAirport"/>
                    Chennai Railway Station:<input type="radio" name="opt1" value="ChennaiRailwayStation"/>
                    Bangalore Airport:<input type="radio" name="opt1" value="BangaloreAirport"/>
                    Bangalore Railway Station:<input type="radio"  required name="opt1" value="BangaloreRailwayStattion"/><br><br>
                    Date: <input type="text" name="date" required placeholder="Format DD-MM-YYYY"/><br><br>
                    Time: <input type="text" name="time" required placeholder="24HR format"/><br><br>
                    <input type="submit" value="submit"/><br>
                </form>
            </div>
        </div>


        <%
            } catch (Exception e) {
                System.out.println(e);

            }
        %>
        <%} else {%>
        <h1 style="color:red">Session Expired please login in again</h1>
        <a href="login.html">Click here to login!</a>
        <%}%>
    </body>
</html>
