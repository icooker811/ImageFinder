<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Sep 12, 2012, 8:04:54 PM
    Author     : Tuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                document.getElementById("myform").submit();
            }
        </script>
        <title>CPE matching Image Retrieval |  Web Application</title>
    </head>
    <body>


        <table border="0" align="center" cellpadding="0" cellspacing="0" id="table_01">


            <tr>
                <td width="775"  colspan="14" align="center" valign="middle" class="text2"><br/><br />
                    <fieldset><br /><h1>New Admin</h1><br/>
                        <form id="myform" action="reprocess.jsp"name="submit" method="POST">
                            <table>
                                <tr><td>Username :: </td><td><input type="text" name="id" value="" /><br></td></tr>
                                <tr><td>Password :: </td><td><input type="password" name="password" value="" /><br></td></tr>
                                <tr><td> Re-Password :: </td><td><input type="password" name="repassword" value="" ><br></td></tr>
                                <tr height="10"></tr>
                                <tr><td><a class="button large gray" onclick="formSubmit()" href="#"><span>Submit</span></a></td></tr>
                            </table>
                        </form>

                    </fieldset>
                </td>
            </tr>


        </table>
    </body>
</html>
