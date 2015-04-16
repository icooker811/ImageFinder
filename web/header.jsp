<%-- 
    Document   : header
    Created on : 13 ต.ค. 2555, 2:18:18
    Author     : TUK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" %>
<%
    String cookieName = "username";
    Cookie cookies[] = request.getCookies();
    Cookie myCookie = null;
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals(cookieName)) {
                myCookie = cookies[i];
                break;
            }
        }
    }
%>
<html>
    <head>
        <title>CPE matching Image Retrieval |  Web Application</title>
        <link href="css/default.css" rel="stylesheet" type="text/css" />
        <script>
            function logout(){
         
                document.cookie = 'username' +'=; expires=Thu, 01-Jan-70 00:00:01 GMT;';
  
            }
     
        </script>
    </head>
    <body id="body1">
        <div id="wrapper1">

            <div id="footer-wrapper1">
                <div id="footer-content">

                    <div id="fbox2">

                        <fieldset id="field2" >
                            <center>
                                <h3>


                                    <%
                                        if (myCookie == null) {
                                    %>
                                    No Cookie found with the name <%=cookieName%>
                                    <%
                                    } else {
                                    %> 
                                    <p>Welcome: <%=myCookie.getValue()%>.
                                        <%
                                            }
                                        %>

                                        <a  href="login.jsp"  target="_parent"  onclick="logout();" >(log out)</a>
                                </h3>
                            </center>

                        </fieldset>

                    </div>   
                </div>   
            </div> 
        </div>
    </div> 
</body></html>