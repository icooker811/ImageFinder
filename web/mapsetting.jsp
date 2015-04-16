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
        <link rel="stylesheet" type="text/css" href="css/SyntaxHighlighter.css" />
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/styletable.jquery.plugin.js"></script>

        <script language="JavaScript">
            function setmap(name) {
                document.getElementById('mapid').value = name;

                document.getElementById('mapchange').submit();
            }
            function chkConfirm(name)
            {

                if (confirm('Do you want to delete map : ' + name) == true)
                {

                    window.location = 'map_delete.jsp?mapid=' + name;
                }

            }
            $(function() {

                $('table#table2').styleTable({
                    th_bgcolor: '#3E83C9',
                    th_color: '#ffffff',
                    th_border_color: '#333333',
                    tr_odd_bgcolor: '#ECF6FC',
                    tr_even_bgcolor: '#ffffff',
                    tr_border_color: '#95BCE2',
                    tr_hover_bgcolor: '#BCD4EC'
                });


            });
        </script>
    </head>


    <body >
        <h1>Map Setting</h1><br /><br />

        <table border="0">
            <tr>
                <td width="500" style="vertical-align:top;">
                    <fieldset id="field1">
                        <br/>
                        <a href="map_insert.jsp" ><div style="padding-left: 10px;padding-bottom: 10px;border: 0px black solid;"><img style="width:30px;padding-right: 5px;"  src="./images/bg_add.png" border="0">New Map</div></a>
                        <br/>
                        <form id="mapchange" action="mappreview.jsp?mapid=map1" method="get" target="mappreview" >
                            <input id="mapid" name="mapid" type="hidden" />

                        </form>
                        <table id="table2" border="0" cellpadding="4" cellspacing="0" align="center" width="100%">






                            <%


                                String sql = "select * from map ";

                                ResultSet myresult = statement.executeQuery(sql);
                                // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
                                out.println("<tr><td ><center><h3>Mapid</h3></center></td><td ><center><h3>Name</h3></center></td></tr>");
                                while (myresult.next()) {

                                    out.println("<tr><td>" + myresult.getString("id") + "</td><td>" + myresult.getString("name") + "</td>");

                            %>
                            <td align="center"><a href="#" onclick="setmap('<%out.print(myresult.getString("id"));%>');
                return false;"><img src="./images/magnifier.png" border="0"></a></td>

                            <td align="center"><a href="#" onclick="chkConfirm('<%out.print(myresult.getString("id"));%>');
                return false;" ><img src="./images/publish_r.png" border="0"></a></td>


                            <%
                                    out.println("</tr>");

                                }
                                // out.println("</table>");
%>



                        </table>
                    </fieldset> 
                </td>
                <td style="vertical-align:top;">
                    <iframe id="mappreview" style="width:650px;height: 700px;overflow: hidden;margin-left: 10px;margin-top: -65px;"frameBorder="0" src="mappreview.jsp?mapid=map1"></iframe>
                </td>
            </tr>
        </table>

    </body>
</html>
