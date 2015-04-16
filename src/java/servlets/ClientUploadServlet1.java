package servlets;

import com.oreilly.servlet.ServletUtils;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.io.*;
import java.util.*;
import javax.servlet.RequestDispatcher;


import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.imageio.ImageIO;

public class ClientUploadServlet1 extends HttpServlet {

    static { /* too late ! */
        System.setProperty("java.awt.headless", "true");
        System.out.println(java.awt.GraphicsEnvironment.isHeadless());
        /* ---> prints false */
    }
    public ImageCount1 imageCount;
    private boolean isMultipart;
    private int maxFileSize = 5000 * 1024;
    private int maxMemSize = 10 * 1024;
    private File file;
    private String NameOnServer;
    private String filePath;
    private String fieldName;
    //   private String realNameOnServer;
//    public TestUseEMR emr;
    
    int colorH = 8;

    @Override
    public void init() {
        // Get the file location where it would be stored.
        //filePath = getServletContext().getInitParameter("file-upload"); 
        filePath = getServletContext().getRealPath("");
        System.out.println(" INIT () () () +> filePath: " + filePath);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long m1, m2;
        m1 = System.currentTimeMillis();


        RequestDispatcher rd = request.getRequestDispatcher("mobile/result_picture.jsp");
        response.setContentType("text/html;charset=UTF-8");

        java.io.PrintWriter out = response.getWriter();
//        if (!isMultipart) {
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet upload</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<p>No file uploaded</p>");
//            out.println("</body>");
//            out.println("</html>");
//            return;
//=       }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
        // Location to save data that is larger than maxMemSize.
        //String filePath = request.getRealPath("")+"/client";

        //File file1 = new File(this.getServletContext().getRealPath("") +"/left");
        //file1.createNewFile();
        System.out.println("\n\n RealPath >> " + filePath);
        factory.setRepository(new File(filePath));
        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);

        LinkedList<String> file_name = new LinkedList<String>();
        LinkedList<String> user_query = new LinkedList<String>();
        LinkedList<File> file_ = new LinkedList<File>();
        
        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();

//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Image Matching</title>");
//            out.println("</head>");
// =          out.println("<body>");
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField()) { // Get the uploaded file parameters


                    String fileName = fi.getName();
                    //=      String contentType = fi.getContentType();
                    //=      boolean isInMemory = fi.isInMemory();
                    //=      long sizeInBytes = fi.getSize();
                    // Write the file
                    if (fileName.lastIndexOf("\\") >= 0) {
                        fieldName = filePath + "/client/" + fileName.substring(fileName.lastIndexOf("\\"));
                        file = new File(fieldName);
                        user_query.add("client/" + fileName.substring(fileName.lastIndexOf("\\")));
                 
                    } else {
                        fieldName = filePath + "/client/" + fileName.substring(fileName.lastIndexOf("\\") + 1);
                        file = new File(fieldName);
                         user_query.add("client/" + fileName.substring(fileName.lastIndexOf("\\") + 1));
                
                    }
                    fi.write(file);
                    file_name.add(fieldName);
                    file_.add(file);
                    NameOnServer = fileName;
                    System.out.println("Uploaded Filename: " + NameOnServer + "<br>IN path:" + filePath);
                }
            }
            //=out.println("</body>");
            //=out.println("</html>");
            System.out.println("Upload completed");






        } catch (Exception ex) {
            System.out.println(ex);
        }

      
        try {

            Connection connection;
            Statement statement;
            String sourceURL = "jdbc:mysql://localhost:3306/photo?user=root";
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(sourceURL);
            statement = connection.createStatement();

            LinkedList<String> photomatch = new LinkedList<String>();
            LinkedList<Integer> pointscore = new LinkedList<Integer>();
            LinkedList<ZonePoint> zonematch = new LinkedList<ZonePoint>();

            LinkedList<String> qzone = new LinkedList<String>();
            String sqlmap = "select zoneid,mapid from zone ";
                    // String sql = "select name,zone,map, ABS(up - " + up + ") + ABS( down - " + down + ")  distance from newphoto ORDER BY distance  LIMIT 5";
            //  String sql = "select name,zone,map,SQRT( POW(r1 - " + r1 + ",2) + POW(r2 - " + r2 + ",2)+ POW(r3 - " + r3 + ",2)+ POW(r4 - " + r4 + ",2)+ POW(r5 - " + r5 + ",2)+ POW(r6 - " + r6 + ",2)+ POW(r7 - " + r7 + ",2)+ POW(r8 - " + r8 + ",2) ) distance from newphoto ORDER BY distance  LIMIT 10";

            System.out.println(sqlmap);
            ResultSet myresult_map = statement.executeQuery(sqlmap);
            while (myresult_map.next()) {
                String q_mapzone = " zone= '" + myresult_map.getString("zoneid") + "' AND map='" + myresult_map.getString("mapid") + "'";
                qzone.add(q_mapzone);
            }

            int maxmatchpoint = 0;
            String photowithmatchpoint = "";
            String zone = "No match";
            int max = 0;
            for (int i = 0; i < file_name.size(); i++) {

                System.out.println("\n\n" + file_name.get(i));

                BufferedImage image = ImageIO.read(file_.get(i));

                BufferedImage newImage = new BufferedImage(256, 256, BufferedImage.TYPE_INT_RGB);

                Graphics g = newImage.createGraphics();
                g.drawImage(image, 0, 0, 256, 256, null);

                g.dispose();

                int imgH = newImage.getHeight();
                int imgW = newImage.getWidth();  // Read Image size
                //String tempWrite = null;
                //  RescaleOp rescaleOp = new RescaleOp(1.2f, 15, null);
                //  rescaleOp.filter(newImage, newImage);

                System.out.println("width, height: " + imgW + ", " + imgH);
                //  int colorValue = red+green+blue;
                int[][] pixels = new int[imgW][imgH]; // Here Image forced to be 500*500
                int sumA = 0, sumB = 0, counterM = 0, counterN = 0;

                int sr[] = new int[colorH];
                int cr[] = new int[colorH];

                double ratio;
                for (int w = 0; w < imgW; w++) {
                    for (int h = 0; h < imgH; h++) {
                        //System.out.println("x,y: "+w+","+h);
                        int pixel = newImage.getRGB(w, h);
                        pixels[w][h] = averagePixelRGB(pixel);

                        for (int icolorH = 0; icolorH < colorH; icolorH++) {
                            if (pixels[w][h] < (256 / colorH) * (icolorH + 1)) {
                                sr[icolorH] += pixels[w][h];
                                cr[icolorH] += 1;
                                break;
                            } else if (icolorH == colorH - 1) {
                                sr[icolorH] += pixels[w][h];
                                cr[icolorH] += 1;
                                break;
                            }

                        }

                    }
                }
                int[] r = new int[colorH];
                for (int icolorH = 0; icolorH < colorH; icolorH++) {

                    if (cr[icolorH] != 0) {
                        r[icolorH] = sr[icolorH] / cr[icolorH];
                    } else {
                        r[icolorH] = (256 / colorH) * (icolorH + 1);
                    }

                }
                ratio = r[0];

                for (int icolorH = 1; icolorH <= colorH - 1; icolorH++) {

                    ratio = ratio / r[icolorH];
                }

                try {
                    TestPhotoMatching tphoto = new TestPhotoMatching(file_name.get(i));
                    for (int iqzone = 0; iqzone < qzone.size(); iqzone++) {
                        String sql = " select name,zone,map,SQRT( POW(r1 - " + r[0] + ",2) + POW(r2 - " + r[1] + ",2)+ POW(r3 - " + r[2] + ",2)+ POW(r4 - " + r[3] + ",2)+ POW(r5 - " + r[4] + ",2)+ POW(r6 - " + r[5] + ",2)+ POW(r7 - " + r[6] + ",2)+ POW(r8 - " + r[7] + ",2) ) distance from newphoto  where " + qzone.get(iqzone) + "  ORDER BY distance LIMIT 20 ";
                        int zero = 0;
                        int countphoto = 0;
                        System.out.println(sql);
                        ResultSet myresult = statement.executeQuery(sql);
                        int pcount = 0;
                        while (myresult.next()) {

                            pcount ++;
                            if(myresult.getDouble("distance") > 15 & pcount > 5) break;
                           
                            System.out.println(myresult.getString("name") + " " + myresult.getString("zone") + " " + myresult.getString("distance"));
                            String args[] = {filePath + "/server/" + myresult.getString("name")};
                            int matchpoint = tphoto.run(args[0]);

                            if(myresult.getDouble("distance") > 10 & pcount > 5) break;
                            
                            if (matchpoint > 0) {
                                /*String map = myresult.getString("map");

                                 //   String zone = myresult.getString("zone");
                                 ZonePoint zp = new ZonePoint(map + "_" + zone, matchpoint);
                                 int miss = 0;
                                 for (int ii = 0; ii < zonematch.size(); ii++) {
                                 ZonePoint zp1 = zonematch.get(ii);
                                 if (zp1.name.equalsIgnoreCase(map + "_" + zone)) {
                                 zp1.update(matchpoint);
                                 miss = 1;
                                 break;
                                 }
                                 }
                                 if (miss == 0) {
                                 zonematch.add(zp);
                                 }
                                 */
                                if (maxmatchpoint < matchpoint) {
                                    String map_ = myresult.getString("map");

                                    String zone_ = myresult.getString("zone");
                                    max = maxmatchpoint;
                                    zone = map_ + "_" + zone_;
                                    maxmatchpoint = matchpoint;
                                    photowithmatchpoint = filePath + "/server/" + myresult.getString("name");
                                }
                            }

                            if (matchpoint <= 1 && countphoto < 5) {
                                zero++;
                            }
                            if (zero >= 5) {
                                break;
                            }
                            if(maxmatchpoint > 30 ) break;
                            
                            countphoto++;
                        }
                         if(maxmatchpoint > 30 ) break;
                    }

                } catch (Exception e) {

                }

            }

            /*

             
             for (int ii = 0; ii < zonematch.size(); ii++) {
             ZonePoint zp1 = zonematch.get(ii);
             if (max < zp1.point) {
             zone = zp1.name;
             max = zp1.point;
             //  System.out.println(zone);
             }

             }*/
            String[] map__zone = zone.split("_");
            if (max > 0) {

                for (int i = 0; i < 1; i++) {

                    System.out.println("\n\n" + photowithmatchpoint);

                    BufferedImage image = ImageIO.read((new File(photowithmatchpoint)));

                    BufferedImage newImage = new BufferedImage(256, 256, BufferedImage.TYPE_INT_RGB);

                    Graphics g = newImage.createGraphics();
                    g.drawImage(image, 0, 0, 256, 256, null);

                    g.dispose();

                    int imgH = newImage.getHeight();
                    int imgW = newImage.getWidth();  // Read Image size
                    //String tempWrite = null;
                    //  RescaleOp rescaleOp = new RescaleOp(1.2f, 15, null);
                    //  rescaleOp.filter(newImage, newImage);

                    System.out.println("width, height: " + imgW + ", " + imgH);
                    //  int colorValue = red+green+blue;
                    int[][] pixels = new int[imgW][imgH]; // Here Image forced to be 500*500
                    int sumA = 0, sumB = 0, counterM = 0, counterN = 0;

                    int sr[] = new int[colorH];
                    int cr[] = new int[colorH];

                    double ratio;
                    for (int w = 0; w < imgW; w++) {
                        for (int h = 0; h < imgH; h++) {
                            //System.out.println("x,y: "+w+","+h);
                            int pixel = newImage.getRGB(w, h);
                            pixels[w][h] = averagePixelRGB(pixel);

                            for (int icolorH = 0; icolorH < colorH; icolorH++) {
                                if (pixels[w][h] < (256 / colorH) * (icolorH + 1)) {
                                    sr[icolorH] += pixels[w][h];
                                    cr[icolorH] += 1;
                                    break;
                                } else if (icolorH == colorH - 1) {
                                    sr[icolorH] += pixels[w][h];
                                    cr[icolorH] += 1;
                                    break;
                                }

                            }

                        }
                    }
                    /*
                     System.out.println("sumA:" + sumA + "\ncouterM:" + counterM + "\nsumB:" + sumB + "\ncounterN:" + counterN);
                     double up = (double) sumA / (double) counterM;
                     double down = (double) sumB / (double) counterN;
                     System.out.println("\nup:" + up + "\ndown:" + down);
                     ratio = up / down;

                     System.out.println("Ratio = " + ratio);

                     */

                    int[] r = new int[colorH];
                    for (int icolorH = 0; icolorH < colorH; icolorH++) {

                        if (cr[icolorH] != 0) {
                            r[icolorH] = sr[icolorH] / cr[icolorH];
                        } else {
                            r[icolorH] = (256 / colorH) * (icolorH + 1);
                        }

                    }

                    ratio = r[0];

                    for (int icolorH = 1; icolorH <= colorH - 1; icolorH++) {

                        ratio = ratio / r[icolorH];
                    }
                    /*
            
                     String arg[] = {file_name.get(i), filePath};
                     imageCount = new ImageCount1();
                     imageCount.run(arg);*/
                    TestPhotoMatching tphotomatching = new TestPhotoMatching(photowithmatchpoint);
                    try {

                        String q_mapzone = " zone= '" + map__zone[1] + "' AND map='" + map__zone[0] + "'";
                        // String sql = "select name,zone,map,SQRT(POW( (up - " + up + ") ,2)+ POW( (down - " + down + "),2 ))  distance from newphoto ORDER BY distance  LIMIT 5";
                        //  String sql = "select name,zone,map,SQRT(POW( (ratio - " + ratio + ") ,2)  )distance from newphoto where " + q_mapzone + "  ORDER BY distance  LIMIT 10";
                        // String sql = "select name,zone,map, ABS(up - " + up + ") + ABS( down - " + down + ")  distance from newphoto ORDER BY distance  LIMIT 5";
                        String sql = "select name,zone,map,SQRT( POW(r1 - " + r[0] + ",2) + POW(r2 - " + r[1] + ",2)+ POW(r3 - " + r[2] + ",2)+ POW(r4 - " + r[3] + ",2)+ POW(r5 - " + r[4] + ",2)+ POW(r6 - " + r[5] + ",2)+ POW(r7 - " + r[6] + ",2)+ POW(r8 - " + r[7] + ",2) ) distance from newphoto  where " + q_mapzone + "  ORDER BY distance LIMIT 10 ";

                        System.out.println(sql);
                        ResultSet myresult = statement.executeQuery(sql);
                        while (myresult.next()) {
                            //  if(photomatch.indexOf(myresult.getString("name")) == -1) photomatch.add(myresult.getString("name"));
                            System.out.println(myresult.getString("name") + " " + myresult.getString("zone") + " " + myresult.getString("distance"));
                            String args[] = {filePath + "/server/" + myresult.getString("name")};
                            int matchpoint = tphotomatching.run(args[0]);
                            if (matchpoint > 0) {
                                if (photomatch.indexOf(myresult.getString("name")) == -1) {
                                    String name = myresult.getString("name");
                                    photomatch.add(name);
                                    pointscore.add(matchpoint);

                                }
                            }
                        }

                    } catch (Exception e) {
                        System.err.print(e.getMessage());
                    }
                }

            }

            System.out.println("THIS IS BEFORE SCANNER");

            Map<Double, Integer> map1 = new TreeMap<Double, Integer>();

            for (int i = 0; i < photomatch.size(); i++) {
                double val = pointscore.get(i) + ((i + 1) * 0.001);;
                map1.put(val, i);
                //	System.out.print(val+" ");
            }

            Collection<Integer> indices1 = map1.values();
            ArrayList<Integer> list1 = new ArrayList<Integer>(indices1);
            System.out.println(list1.size());

            String[] goodResult;

            if (photomatch.size() < 5) {
                goodResult = new String[photomatch.size()];
            } else {
                goodResult = new String[5];
            }
            for (int i = 0; i < photomatch.size(); i++) {
                goodResult[i] = "server/" + photomatch.get(list1.get(photomatch.size() - 1 - i));
                System.out.println(goodResult[i]);
                if (i >= 4) {
                    break;
                }
            }

            request.setAttribute("map", map__zone[0]);
            request.setAttribute("zone", map__zone[1]);
            request.setAttribute("userquery", user_query);
            request.setAttribute("answer", goodResult);

        } catch (Exception e) {
        }
        System.out.println("\n\n==================================\nThis is the end of servlet");
        m2 = System.currentTimeMillis();
        System.out.println("m1 = " + m1 + ", m2 = " + m2);
        System.out.println(" TIME USED :" + (m2 - m1));

        float time = ((m2 - m1) / 1000);
        request.setAttribute("time used", time);

        rd.forward(request, response);



    }

    public class ZonePoint {

        String name;
        int point;

        public ZonePoint(String name) {
            this.name = name;
            this.point = 1;
        }

        public void update() {
            this.point += 1;
        }
    }

    public int averagePixelRGB(int pixel) {
        int red = (pixel >> 16) & 0xff;
        int green = (pixel >> 8) & 0xff;
        int blue = (pixel) & 0xff;
        int avgRGB;
        avgRGB = (red + green + blue) / 3;
        return avgRGB;
    }

    public static Image getImageFromArray(int[] pixels, int width, int height) {
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        WritableRaster raster = (WritableRaster) image.getData();
        raster.setPixels(0, 0, width, height, pixels);
        return image;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
