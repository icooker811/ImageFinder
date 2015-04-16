<%-- 
    Document   : index
    Created on : Jun 2, 2014, 1:35:52 PM
    Author     : tuck
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css">
        <link rel="stylesheet" href="../css/jqm-demos.css">
        <link rel="stylesheet" href="css/default1.css">
        <script src="../js/jquery-1.7.1.min.js"></script>
        <script src="../js/jquery.mobile-1.3.2.min.js"></script>
       
    </head>
    <body >
       <!-- <div data-role="header">
            <h1>CPE CMU Matching</h1>

        </div>
-->
        <div data-role="content" >
            <h2 id="list-inset">Welcome to</h2>
            <p>CPE,CMU Matching </p>
            <img src="../images/app-icon.png" />
           <!-- <div data-demo-html="true">
                <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="a">
                    <li data-role="list-divider">Menu</li>
                    <li><a href="search_picture.jsp"><img style="margin-left:10px;" width="100px" height="100px"src="../images/camera-icon.png">  <h1 class="Header">Search</h1><p class="Paragraph">Upload 3 photos for searching by matching your upload photos with server.</p> </a></li>
                    <li><a href="lookup-map.jsp"><img style="margin-left:10px;" width="100px" height="100px"src="../images/search-icon.png">  <h1 class="Header">Look up</h1><p class="Paragraph">Search and get direction by input your location name and your destination name.</p> </a></li>

                </ul>
            </div>
-->
        </div>
        <div data-role="footer" data-position="fixed">		
          
                
                <div data-role="navbar" class="nav-example" >
		<ul>
			<li><a href="search_picture.jsp" id="camera" data-icon="custom">camera</a></li>
			<li><a href="lookup-map.jsp" id="look_up" data-icon="custom">look up</a></li>
                </ul>
            </div>
        </div>


    </body>
</html>
