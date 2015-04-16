<%-- 
    Document   : tabmenu
    Created on : 13 ต.ค. 2555, 2:18:38
    Author     : TUK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"> 
    <head> 
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
        <title>CPE matching Image Retrieval |  Web Application</title>
        <link href="css/default.css" rel="stylesheet" type="text/css" />
        <script src="js/jquery-1.6.2.min.js" type="text/javascript"></script> 
        <script type="text/javascript"> 
            <!--    
            $(document).ready(function () {
                $('LI.drawer UL:not(:first)').hide(); // hide all ULs inside LI.drawer except the first one
                $('H2.drawer-handle').click(function () {
                    // hide all the drawer contents
                    $('LI.drawer UL:visible').slideUp().prev().removeClass('open');

                    // show the associated drawer content to 'this' (this is the current H2 element)
                    // since the drawer content is the next element after the clicked H2, we find
                    // it and show it using this:
                    $(this).addClass('open').next().slideDown();
                });
            });
            //-->    </script> 
    </head> 
    <body id="body1">
        <a href="index.jsp" target="_parent">
        <div id="logo">
            
            <h1>CPE Matching</h1>
            <br/><p style="padding-left: 30px">Image Retrieval |  Web Application</p>
        </div>
        </a>


        <center>    <p>&nbsp;</p>
            <img src="art.jpg" border="1" alt="" width="80%" height="80%"/>
            <p>&nbsp;</p>

        </center>


        <fieldset>



            <legend style="color:#06F;"><fieldset id="field1"> <h1 ><center>MENU</center></h1>  </fieldset><br/></legend>
            <div class="drawers-wrapper"> 
                <div class="boxcap captop"></div> 
                <ul class="drawers"> 


                <!--    <li class="drawer" ><h2 class="drawer-handle open"><a class ="drawer-aa" title="Photo Matching" href="index_match.jsp" target= "mainFrame">Photo Matching</a></h2> <ul>  </ul> </li> -->
                    <li class="drawer" ><h2 class="drawer-handle"><a class ="drawer-aa" title="Upload Photo" href="upload.jsp" target= "mainFrame">Upload Photo</a> </h2><ul>  </ul> </li> 
                    <li class="drawer" ><h2 class="drawer-handle"><a class ="drawer-aa" title="Photo Setting" href="phoedit.jsp?mapid=map1&zoneid=4A" target= "mainFrame">Photo Setting</a> </h2> <ul>  </ul> </li>
                      <li class="drawer" ><h2 class="drawer-handle"><a class ="drawer-aa" title="Map Setting" href="mapsetting.jsp?mapid=map1" target= "mainFrame">Map Setting</a> </h2> <ul>  </ul> </li> 
                    
                     <li class="drawer" ><h2 class="drawer-handle"><a class ="drawer-aa" title="Zone Setting" href="zoneedit.jsp?mapid=map1" target= "mainFrame">Zone Setting</a> </h2> <ul>  </ul> </li> 
                      <li class="drawer" ><h2 class="drawer-handle"><a class ="drawer-aa" title="User Setting" href="usersetting.jsp" target= "mainFrame">User Setting</a> </h2> <ul>  </ul> </li> 
                   


                </ul> 
            </div> 
            <center>    <p>&nbsp;</p>

            </center>
        </fieldset>


    </body> 
</html>