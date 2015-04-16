<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@include file="connectdb.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="css/fileuploader.css" rel="stylesheet" type="text/css"/>		
        <link href="css/default.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="js/fileuploader.js" type="text/javascript" charset="utf-8"></script>
        <script src="js/form-fun.jquery.js" type="text/javascript" charset="utf-8"></script> 
        <script>
            $(document).ready(function() {
                //   alert("sss");
                $('select[name=map]').change(function() {
                    //      var val1 = $('select[name=year]').val() ;
                    //       $('input[name=yearb]').val(val1);
                    // document.getElementById('room-print').submit(); createUploader
                    //   alert("sss");
                    document.getElementById('mapid').value = document.getElementById('map').value;
                    document.getElementById('mapchange').submit();
                });
            });
        </script>
        <title>CPE matching Image Retrieval |  Web Application</title>
    </head>
    <body>
        <%@page pageEncoding="UTF-8" language="java" import="java.sql.*"%> 
        <%@page contentType="text/html;charset=UTF-8"%> 



        <div id="footer-content1">


            <p>Back-end to Upload Picture to Server</p>
            <p>To upload a file, click on the button below. Drag-and-drop is supported in FF, Chrome.</p>
            <p>Progress-bar is supported in FF3.6+, Chrome6+, Safari4+</p>
            <br></br>

            <div id="file-uploader-upload">		
                <noscript>			
                    <p>Please enable JavaScript to use file uploader.</p>
                    <!-- or put a simple form for upload here -->
                </noscript>

            </div>
            <fieldset id="field1">
                <form action="#" method="post" enctype="multipart/form-data">

                    <font size="4"> map  ::: </font><select id="map" name="map">

                        <%

                            String mapid = "";

                            try {
                                if (request.getParameter("mapid").equalsIgnoreCase("")) {
                                    mapid = "map1";
                                } else {
                                    mapid = request.getParameter("mapid");
                                }
                            } catch (NullPointerException ex) {
                                mapid = "map1";
                            }

                            String sql__ = "select id ,name from map where id = '" + mapid + "'";

                            System.out.print(sql__);
                            ResultSet myresult___ = statement.executeQuery(sql__);
                            while (myresult___.next()) {
                                out.println("<option value=\"" + myresult___.getString("id") + "\">" + myresult___.getString("id") + "-" + myresult___.getString("name") + " </option>");
                            }
                            String sql1 = "select id ,name from map where id = any (select mapid from zone group by mapid)";
                            //   String sql1 = "select id ,name from map ";

                            ResultSet myresult1 = statement.executeQuery(sql1);
                            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                            // out.println("<tr><td width=\"200\" ><center><h3>Email</h3></center></td><td width=\"200\"><center><h3>Password</h3></center></td><td width=\"200\"><center><h2></h2></center></td></tr>");

                            //out.println("<option value=\"" + myresult1.getString("id") + "\">" + myresult1.getString("id") +"-"+myresult1.getString("name") + " </option>");

                            while (myresult1.next()) {

                                if (!myresult1.getString("id").equals(mapid)) {
                                    out.println("<option value=\"" + myresult1.getString("id") + "\">" + myresult1.getString("id") + "-" + myresult1.getString("name") + " </option>");
                                }

                            }

                        %>
                    </select>
                    <font size="4"> zone  ::: </font><select onchange="createUploader()" id="zone" name="zone">
                        <%
                            String sql = "select zoneid from zone where mapid='" + mapid + "'";

                            ResultSet myresult = statement.executeQuery(sql);
                            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                            // out.println("<tr><td width=\"200\" ><center><h3>Email</h3></center></td><td width=\"200\"><center><h3>Password</h3></center></td><td width=\"200\"><center><h2></h2></center></td></tr>");
                            while (myresult.next()) {

                                out.println("<option value=\"" + myresult.getString("zoneid") + "\">" + myresult.getString("zoneid") + " </option>");

                            }
                            //out.println("</table>");

                        %>


                    </select>
                </form>
            </fieldset>
            <form id="mapchange" action="#" method="post" >
                <input id="mapid" name="mapid" type="hidden" />
            </form>
            <script src="js/fileuploader.js" type="text/javascript"></script>
            <script>


            function createUploader() {

                var zone = document.getElementById('zone').value;
                var map = document.getElementById('map').value;
                var uploader = new qq.FileUploader({
                    element: document.getElementById('file-uploader-upload'),
                    action: 'ServerUploadServlet',
                    params: {zone1: zone, map1: map},
                    maxConnections: 1,
                    debug: true
                });

            }
            // in your app create uploader as soon as the DOM is ready
            // don't wait for the window to load  
            //   window.onload = createUploader;



            window.onload = createUploader;

            </script>  
            <!--<br/><fieldset><center>
                    ************* Please Verify And Update Your Photo DataBase In Photo Setting Page ************* 
                </center></fieldset>
        </div>
        <br/><br/>-->
    </body>
</html>
