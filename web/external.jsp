<%-- 
    Document   : external
    Created on : Nov 23, 2011, 11:10:59 PM
    Author     : Tuk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Call External Program </title>
    </head>
    <body>
        <form action="CallExternal" method="post">
                <fieldset>
                    <h1><center>
                    Please enter the external command to call from servlet </br>
                    <input type="text" name="command" />
                   
                    <td><input type="submit" value="submit" /></td>
                    <td><input type="reset" value="clear"/></td>
                    </center>
                    </h1>
                </fieldset>
        </form>
    </body>
</html>
