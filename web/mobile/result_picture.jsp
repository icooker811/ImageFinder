
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@include file="../connectdb.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String ctx = getServletContext().getContextPath();%>

<html >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="imagetoolbar" content="no" />
            <title>Photo Matching  | Result</title>
            <!-- <link rel="stylesheet" href="style.css" />!-->

            <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css"/>
            <link rel="stylesheet" href="mobile/css/default1.css">
                <style type="text/css">
                    div.gallery-row:after { clear: both; content: "."; display: block; height: 0; visibility: hidden; }
                    div.gallery-item { float: left; width: 33.333333%; }
                    div.gallery-item a { display: block; margin: 5px; border: 1px solid #3c3c3c; }
                    div.gallery-item img { display: block; width: 100%; height: auto; }
                    #pageone .ui-contentt { overflow: hidden; }
                    .galleria{ width: 100%; height: 400px; background: #000 }

                </style>


                <script src="js/jquery-1.7.1.min.js"></script>
                <script src="js/jquery.mobile-1.3.2.min.js"></script>
                <script src="galleria/galleria-1.3.5.min.js"></script>

                <script >

                    function direct_(map, loc, des) {
                        var sitemap = 'mobile/map-line-zone.jsp?mapid=' + map + '&loc=' + loc + '&des=' + des;
                        $('p#map_des').html("Your destination : " + des);
                        $('iframe#mapdirection_').attr('src', sitemap);
                        $.mobile.changePage("#direction_map_");
                    }

                </script>

                </head>
                <body>


                    <% String map_name = "";%>
                    <div data-role="page" id="pageone" class="gallery-page" >
                        <div data-role="header">
                            <h3>CPE CMU Matching</h3>
                            <a href="mobile/search_picture.jsp" data-icon="back">Back</a>
                            <a href="mobile/index.jsp" data-icon="home">Home</a>
                        </div>

                        <div data-role="content">


                            <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="a">
                                <li data-role="list-divider"><h3>Place Matching The Result  </h3></li>


                                <%try {%>
                                <%

                                    String sql = "select name from map where id =\"" + request.getAttribute("map").toString() + "\"";
                                    //  out.println(sql + "<br>");
                                    ResultSet myresult = statement.executeQuery(sql);
                                    //            while (myresult.next()) {
                                    //out.println(myresult.getString("email") + "<br>");
                                    //            }

                                    if (myresult.next()) {
                                        map_name = myresult.getString("name");
                                        out.print("<li>Map " + myresult.getString("name") + "</li>");
                                    }
                                    int index = 0;
                                %>
                                <% out.print("<li>Zone  " + request.getAttribute("zone").toString() + "</li>");%>


                                <li>

                                    <table id="table_" border="0">
                                        <tr>
                                            <td > <div style="padding-right: 10px;"><a  data-role="button" href="#map_" >ดูแผนที่</a> </div></td>
                                            <td > <div style="padding-right: 10px;"> <a  data-role="button" href="#direction_" >หาเส้นทาง</a> </div></td>
                                        </tr>
                                    </table>

                                </li>

                                 <li data-role="list-divider"><h3> User queries</h3>  </li>
                                <li>


                            

                                    <div id="source1" style="width:100%;">
                                        <c:forEach var="item" items="${userquery}">


                                            <img width="30%" src="<%=ctx%>/${item}"    />





                                        </c:forEach>
                                    </div>



                                </li>
                                 
                                <li data-role="list-divider"><h3>  Photo Matching Result</h3>  </li>
                                <li>


                                    <div class="galleria">

                                    </div>

                                    <div id="source" style="width:0px;height: 0px;overflow: hidden;">
                                        <c:forEach var="item" items="${answer}">


                                            <img src="<%=ctx%>/${item}"    />





                                        </c:forEach>
                                    </div>



                                </li>
                                <li data-role="list-divider">   <h5>Time Used  = <% out.print(request.getAttribute("time used").toString());%> Seconds</h5>  </li>

                                <script>

                                    $(document).ready(function() {

                                        // $(document).on("pagecreate", function() {
                                        /*  $(".photopopup").on({
                                         popupbeforeposition: function() {
                                         var maxHeight = $(window).height() - 60 + "px";
                                         $(".photopopup img").css("max-height", maxHeight);
                                         }
                                         });
                                         */

                                        Galleria.loadTheme('galleria/themes/classic/galleria.classic.min.js');
                                        
                                        Galleria.run('.galleria', {
                                            dataSource: "#source",
                                            keepSource: true

                                        });

                                    });



                                </script>

                                <%} catch (Exception ex) {
                                        out.print(" <li>  <h5 style='color:red;'>There are no result to macth your photos !!!</h5></li>");
                                    }%>



                            </ul>


                        </div>   


                        <!--   <div data-role="footer">
               
               
               
                               <h4>Copyright &copy; Computer Engineering, Chiang Mai University</h4>
                           </div>
                        -->
                    </div>





                    <%try {%>





                    <div data-role="page" id="map_" >
                        <div data-role="header" >
                            <h1>แผนที่</h1>
                            <a href="#pageone" data-icon="back">Back</a>
                            <a href="mobile/index.jsp" data-icon="home">Home</a>
                        </div>
                        <div data-role="content" > 
                            <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="a">
                                <li data-role="list-divider"><h3>แผนที่ : <%out.print(map_name);%>  </h3></li>
                                <li>You here : <% out.print(request.getAttribute("zone").toString());%> </li>
                                <li><iframe id="manual" width="100%" height="550" frameBorder="0" style="background-color: #FFF" src="mobile/map-point.jsp?mapid=<%out.print(request.getAttribute("map"));%>&zoneid=<%out.print(request.getAttribute("zone"));%>" ></iframe> 
                                </li>
                            </ul>
                        </div>
                        <!-- <div data-role="footer">
                             <h4>Copyright &copy; Computer Engineering, Chiang Mai University</h4>
                         </div>-->
                    </div>


                    <div data-role="page" id="direction_" >
                        <div data-role="header" >
                            <h1>หาเส้นทาง</h1>
                            <a href="#pageone" data-icon="back">Back</a>
                            <a href="mobile/index.jsp" data-icon="home">Home</a>
                        </div>
                        <div data-role="content" > 
                            <p>Choose your destination</p>
                            <p>Map : <% out.print(request.getAttribute("map"));%></p>
                            <p>Your Zone : <% out.print(request.getAttribute("zone"));%></p>
                            <div data-demo-html="true">
                                <ul data-role="listview" data-inset="true"  data-theme="c" data-dividertheme="a">
                                    <li data-role="list-divider">Your destination</li>
                                        <%

                                            String sql = "select polygonid,detail from polygon where mapid ='" + request.getAttribute("map") + "' ";
                                            // out.print(sql);
                                            ResultSet myresult = statement.executeQuery(sql);
                                            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                                            while (myresult.next()) {

                                                // if (!myresult.getString("name").equalsIgnoreCase("zone")) {
                                                //   }
                                                //  if (!myresult.getString("polygonid").equalsIgnoreCase(request.getParameter("loc"))) {
                                                out.println("<li><a  onClick=\"direct_('" + request.getAttribute("map") + "','" + request.getAttribute("zone") + "','" + myresult.getString("polygonid") + "');return false;\"><img style=\"margin-left:10px;\" width=\"100px\" height=\"100px\"src=\"images/marker_2.png\">  <h1 class=\"Header\">" + myresult.getString("polygonid") + "</h1><p class=\"Paragraph \">" + myresult.getString("detail") + "</p> </a></li>");

                                                //}
                                            }

                                            //out.println("</table>");
                                        %>
                                </ul>
                            </div>
                            <!-- <div data-role="footer">
                                 <h4>Copyright &copy; Computer Engineering, Chiang Mai University</h4>
                             </div>-->
                        </div>
                    </div>

                    <div data-role="page" id="direction_map_" >
                        <div data-role="header" >
                            <h1>เส้นทางที่ค้นหา</h1>
                            <a href="#direction_" data-icon="back">Back</a>
                            <a href="mobile/index.jsp" data-icon="home">Home</a>
                        </div>
                        <div data-role="content" >
                            <h2 id="list-inset">Direction</h2>
                            <p>Your destination</p>
                            <p>Map : <% out.print(request.getAttribute("map"));%></p>
                            <p>Your location : <% out.print(request.getAttribute("zone"));%></p>
                            <p id="map_des"></p>
                            <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="a">
                                <li data-role="list-divider"><h3>เส้นทางการเดินทาง </h3></li>
                                <li><iframe id="mapdirection_" width="100%" height="550" frameBorder="0" style="background-color: #FFF" src="#" ></iframe> 
                                </li>

                            </ul>
                        </div>
                    </div>
                    <%} catch (Exception ex) {

                        }%>


                </body>
                </html>