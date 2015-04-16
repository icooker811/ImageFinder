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

                        
                        String zoneid = request.getParameter("zoneid");
                        String mapid = request.getParameter("mapid");
                        
                        Connection connection;
                        Statement statement;
                        String sourceURL = "jdbc:mysql://localhost:3306/photo?user=root";
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(sourceURL);
                        statement = connection.createStatement();
                       // out.print(name);
                      
                        String sql1 = "DELETE FROM zone WHERE zoneid =\""+zoneid+"\" AND mapid =\""+mapid+"\" ";
                        int rs = statement.executeUpdate(sql1);
                     
                    %>
                   
                        <form id="myform" name="myform" action="zoneedit.jsp?mapid=<%out.print(request.getParameter("mapid"));%>"name="send" method="POST">
                           
                        </form>
                    
                    <script>
                        alert("Successful");
                      document.getElementById("myform").submit();
                    </script>
                </td> </tr>
        </table>
    </body>
</html>
