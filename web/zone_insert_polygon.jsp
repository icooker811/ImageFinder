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

        <form id="myform" name="myform" action="zoneedit.jsp?mapid=<%out.print(request.getParameter("mapid"));%>"name="send" method="POST">
                      
        </form>
        
        <table border="0" align="center" cellpadding="0" cellspacing="0" id="table_01">

            <tr>
                <td width="775"  colspan="14" align="center" valign="middle" class="text2"><br/><br />



                    <%@page import="java.sql.*" %>

                    <%
                        
                        String mapid = request.getParameter("mapid");
                        String name = request.getParameter("name");
                        String detail =  java.net.URLDecoder.decode( request.getParameter("detail"), "UTF-8");
                        String x = request.getParameter("x");
                        String y = request.getParameter("y");
                        String width = request.getParameter("width");
                        String height = request.getParameter("height");
                       
                        //out.print(detail);
                     
                        String sql = "select * from polygon where polygonid =\"" + name + "\" AND mapid ='"+mapid+"'";

                        ResultSet myresult = statement.executeQuery(sql);
                        //            while (myresult.next()) {
                        //out.println(myresult.getString("email") + "<br>");
                        //            }
                        if (!myresult.next()) {
                            String sql1 = "insert into polygon(polygonid,detail,x,y,width,height,mapid) values ( \"" + name + "\",\"" + detail + "\",\"" + x + "\",\"" + y + "\",\"" + width + "\",\"" + height + "\",\"" + mapid + "\")";
                            int rs = statement.executeUpdate(sql1);
                            /*
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yy HH.mm.ss.SSSSSSSSS a");
                            Calendar cal = Calendar.getInstance();
                            String output = sdf.format(cal.getTime());
//out.println(output);
                            Cookie cookie = new Cookie("username", user);
                            cookie.setMaxAge(365 * 24 * 60 * 60);
                            response.addCookie(cookie);
*/
                          //  out.println(" <script>alert('Successful');document.getElement</script>");


                    %>

                    <script>
                        alert('Successful');
                        document.getElementById("myform").submit();
                    </script>
                   
                    <%
                    } else {
                        // out.println("Incorrect username or password");
                     //   out.println("<fieldset><br/><h2>Username is already use.</h2><br/>");
                    %>


                   <script>
                       alert('polygon name is already use ');
                       document.getElementById("myform").submit();
                    </script>
                   
                   <%                        }
                        myresult.close();
                    %>


                </td> </tr>
        </table>
    </body>
</html>
