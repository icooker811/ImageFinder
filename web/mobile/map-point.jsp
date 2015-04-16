<%-- 
    Document   : login
    Created on : Sep 12, 2012, 9:55:43 PM
    Author     : Tuk
--%>



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
        <title>JSP Page</title>
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
              
                width: 600px;
                height :500px;
                position: relative;
                display:inline-block;
                background: white;
            }


        </style>

    </head>


    <body >


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

       

        <div id ="map_">
  
            <%
                for (int i = 0; i < listzone.size(); i++) {
                    Block j = listzone.get(i);
                    out.println("<div class=\"block red wrapper\" style=\"width:" + j.width + "px;height:" + j.height + "px;top:" + (j.y) + "px;left:" + j.x + "px;\"><div class=\"cell\"><h3>" + j.name + "</h3></div></div>");
                    if(j.name.equals(request.getParameter("zoneid"))){
                      out.println("<img  style=\"z-index:99;position: absolute;width:50px;height:50px;top:" + (( j.y )- (j.height /2) ) + "px;left:" + j.x + "px;\" src=\"../images/marker_1.png\" />");
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




    </body>
</html>
