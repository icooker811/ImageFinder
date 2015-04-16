<%-- 
    Document   : login
    Created on : Sep 12, 2012, 9:55:43 PM
    Author     : Tuk
--%>



<%@include file="connectdb.jsp"%>
<%@page import="servlets.Block"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CPE matching Image Retrieval |  Web Application</title>
        <link href="css/default.css" rel="stylesheet" type="text/css" />
        <style>

            #zonemap {

                border-collapse:collapse
            }

            #zonemap td{
                font-size: 12px;
                width: 200px;
                text-align:  center;
            }

            #zonemap th{
                font-weight:bold;
                font-size: 18px;
                height: 30px;
                border: 1px solid black;
            }

            div.block {
                border: 1px solid black;
                position: absolute;
                text-align: center;
                text-justify:inter-word;
                cursor: pointer;
            }

            div.block_ {
                border: 1px solid black;
                position: absolute;
                text-align: center;
                text-justify:inter-word;

            }

            div.message_ {
                position: absolute;
                text-align: center;
                text-justify:inter-word;
            }

            div.boxactive {

                cursor: pointer;
                opacity: 0.7;

            } 

            .green {
                background-color: rgba(14,201,121,1);
            }
            .red {
                background-color: rgba(255,17,17,1);
                color: rgb(0,0,0);
            }
            .blue {
                background-color: rgba(3,184,252,1);
            }
            .orage {
                background-color: rgba(244,122,0,1);
            }
            .grey {
                background-color: rgba(148,141,141,1);
                color: rgb(255,255,128);
            }
            .brown {
                background-color: rgba(160,82,45,1);
            }

            .label {
                display: inline-block;
                width: 5em;
            }
            .inline_ {
                position: absolute;

                display:inline-block;
            }
            .left{
                width: 800px;
                margin-top: -57px;
            }
            .right{
                width: 280px;
                margin-left: 830px;
                margin-top: -57px;
                padding-right: 50px;
            }
            .slimbox{
                width: 20px;
                height: 20px; 
                border: 1px solid black;
                float:right;
            }
            .wrapper {display:table;}
            .cell {display:table-cell; vertical-align:middle;}
            #map_{
                margin-left: 10px;
                margin-right: 10px;
                width: 600px;
                height :500px;
                border: 1px dotted black;
                position: relative;
                display:inline-block;
                background: white;
            }


        </style>
        <script src="js/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script> 
        <script language="JavaScript">
            $(document).ready(function() {
                $('select[name=map]').change(function() {
                    //  alert("ss");
                    document.getElementById('mapid').value = document.getElementById('map').value;


                    document.getElementById('mapchange').submit();
                });
            });
            function chkConfirm(name)
            {

                if (confirm('Do you want to delete : ' + name) == true)
                {

                    window.location = 'deletezone.jsp?file=' + name;
                }


            }
             function delete_polygon(name,mapid)
            {

                if (confirm('Do you want to delete polygon_id : ' + name) == true)
                {

                    window.location = 'zone_delete_polygon.jsp?polygonid=' + name+"&mapid="+mapid;
                }


            }
              function delete_zone(name,mapid)
            {

                if (confirm('Do you want to delete zone: ' + name) == true)
                {

                    window.location = 'zone_delete_zone.jsp?zoneid=' + name+"&mapid="+mapid;
                }


            }
        </script>

    </head>


    <body >
        <h1>Zone Setting</h1>
        <br/>
        <form id="mapchange" action="#" method="get" >
            <input id="mapid" name="mapid" type="hidden" />
        </form>



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
                // String sql1 = "select id ,name from map where id = any (select mapid from zone group by mapid)";
                String sql1 = "select id ,name from map ";

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






        <%


            String sql = "select * from zone where mapid ='" + request.getParameter("mapid") + "'";
            // out.print(sql);
            ResultSet myresult = statement.executeQuery(sql);
            LinkedList<Block> listzone = new LinkedList<Block>();
            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
            while (myresult.next()) {

                Block j = new Block(myresult.getString("zoneid"), Integer.parseInt(myresult.getString("x")), Integer.parseInt(myresult.getString("y")), Integer.parseInt(myresult.getString("width")), Integer.parseInt(myresult.getString("height")));


                listzone.add(j);

                // if (!myresult.getString("name").equalsIgnoreCase("zone")) {
                //   }
            }



            //out.println("</table>");
        %>

        <%


            sql = "select * from polygon where mapid ='" + request.getParameter("mapid") + "'";
            // out.print(sql);
            myresult = statement.executeQuery(sql);
            LinkedList<Block> listpolygon = new LinkedList<Block>();
            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
            while (myresult.next()) {

                Block j = new Block(myresult.getString("polygonid"), Integer.parseInt(myresult.getString("x")), Integer.parseInt(myresult.getString("y")), Integer.parseInt(myresult.getString("width")), Integer.parseInt(myresult.getString("height")));


                listpolygon.add(j);

                // if (!myresult.getString("name").equalsIgnoreCase("zone")) {
                //   }
            }



            //out.println("</table>");
        %>

        <br/>

        <table>
            <tr>
                <td>
                    <div id ="map_">
                        <%
                            for (int i = 0; i < listzone.size(); i++) {
                                Block j = listzone.get(i);
                                out.println("<div ondblclick=\"delete_zone('"+j.name+"','"+mapid+"');return false;\" class=\"block red wrapper\" style=\"width:" + j.width + "px;height:" + j.height + "px;top:" + (j.y) + "px;left:" + j.x + "px;\"><div class=\"cell\"><h3>" + j.name + "</h3></div></div>");


                            }
                        %>
                        <%
                            for (int i = 0; i < listpolygon.size(); i++) {
                                Block j = listpolygon.get(i);
                                out.println("<div ondblclick=\"delete_polygon('"+j.name+"','"+mapid+"');return false;\" class=\"block grey wrapper\" style=\"width:" + j.width + "px;height:" + j.height + "px;top:" + (j.y) + "px;left:" + j.x + "px;\"><div class=\"cell\"><h3>" + j.name + "</h3></div></div>");


                            }
                        %>

                    </div>
                </td>

                <td>

                    <fieldset id="insert_" >
                        <h4>*********** Inserting new zone to map *****************</h4>
                        <form action="zone_insert_zone.jsp" method="post">
                            <input id="mapid" name="mapid" type="hidden" value="<%out.print(mapid);%>">

                            <table>
                                <tr>
                                    <td>zone : </td>
                                    <td><input type="text" id="zone" name="zone" value=""> </td>
                                </tr>
                                <tr>
                                    <td>x : </td>
                                    <td><input type="text" id="x" name="x" value=""> </td>
                                </tr>
                                <tr>
                                    <td>y : </td>
                                    <td><input type="text" id="y" name="y" value=""> </td>
                                </tr>
                                <tr>
                                    <td>width : </td>
                                    <td><input type="text" id="width" name="width" value=""> </td>
                                </tr>
                                <tr>
                                    <td>height : </td>
                                    <td><input type="text" id="height" name="height" value=""> </td>
                                </tr>
                                <tr height="10px"></tr>
                                <tr>
                                    <td colspan="2"><input type="submit"  value="Insert Zone " /></td>
                                </tr>

                            </table>
                        </form>
                    </fieldset>
                    <br/>
                    <fieldset id="insert_" >
                        
                        <h4>*********** Inserting new polygon to map *****************</h4>
                           <table>
                        <form id="polygonin_" action="zone_insert_polygon.jsp" method="post">
                            <input id="mapid" name="mapid" type="hidden" value="<%out.print(mapid);%>">

                         
                                <tr>
                                    <td>name : </td>
                                    <td><input type="text" id="name" name="name" value=""> </td>
                                </tr>
                                <tr>
                                    <td>detail : </td>
                                    <td><input type="text" id="detail_" name="detail_" value=""> </td>
                                    <td><input type="hidden" id="detail" name="detail" value=""> </td>
                                </tr>
                                <tr>
                                    <td>x : </td>
                                    <td><input type="text" id="x" name="x" value=""> </td>
                                </tr>
                                <tr>
                                    <td>y : </td>
                                    <td><input type="text" id="y" name="y" value=""> </td>
                                </tr>
                                <tr>
                                    <td>width : </td>
                                    <td><input type="text" id="width" name="width" value=""> </td>
                                </tr>
                                <tr>
                                    <td>height : </td>
                                    <td><input type="text" id="height" name="height" value=""> </td>
                                </tr>

                                <tr height="10px"></tr>

                                
                        </form>
                            <tr>
                                    <td colspan="2"><input type="submit"  onclick="document.getElementById('detail').value = encodeURIComponent(document.getElementById('detail_').value);
                document.getElementById('polygonin_').submit();return false;" value="Insert Polygon " /></td>
                                </tr>

                            </table>
                    </fieldset>
                            <br>
                    <h3>*** Double-click block on map preview for deleting it ***  </h3>
                </td>
                
            </tr>
        </table>



        <div id="footer-content1">
            <div id="fbox2">



                <!--
                 <table id="zonemap" border="3"  align="center" cellpadding="0" cellspacing="0" id="table_01">
                <%
                    out.println("<tr><th>code</th><th>x</th><th>y</th><th>width</th><th>height</th><th ></th></tr>");

                    for (int i = 0; i < listzone.size(); i++) {

                        Block j = listzone.get(i);

                        // if (!myresult.getString("name").equalsIgnoreCase("zone")) {
                        out.println("<tr><td>" + j.name + "</td><td>" + (j.x) + "</td><td>" + (j.y) + "</td><td>" + j.width + "</td><td>" + j.height + "</td><td><a herf=\"#\" OnClick=\"chkConfirm('" + j.name + "');\"><center>Delete</center></a></td></tr>");
                        //   }

                    }


                %>       
                
               </table>
                -->


            </div></div>
       
      
    </body>
</html>
