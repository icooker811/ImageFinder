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
        <link rel="stylesheet" type="text/css" href="css/SyntaxHighlighter.css" />
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/styletable.jquery.plugin.js"></script>

        <script language="JavaScript">
            function chkConfirm(name)
            {

                if (confirm('Do you want to delete username : ' + name) == true)
                {

                    window.location = 'deleteuser.jsp?username=' + name;
                }

            }
            $(function() {

                $('table#table2').styleTable({
                    th_bgcolor: '#3E83C9',
                    th_color: '#ffffff',
                    th_border_color: '#333333',
                    tr_odd_bgcolor: '#ECF6FC',
                    tr_even_bgcolor: '#ffffff',
                    tr_border_color: '#95BCE2',
                    tr_hover_bgcolor: '#BCD4EC'
                });


            });
        </script>
    </head>


    <body >
        <h1>User Setting</h1><br /><br />

        <div id="footer-content1">
            <div id="fbox2">
                <fieldset id="field1">
                    <br/>
                    <a href="register.jsp" ><div style="padding-left: 10px;padding-bottom: 10px;border: 0px black solid;"><img style="width:30px;padding-right: 5px;"  src="./images/bg_add.png" border="0">New Admin</div></a>
                    <br/>
                    <table id="table2" border="0" cellpadding="4" cellspacing="0" align="center" width="100%">






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
                            String sql = "select * from user ";

                            ResultSet myresult = statement.executeQuery(sql);
                            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                            out.println("<tr><td ><center><h3>Admin</h3></center></td><td ><center><h3>Password</h3></center></td></tr>");
                            while (myresult.next()) {

                                out.println("<tr><td>" + myresult.getString("username") + "</td><td>" + myresult.getString("password") + "</td>");
                                if (!myresult.getString("username").equalsIgnoreCase(myCookie.getValue())) {
                        %>
                        <td align="center"><a href="#" onclick="chkConfirm('<%out.print(myresult.getString("username"));%>');return false;" ><img src="./images/publish_r.png" border="0"></a></td>

                        <%
                                    out.println("</tr>");
                                }
                            }
                            // out.println("</table>");
%>



                    </table>
                </fieldset></div></div>
    </body>
</html>
