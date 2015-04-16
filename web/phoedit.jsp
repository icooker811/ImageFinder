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
        <link href="css/highlight.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>
        <script language="JavaScript">
            $(document).ready(function() {
                //   alert("sss");
                $('select[name=map]').change(function() {
                    //      var val1 = $('select[name=year]').val() ;
                    //       $('input[name=yearb]').val(val1);
                    // document.getElementById('room-print').submit(); createUploader
                    //   alert("sss");
                    document.getElementById('mapid').value = document.getElementById('map').value;
                    document.getElementById('zoneid').value = "";
                    document.getElementById('mapchange').submit();
                });
                $('select[name=zone]').change(function() {
                    //      var val1 = $('select[name=year]').val() ;
                    //       $('input[name=yearb]').val(val1);
                    // document.getElementById('room-print').submit(); createUploader
                    //   alert("sss");
                    
                    document.getElementById('mapid').value = document.getElementById('map').value;
                    document.getElementById('zoneid').value = document.getElementById('zone').value;
                //    alert(document.getElementById('zone').value);
                    document.getElementById('mapchange').submit();
                });

            });
            function chkConfirm(name,zone,map)
            {

                if (confirm('Do you want to delete : ' + name) == true)
                {

                    window.location = 'deletepho.jsp?file=' + name+'&mapid='+map+'&zone='+zone;
                }

            }
        </script>
    </head>


    <body >
        <h1>Photo Setting</h1>

        <div id="footer-content1">
            <div id="fbox2">
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
                        <font size="4"> zone  ::: </font><select  id="zone" name="zone">
                            <%
                                String zoneid = "";

                                try {
                                    if (request.getParameter("zoneid").equalsIgnoreCase("")) {
                                        zoneid = "";
                                    } else {
                                      //  out.print(request.getParameter("zoneid"));
                                        zoneid = request.getParameter("zoneid");
                                        out.println("<option value=\"" + zoneid + "\">" + zoneid + " </option>");


                                    }
                                } catch (NullPointerException ex) {
                                    zoneid = "";
                                }


                                String sql2 = "select zoneid from zone where mapid ='" + mapid + "'";

                                ResultSet myresult = statement.executeQuery(sql2);
                                // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                                // out.println("<tr><td width=\"200\" ><center><h3>Email</h3></center></td><td width=\"200\"><center><h3>Password</h3></center></td><td width=\"200\"><center><h2></h2></center></td></tr>");
                                while (myresult.next()) {

                                    if (!myresult.getString("zoneid").equals(zoneid)) {
                                        if(zoneid.equals("")) zoneid =myresult.getString("zoneid");
                                        out.println("<option value=\"" + myresult.getString("zoneid") + "\">" + myresult.getString("zoneid") + " </option>");
                                    }
                                }
                                //out.println("</table>");

                            %>


                        </select>
                    </form>
                </fieldset>
                <br/>
                <form id="mapchange" action="#" method="get" >
                    <input id="mapid" name="mapid" type="hidden" />
                    <input id="zoneid" name="zoneid" type="hidden" />
                </form>
                <div class="pricing_table">





                    <%@page import="java.sql.*" %>

                    <%



                        String sql = "select * from newphoto where map= '" + mapid + "' AND zone='" + zoneid + "' ";

                        //  out.println(sql);
                        myresult = statement.executeQuery(sql);
                        // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                        //   out.println("<tr><td width=\"200\" ><center><h3>Name</h3></center></td><td width=\"200\"><center><h3>Zone</h3></center></td><td width=\"200\"><center><h2></h2></center></td><td width=\"200\"><center><h2></h2></center></td></tr>");

                        while (myresult.next()) {
                            if (!myresult.getString("name").equalsIgnoreCase("zone")) {

                                out.println("<ul>");
                                out.println("<li>" + myresult.getString("name") + "</li>");
                                out.println("<li><img src=\"server/" + myresult.getString("name") + "\" width='100' /></li>");
                                out.println("<li><a herf=\"#\" OnClick=\"chkConfirm('" + myresult.getString("name") + "','" + myresult.getString("zone") + "','" + myresult.getString("map") + "');\"><center>Delete</center></a></li>");
                                out.println("</ul>");
                            }
                        }
                        //out.println("</table>");

                    %>



                </div>
                </br>


            </div></div>

        <!--
              <center>
                  ************* Agree and Update Your Dataset Please Click !!!************* 
            
              <form action="catFile" method="post" enctype="multipart/form-data">
  
                  <input type="submit"  value="Update Dataset" />
  
  
              </form>
                    </center>-->
        <br/><br/>
    </body>
</html>
