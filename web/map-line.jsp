<%-- 
    Document   : login
    Created on : Sep 12, 2012, 9:55:43 PM
    Author     : Tuk
--%>



<%@page import="servlets.Getdirection"%>
<%@include file="connectdb.jsp"%>
<%@page import="servlets.Block"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

            div.line{
                transform-origin: 0% 0%;
                height: 5px; /* Line width of 3 */
                background: #000; /* Black fill */

                -ms-transform-origin:0% 100%; /* IE 9 */
                -webkit-transform-origin:0% 100%; /* Opera, Chrome, and Safari */
            }

            div.block {
                border: 2px dotted black;
                position: absolute;
                text-align: center;
                text-justify:inter-word;
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
        <script src="js/jquery-1.7.1.min.js"></script>
        <script>
            function createLine(x1, y1, x2, y2) {

                var length = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
                var angle = Math.atan2(y2 - y1, x2 - x1) * 180 / Math.PI;
                var transform = 'rotate(' + angle + 'deg)';

                if (angle == 0 || angle == 180 || angle == 90 || angle === 270) {
                    var line = $('<div>')
                            .addClass('line')
                            .css({
                                'position': 'absolute',
                                'transform': transform,
                                '-ms-transform': transform,
                                '-webkit-transform': transform
                            })
                            .width(length)
                            .offset({left: x1, top: y1});
                    $('#map_').append(line);
                    //    alert(angle);
                } else {
                    var line1;
                    var line2;

                    if (angle > -90 && angle < 0) {

                        length = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y1) * (y1 - y1));

                        line1 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(180deg)',
                                    '-ms-transform': 'rotate(180deg)',
                                    '-webkit-transform': 'rotate(180deg)'
                                })
                                .width(length)
                                .offset({left: x2, top: y2});

                        length = Math.sqrt((x2 - x2) * (x2 - x2) + (y1 - y2) * (y1 - y2));


                        line2 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(90deg)',
                                    '-ms-transform': 'rotate(90deg)',
                                    '-webkit-transform': 'rotate(90deg)'
                                })
                                .width(length)
                                .offset({left: x1, top: y2});



                    } else if (angle > -180 && angle < -90) {

                        length = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y1) * (y1 - y1));

                        line1 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(180deg)',
                                    '-ms-transform': 'rotate(180deg)',
                                    '-webkit-transform': 'rotate(180deg)'
                                })
                                .width(length)
                                .offset({left: x1, top: y1});

                        length = Math.sqrt((x2 - x2) * (x2 - x2) + (y1 - y2) * (y1 - y2));


                        line2 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(-90deg)',
                                    '-ms-transform': 'rotate(-90deg)',
                                    '-webkit-transform': 'rotate(-90deg)'
                                })
                                .width(length)
                                .offset({left: x2, top: y1});



                    } else if (angle > 90 && angle < 180) {



                        length = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y1) * (y1 - y1));


                        line1 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(180deg)',
                                    '-ms-transform': 'rotate(180deg)',
                                    '-webkit-transform': 'rotate(180deg)'
                                })
                                .width(length)
                                .offset({left: x1, top: y1});

                        length = Math.sqrt((x2 - x2) * (x2 - x2) + (y1 - y2) * (y1 - y2));


                        line2 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(90deg)',
                                    '-ms-transform': 'rotate(90deg)',
                                    '-webkit-transform': 'rotate(90deg)'
                                })
                                .width(length)
                                .offset({left: x2, top: y1});



                    } else if (angle > 0 && angle < 90) {

                        length = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y1) * (y1 - y1));

                        line1 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(180deg)',
                                    '-ms-transform': 'rotate(180deg)',
                                    '-webkit-transform': 'rotate(180deg)'
                                })
                                .width(length)
                                .offset({left: x2, top: y2});

                        length = Math.sqrt((x2 - x2) * (x2 - x2) + (y1 - y2) * (y1 - y2));


                        line2 = $('<div>')
                                .addClass('line')
                                .css({
                                    'position': 'absolute',
                                    'transform': 'rotate(-90deg)',
                                    '-ms-transform': 'rotate(-90deg)',
                                    '-webkit-transform': 'rotate(-90deg)'
                                })
                                .width(length)
                                .offset({left: x1, top: y2});



                    }
                    //alert(angle);
                    $('#map_').append(line1);
                    $('#map_').append(line2);
                }
                // alert(angle); 
                //return line;

            }

        </script>
    </head>


    <body >


        <%            String sql = "select * from zone where mapid ='" + request.getParameter("mapid") + "'";
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

        <%            sql = "select * from polygon where mapid ='" + request.getParameter("mapid") + "'";
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

        <%              String sql1 = "select name from map where id ='" + request.getParameter("mapid") + "'";
            //out.print(sql1);
            ResultSet myresult1 = statement.executeQuery(sql1);

            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
            while (myresult1.next()) {
                //  out.print("<br><h3 style=\"padding-left:10px;\"> " + request.getParameter("mapid") + ": " + myresult1.getString("name") + "</h3>");
            }

        %>
        <br/>

        <div id ="map_">

            <%                int locindex = -1;
                int desindex = -1;
                for (int i = 0; i < listzone.size(); i++) {
                    Block j = listzone.get(i);
                    out.println("<div class=\"block red wrapper\" style=\"width:" + j.width + "px;height:" + j.height + "px;top:" + (j.y) + "px;left:" + j.x + "px;\"><div class=\"cell\"><h3>" + j.name + "</h3></div></div>");
                    // out.println("<div class=\"line\" style=\"width:" + j.width + "px;height:" + 0 + "px;top:" + ((j.y) + (j.height / 2)) + "px;left:" + j.x + "px;\"></div>");
                    if (j.name.equals(request.getParameter("loc"))) {
                        locindex = i;
                        out.println("<img  style=\"z-index:1;position: absolute;width:50px;height:50px;top:" + ((j.y) + j.height - (51)) + "px;left:" + ((j.x) + j.width - (45)) + "px;\" src=\"images/marker_1.png\" />");
                    }
                    if (j.name.equals(request.getParameter("des"))) {
                        desindex = i;
                        out.println("<img  style=\"z-index:1;position: absolute;width:50px;height:50px;top:" + ((j.y) + j.height - (51)) + "px;left:" + ((j.x) + j.width - (45)) + "px;\" src=\"images/marker_2.png\" />");
                    }

                }
            %>



            <%
                for (int i = 0; i < listpolygon.size(); i++) {
                    Block j = listpolygon.get(i);
                    out.println("<div class=\"block grey wrapper\" style=\"width:" + j.width + "px;height:" + j.height + "px;top:" + (j.y) + "px;left:" + j.x + "px;\"><div class=\"cell\"><h3>" + j.name + "</h3></div></div>");

                }
            %>


        </div>


        <script>

            $(document).ready(function() {



            <%
                if (locindex == -1 || desindex == -1) {
                    out.println("alert(จุดเริ่มต้น / จุดปลายทางไม่ถูกต้อง );");
                } else {
                    Getdirection gt = new Getdirection();

                    gt.setMap(listzone);
                    // out.println(gt.nodemap.size() + "<br>");

                    LinkedList<Block> lineConnect = gt.Getdirection(listzone.get(locindex), listzone.get(desindex));
                    Block b = lineConnect.get(0);

                    int x1 = ((b.x) + (b.width) - 10);
                    int y1 = ((b.y) + (b.height - 10));

                    for (int i = 1; i < lineConnect.size(); i++) {
                        Block b2 = lineConnect.get(i);
                        out.println("createLine('" + x1 + "', '" + y1 + "', '" + ((b2.x) + (b2.width) - 10) + "', '" + ((b2.y) + (b2.height - 10)) + "');");
                        //  out.println("<div class=\"block red wrapper\" style=\"width:" + j.width + "px;height:" + j.height + "px;top:" + (j.y) + "px;left:" + j.x + "px;\"><div class=\"cell\"><h3>" + j.name + "</h3></div></div>");
                        // out.println("<div class=\"line\" style=\"width:" + j.width + "px;height:" + 0 + "px;top:" + ((j.y) + (j.height / 2)) + "px;left:" + j.x + "px;\"></div>");
                        x1 = ((b2.x) + (b2.width) - 10);
                        y1 = ((b2.y) + (b2.height - 10));
                    }
                }
            %>
            });

        </script>


    </body>
</html>
