<%-- 
    Document   : login
    Created on : Sep 12, 2012, 9:55:43 PM
    Author     : Tuk
--%>

<%@page import="java.io.File"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
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


                        String name = request.getParameter("file");
                        String mapid = request.getParameter("mapid");
                        String zoneid = request.getParameter("zone");

                        String DESTINATION_DIR_PATH = "server";

                        Connection connection;
                        Statement statement;
                        String sourceURL = "jdbc:mysql://localhost:3306/photo?user=root";
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(sourceURL);
                        statement = connection.createStatement();
                        // out.print(name);

                        //    String sql1 = "DELETE FROM newphoto WHERE name =\"" + name + "\" AND zone= '" + zoneid + "' AND map='" + mapid + "'";
                        //    int rs = statement.executeUpdate(sql1);

                        String path = request.getServletContext().getRealPath(DESTINATION_DIR_PATH);
                        // out.print(request.getServletContext().getRealPath(DESTINATION_DIR_PATH) );
                        try {
                            // Create file 
                            //   FileWriter fstream = new FileWriter("/home/tuk/TestFindMember/input/input2/" + name + ".txt");
                            //   BufferedWriter ou11 = new BufferedWriter(fstream);
                            //   ou11.write("");
                            //Close the output stream
                            //   ou11.close();

                            File f = new File(path + "/" + name);
                            File ff = new File(path + "/input/" + name + ".txt");
                            f.delete();
                            ff.delete();

                            String sql1 = "DELETE FROM newphoto WHERE name =\"" + name + "\" AND zone= '" + zoneid + "' AND map='" + mapid + "'";
                            int rs = statement.executeUpdate(sql1);

                            //      }

                            // out.print(sql1);


                        } catch (Exception e) {//Catch exception if any
                            System.err.println("Error: " + e.getMessage());
                        }

                    %>


                    <form id="myform" name="myform" action="phoedit.jsp?mapid=<%out.print(request.getParameter("mapid"));%>&zoneid=<%out.print(request.getParameter("zone"));%>"name="send" method="POST">

                    </form><br/>


                    <script>
                        alert('Successful');
                        document.getElementById("myform").submit();
                    </script>
                </td> </tr>
        </table>
    </body>
</html>
