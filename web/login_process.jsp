<%-- 
    Document   : login
    Created on : Sep 12, 2012, 9:55:43 PM
    Author     : Tuk
--%>
<%@include file="connectdb.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CPE matching Image Retrieval |  Web Application</title>
        <link href="css/default.css" rel="stylesheet" type="text/css" />
        <script>
            function formSubmit()
            {
                document.getElementById("myform").submit();
            }
        </script>
    </head>


    <body >

        <div id="wrapper">
            <div id="footer-wrapper">
                <table border="0" align="center" cellpadding="0" cellspacing="0" id="table_01">

                    <tr>
                        <td   colspan="14" align="center" valign="middle" class="text2"><br/><br />
                            <div id="footer-content">




                                <%@page import="java.sql.*" %>

                                <%

                                    String user = request.getParameter("id");
                                    String password = request.getParameter("password");
                                   
                                   
                                     String sql = "select * from user where username =\"" + user + "\"and password =\"" + password + "\"";

                                     ResultSet myresult = statement.executeQuery(sql);
                                     //            while (myresult.next()) {
                                     //                out.println(myresult.getString("name") + "<br>");
                                     //            }
                                   
                                    if (myresult.next()) {
                                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy HH.mm.ss.SSSSSSSSS a");
                                        Calendar cal = Calendar.getInstance();
                                        String output = sdf.format(cal.getTime());
                                        //out.println(output);
                                        Cookie cookie = new Cookie("username", myresult.getString("username"));
                                        cookie.setMaxAge(365 * 24 * 60 * 60);
                                        response.addCookie(cookie);

                                       // out.println(" <fieldset><br/><h2>Login successful :: " + "admin" + "</h2><br/>");





                                %>



                                <form id="myform" name="myform" action="admin.jsp"name="send" method="POST">
                                 <!--  <a class="button large gray" onclick="formSubmit()" href="#"><span>Next</span></a>-->
                                </form><br/></fieldset>

                                <%


                                } else {
                                    // out.println("Incorrect username or password");

                                %>
                                <fieldset><br/>
                                
                                    <form id="myform" name="myform" action="login.jsp"name="send" method="POST">
                                      <!--     <a class="button large gray" onclick="formSubmit()" href="#"><span>Back</span></a>-->
                                    </form><br/>
                                </fieldset>
                                <%                        }

                                    // myresult.close();
%>


                            </div>
                        </td> </tr>
                </table>
                <script>document.getElementById("myform").submit();</script>
            </div>
        </div>
    </body>
</html>