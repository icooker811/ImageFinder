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
        <link href="css/fileuploader.css" rel="stylesheet" type="text/css"/>	

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

        <script type="text/javascript">

            if (screen.width <= 699) {
                document.location = "mobile/index.jsp";
            }

        </script>

    </head>

    <body>

        <div id="wrapper">
            <div id="header-wrapper">
                <div id="header">
                    <a href="index.jsp">
                        <div id="logo">
                            <h1><a href="#">CPE Matching</a></h1>
                            <br/><p style="padding-left: 30px">Image Retrieval |  Web Application</p>
                        </div>
                    </a>
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

                                    <br />

                                    <p>To upload a file, click on the button below. Drag-and-drop is supported in FF, Chrome.</p>
                                    <p>Progress-bar is supported in FF3.6+, Chrome6+, Safari4+</p>
                                    <fieldset>
                                        <h2>File Upload:</h2>
                                        <h3>Select a file to upload:   <br />
                                            <form action="ClientUploadServlet" method="post" enctype="multipart/form-data">
                                                <input type="file" name="file1" size="50" />
                                                <input type="file" name="file2" size="50" />
                                                <input type="file" name="file3" size="50" />
                                                <br /><br />
                                                <input type="submit"  value="Let's Start Matching!" />


                                            </form>
                                        </h3>
                                        <br/>
                                    </fieldset>

                                    <br/><br/>
                                    <a style="margin-right: 10px;" href="mobile/index.jsp">Mobile Style</a>
                                    <a style="margin-right: 10px;" href="login.jsp">Admin Login</a>

                                </div>  
                            </div>  
                        </td>
                    </tr>
                </table>
            </div>
    </body>
</html>
