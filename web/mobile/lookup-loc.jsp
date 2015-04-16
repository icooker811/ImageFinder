<%-- 
    Document   : index
    Created on : Jun 2, 2014, 1:35:52 PM
    Author     : tuck
--%>

<%@page import="java.sql.ResultSet"%>
<%@include file="../connectdb.jsp"%>
<%@page import="servlets.Block"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css">
        <link rel="stylesheet" href="../css/jqm-demos.css">
        <script src="../js/jquery-1.7.1.min.js"></script>
        <script src="../js/jquery.mobile-1.3.2.min.js"></script>
        <style>
            /**** Trying to style h1 and paragraph *******/
            .Header {
                color:#cc0000;
            }

            .Paragraph {
                color:#333;
                overflow:show;
                text-overflow:clip;
                white-space:normal;
                height:28px;
                margin-bottom:0px;
            }
        </style>
    </head>
    <body >
        <div data-role="header">
            <h1>CPE CMU Matching</h1>
            <a href="lookup-map.jsp" data-icon="back">Back</a>
            <a href="index.jsp" data-icon="home">Home</a>
        </div>

        <div data-role="content" >
            <h2 id="list-inset">Look Up</h2>
            <p>2. Choose your location</p>
            <p>Map : <% out.print(request.getParameter("mapid"));%></p>
            <div data-demo-html="true">
                <ul data-role="listview" data-inset="true"  data-theme="c" data-dividertheme="a">
                    <li data-role="list-divider">Your location</li>
                        <%                            String sql = "select polygonid , detail from polygon where mapid ='" + request.getParameter("mapid") + "' ";
                            // out.print(sql);
                            ResultSet myresult = statement.executeQuery(sql);
                            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                            while (myresult.next()) {

                                    // if (!myresult.getString("name").equalsIgnoreCase("zone")) {
                                //   }
                                out.println("<li><a href=\"lookup-des.jsp?mapid=" + request.getParameter("mapid") + "&loc=" + myresult.getString("polygonid") + "\"><img style=\"margin-left:10px;\" width=\"100px\" height=\"100px\"src=\"../images/marker_1.png\">  <h1 class=\"Header\">" + myresult.getString("polygonid") + "</h1><p class=\"Paragraph \">" + myresult.getString("detail") + "</p> </a></li>");
                            }

                   //out.println("</table>");
%>
                </ul>

            </div>
        </div>

        <!--<div data-role="footer">
            <h4>Copyright &copy; Computer Engineering, Chiang Mai University</h4>
        </div>-->
    </body>
</html>
