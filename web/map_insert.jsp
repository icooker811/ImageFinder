
<%-- 
    Document   : index
    Created on : Sep 12, 2012, 8:04:54 PM
    Author     : Tuk
--%>
<%@include file="connectdb.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="fileuploader.css" rel="stylesheet" type="text/css"/>	

        <link href="css/default.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-1.2.6.js" type="text/javascript" charset="utf-8"></script>
        <script src="js/form-fun.jquery.js" type="text/javascript" charset="utf-8"></script> 
        <script>
            function formSubmit()
            {
                document.getElementById("mapname_").value = encodeURIComponent(document.getElementById("mapname").value);
                document.getElementById("myform").submit();
            }
        </script>
        <title>CPE matching Image Retrieval |  Web Application</title>
    </head>
    <body>


        <%


            String sql = "select * from map   ";
            int count = 0;
            ResultSet myresult = statement.executeQuery(sql);
            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
            // out.println("<tr><td ><center><h3>Mapid</h3></center></td><td ><center><h3>Name</h3></center></td></tr>");
            while (myresult.next()) {

              //  out.println(myresult.getString("id").split("map")[1]);
                int temp = Integer.parseInt(myresult.getString("id").split("map")[1]);
                if(temp > count) count = temp;
             //   count = Integer.parseInt(myresult.getString("id").split("map")[1]);
                //  out.println("<tr><td>" + myresult.getString("id") + "</td><td>" + myresult.getString("name") + "</td>");
               // count = count;
            }

            String id = "map" + (count + 1);
        %>

        <table border="0" align="center" cellpadding="0" cellspacing="0" id="table_01">


            <tr>
                <td width="775"  colspan="14" align="center" valign="middle" class="text2"><br/><br />
                    <fieldset><br /><h1>New Map</h1><br/>
                        <form id="myform" action="mapprocess.jsp" name="submit" method="POST">
                            <table>
                                <tr><td>Mapid :: </td><td><input style="width:300px;" readonly="readonly" type="text" name="id" value="<%out.print(id);%>" /><br></td></tr>
                                <tr><td>Name :: </td><td><input style="width:300px;" id="mapname" type="text" name="_name" value="" /><br></td></tr>
                                <tr><td><input id="mapname_" type="hidden" name="name" value="" /></td></tr>

                                <tr style="height:10px;"></tr>
                                <tr><td><a class="button large gray" onclick="formSubmit()" href="#"><span>Submit</span></a></td></tr>
                            </table>
                        </form>

                    </fieldset>
                </td>
            </tr>


        </table>
    </body>
</html>
