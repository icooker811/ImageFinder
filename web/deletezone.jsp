<%-- 
    Document   : login
    Created on : Sep 12, 2012, 9:55:43 PM
    Author     : Tuk
--%>

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

                        Connection connection;
                        Statement statement;
                        String sourceURL = "jdbc:mysql://localhost:3306/Photo?user=root&password=tuktuk";
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(sourceURL);
                        statement = connection.createStatement();
                        // out.print(name);

                        String sql1 = "select name from photo where zone =\"" + name + "\" ";
                        ResultSet myresult = statement.executeQuery(sql1);
                        // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                        // out.println("<tr><td width=\"200\" ><center><h3>Email</h3></center></td><td width=\"200\"><center><h3>Password</h3></center></td><td width=\"200\"><center><h2></h2></center></td></tr>");
                        while (myresult.next()) {
                            //     if (!myresult.getString("email").equalsIgnoreCase("admin")) {
                            //       out.println("<tr><td>" + myresult.getString("email") + "</td><td>" + myresult.getString("password") + "</td><td><a herf=\"#\" OnClick=\"chkConfirm('" + myresult.getString("email") + "');\"><center>Delete</center></a></td></tr>");
                            //    }      
                            try {
                                // Create file 
                                FileWriter fstream = new FileWriter("/tmp/input/input1/" + myresult.getString("name") + ".txt");
                                BufferedWriter ou11 = new BufferedWriter(fstream);
                                ou11.write("");
                                //Close the output stream
                                ou11.close();
                            } catch (Exception e) {//Catch exception if any
                                System.err.println("Error: " + e.getMessage());
                            }
                        }
                        
                        String sql2 = "DELETE FROM photo WHERE zone =\"" + name + "\" ";
                        int rs2 = statement.executeUpdate(sql2);

                        String sql3 = "DELETE FROM zone WHERE zone =\"" + name + "\" ";
                        int rs3 = statement.executeUpdate(sql3);



                    %>
                    <fieldset>
                        <br/><h1>Successful</h1><br/>
                        <form id="myform" name="myform" action="zoneedit.jsp"name="send" method="POST">
                            <input type="submit" value="Back" name="submit" />
                        </form><br/>
                    </fieldset>
                </td> </tr>
        </table>
    </body>
</html>
