<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@include file="connectdb.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String ctx = getServletContext().getContextPath();%>

<html >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="imagetoolbar" content="no" />
            <link rel="stylesheet" type="text/css" href="css/default.css" media="screen"/>
            <script src="js/jquery-1.2.6.js" type="text/javascript" charset="utf-8"></script>
            <title>CPE matching Image Retrieval |  Web Application</title>

            <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
            <script type="text/javascript" src="./fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
            <script type="text/javascript" src="./fancybox/jquery.fancybox-1.3.4.pack.js"></script>
            <link rel="stylesheet" type="text/css" href="./fancybox/jquery.fancybox-1.3.4.css" media="screen" />
            <!-- <link rel="stylesheet" href="style.css" />!-->
            <script type="text/javascript">
                $(document).ready(function() {
                    /*
                     *   Examples - images
                     */

                    $("a#example1").fancybox();

                    $("a#example2").fancybox({
                        'overlayShow': false,
                        'transitionIn': 'elastic',
                        'transitionOut': 'elastic'
                    });

                    $("a#example3").fancybox({
                        'transitionIn': 'none',
                        'transitionOut': 'none'
                    });

                    $("a#example4").fancybox({
                        'opacity': true,
                        'overlayShow': false,
                        'transitionIn': 'elastic',
                        'transitionOut': 'none'
                    });

                    $("a#example5").fancybox();

                    $("a#example6").fancybox({
                        'titlePosition': 'outside',
                        'overlayColor': '#000',
                        'overlayOpacity': 0.9
                    });

                    $("a#example7").fancybox({
                        'titlePosition': 'inside'
                    });

                    $("a#example8").fancybox({
                        'titlePosition': 'over'
                    });

                    $("a[rel=example_group]").fancybox({
                        'transitionIn': 'none',
                        'transitionOut': 'none',
                        'titlePosition': 'over',
                        'titleFormat': function(title, currentArray, currentIndex, currentOpts) {
                            return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
                        }
                    });

                    /*
                     *   Examples - various
                     */

                    $("#various1").fancybox({
                        'titlePosition': 'inside',
                        'transitionIn': 'none',
                        'transitionOut': 'none'
                    });

                    $("#various2").fancybox();

                    $("#various3").fancybox({
                        'width': '75%',
                        'height': '75%',
                        'autoScale': false,
                        'transitionIn': 'none',
                        'transitionOut': 'none',
                        'type': 'iframe'
                    });

                    $("#various4").fancybox({
                        'padding': 0,
                        'autoScale': false,
                        'transitionIn': 'none',
                        'transitionOut': 'none'
                    });
                });
            </script>
    </head>
    <body>

        <div id="wrapper">
            <div id="header-wrapper">
                <div id="header">
                    <a href="index.jsp">
                        <div id="logo">
                            <h1>CPE Matching</h1>
                            <br/><p>Photo Matching Using Hadoop MapReduce </p>
                        </div>
                    </a>
                    <div id="menu">
                        <br /> <br /> <br />
                        <p style="float:right">Copyright &copy; Computer Engineering, Chiang Mai University</p> 

                    </div> 
                </div>
            </div>
            <div id="footer-wrapper">

                <table style="padding-top: 10px;padding-bottom: 10px" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="1100px">


                            <br>

                                <fieldset >
                                    <h1>Place Matching The Result ::: </h1>
                                    <div style="padding-left:5em">
                                        <%try {%>
                                        <%

                                            String sql = "select name from map where id =\"" + request.getAttribute("map").toString() + "\"";
                                            //  out.println(sql + "<br>");
                                            ResultSet myresult = statement.executeQuery(sql);
                                            //            while (myresult.next()) {
                                            //out.println(myresult.getString("email") + "<br>");
                                            //            }
                                            if (myresult.next()) {
                                                out.print("Map " + myresult.getString("name"));
                                            }
                                        %><br>
                                            <% out.print("Zone  " + request.getAttribute("zone").toString());%>
                                            <br><a target="_blank" href="map-point.jsp?mapid=<%out.print(request.getAttribute("map"));%>&zoneid=<%out.print(request.getAttribute("zone"));%>" >ดูแผนที่</a>
                                                </fieldset>
                                                <p>
                                                    <fieldset class="field3">
                                                        <br /> <h3>  User queries</h3><br/> 

                                                        <c:forEach var="item" items="${userquery}">
                                                            <a  rel="example_group" href="<%=ctx%>/${item}"><img alt=" " src="<%=ctx%>/${item}" width="120" height="120" /></a>
                                                        </c:forEach>

                                                    </fieldset>
                                                    <fieldset class="field3">
                                                        <br /> <h3>  Photo Matching Result</h3><br/> 

                                                        <c:forEach var="item" items="${answer}">
                                                            <a  rel="example_group" href="<%=ctx%>/${item}"><img alt=" " src="<%=ctx%>/${item}" width="120" height="120" /></a>
                                                        </c:forEach>

                                                    </fieldset>
                                                </p>

                                                Time Used  = <% out.print(request.getAttribute("time used").toString());%> Seconds

                                                <%} catch (Exception ex) {
                                                    out.print("<h3 >No matching </h3><br>");
                                                }%>
                                                </div>
                                                </td>
                                                </tr>
                                                </table>
                                                </div>


                                                </body>
                                                </html>