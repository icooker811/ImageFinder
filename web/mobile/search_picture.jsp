
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/photoswipe.css" type="text/css" rel="stylesheet" />
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css">
        <link rel="stylesheet" href="css/default1.css">
        <script src="../js/jquery-1.7.1.min.js"></script>
        <script src="../js/jquery.mobile-1.3.2.min.js"></script>

    </head>
    <body >
        <div data-role="header">
            <h1>CPE CMU Matching</h1>
            <a href="index.jsp" data-icon="back">Back</a>
            <a href="index.jsp" data-icon="home">Home</a>
        </div>

        <div data-role="content" >
            <h3>Please upload 3 photos that are used for identifying your location </h3>
            <div data-demo-html="true">
                <form data-ajax="false" action="../ClientUploadServlet1" method="post" enctype="multipart/form-data">

                    <div data-demo-html="true">
                        <ul data-role="listview" data-inset="true" data-theme="c" data-dividertheme="a">
                            <li> 
                              
                                    <input type="file" name="file1" id="name" type="image/*" >
                               
                            </li>
                            <li> 
                              
                                    <input type="file" name="file2" id="name" type="image/*" >
                                
                            </li>
                            <li> 
                               
                                    <input type="file" name="file3" id="name" type="image/*" >
                               
                            </li>

                        </ul>

                    </div>
                    <!--
                    <div data-role="fieldcontain">
                        <label for="name">1. Open File Chooser And Select File From Camera  :</label>
                        <input type="file" name="file1" id="name" type="image/*" >
                    </div>
                    <div data-role="fieldcontain">
                        <label for="name">2. Open File Chooser And Select File From Camera  :</label>
                        <input type="file" name="file2" id="name" type="image/*" >
                    </div>
                    <div data-role="fieldcontain">
                        <label for="name">3. Open File Chooser And Select File From Camera  :</label>
                        <input type="file" name="file3" id="name" type="image/*" >
                    </div> -->
                    <div>
                        <input type="submit"  value="Let's Start Matching!" />
                    </div>
                    <!--
                    <div data-role="fieldcontain">

                        <label for="colors"><a rel="external" href="../index.jsp">Open link in a browser.</a></label>

                    </div>

-->

                </form> 
            </div>
        </div>
        <!--<div data-role="footer">
            <h4>Copyright &copy; Computer Engineering, Chiang Mai University</h4>
        </div>

-->


    </body>
</html>