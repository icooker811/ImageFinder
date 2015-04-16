<%-- 
    Document   : readtext
    Created on : Nov 24, 2011, 12:57:58 AM
    Author     : Tuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Read Text File </title>
    </head>
    <body>
        <form action="ReadText" method="get">
                <fieldset>
                    <h1><center>
                    Please enter the path of text file that you want servlet to read </br>
                    <input type="text" name="txtpath" />
                   
                    <td><input type="submit" value="submit" /></td>
                    <td><input type="reset" value="clear"/></td>
                    </center>
                    </h1>
                </fieldset>
        </form>
    </body>
</html>
