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
        <title>CPE matching Image Retrieval |  Web Application</title>
        <script>
            function formSubmit()
            {
                document.getElementById("frm1").submit();
            }
        </script>
    </head>

    <body>

        <div id="wrapper">
            <div id="header-wrapper">
                <div id="header">
                    <div id="logo">
                          <h1><a href="index.jsp">CPE Matching</a></h1>
                          <br/><p style="padding-left: 30px">Image Retrieval |  Web Application</p>
                    </div>
                    <div id="menu">
                        <br /> <br /> <br />
                        <p style="float:right">Copyright &copy; Computer Engineering, Chiang Mai University</p> 

                    </div> 
                </div>
            </div>
            <div id="footer-wrapper">

                <table border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <div id="banner"><center><img border ="2" src="art.jpg" /></center></div><br/>
                        </td><td>

                            <div id="footer-content">

                                <div id="fbox2">

                                    <fieldset><br /><h2>Sign In :::</h2>

                                        <form id="frm1"  action="login_process.jsp"name="submit" method="POST">
                                            <table border="0" align="center" cellpadding="0" cellspacing="0"><tr>
                                                    <td>
                                                        <table> 
                                                            <tr> 
                                                                <td>Username :: </td>
                                                                <td> <input type="text" name="id" value="" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Password :: </td>
                                                                <td> <input type="password" name="password" value="" /></td>
                                                            </tr>
                                                                
                                                        </table>
                                                       
                                                    </td>
                                                    <td width="150"  align="center" >
                                                        <a class="button large gray" onclick="formSubmit()" href="#"><span>Sign In</span></a>
                                                    </td>
                                                </tr></table>
                                        </form><br />

                                       <!-- <a href="register.jsp" >Register Now</a> -->
                                    </fieldset >
                                </div>  
                            </div>  
                        </td>
                    </tr>
                </table>
            </div>
    </body>
</html>
