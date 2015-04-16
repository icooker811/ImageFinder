<%-- 
    Document   : login
    Created on : Sep 12, 2012, 9:55:43 PM
    Author     : Tuk
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CPE matching Image Retrieval |  Web Application</title>
     
 <link href="css/default.css" rel="stylesheet" type="text/css" />
    </head>


    <body >

        <table border="0" align="center" cellpadding="0" cellspacing="0" id="table_01">

            <tr>
                <td width="775"  colspan="14" align="center" valign="middle" class="text2"><br/><br />



                    <%@page import="java.sql.*" %>

                    <%

                        String cookieName = "username";
                        Cookie cookies[] = request.getCookies();
                        Cookie myCookie = null;
                        if (cookies != null) {
                            for (int i = 0; i < cookies.length; i++) {
                                if (cookies[i].getName().equals(cookieName)) {
                                    myCookie = cookies[i];
                                    break;
                                }
                            }
                        }

                        String user = request.getParameter("id");
                        String password = request.getParameter("password");
                        Connection connection;
                        Statement statement;
                        String sourceURL = "jdbc:mysql://localhost:3306/photo?user=root";
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(sourceURL);
                        statement = connection.createStatement();

                        if (!password.equalsIgnoreCase("")) {
                            String sql1 = "update user set username = \"" + user + "\", password = \"" + password + "\" where email = \"" + user + "\" ";
                            int rs = statement.executeUpdate(sql1);
                           
                        }
                        if (!user.equalsIgnoreCase(myCookie.getValue())) {
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy HH.mm.ss.SSSSSSSSS a");
                            Calendar cal = Calendar.getInstance();
                            String output = sdf.format(cal.getTime());
//out.println(output);
                            Cookie cookie = new Cookie("username", user);
                            cookie.setMaxAge(365 * 24 * 60 * 60);
                            response.addCookie(cookie);

                           

                        }
                    %>
                    <fieldset>
                        <br/><h1>Successful</h1><br/>
                        <form id="myform" name="myform" action="userset.jsp"name="send" method="POST">
                            <input type="submit" value="Back" name="submit" />
                        </form><br/>
                     </fieldset>
                </td> </tr>
        </table>
    </body>
</html>
