package servlets;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RescaleOp;
import java.io.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;

public class ServerUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 6748857432950840322L;
    private static final String DESTINATION_DIR_PATH = "/server";
    private static String realPath;
//    private boolean isMultipart;
//    private int maxFileSize = 1000 * 1024;
//    private int maxMemSize = 6 * 1024;
    private File file;
    private String NameOnServer;
    private String realNameOnServer;
    public ImageCount2 imageCount;
    public String outputLine = "";
    private static final String awsAccessKey = "AKIAIVBF3KZA7GD7HL6A";
    private static final String awsSecretKey = "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";
    private static final String BUCKET_NAME = "hadoopdesktop";
    public int i = 0;
    public String text = "";
    int colorH = 8;
    /*
     @Override
     public void init( ){
     // Get the file location where it would be stored.
     filePath = 
     getServletContext().getInitParameter("file-upload"); 
     }*/

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        realPath = getServletContext().getRealPath(DESTINATION_DIR_PATH) + "/";
        System.out.println("realPath >> " + realPath + " " + getServletContext().getContextPath().toString());
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter writer = null;
        InputStream is = null;
        FileOutputStream fos = null;
        String tempFile = "";
        //isMultipart = ServletFileUpload.isMultipartContent(request);
        response.setContentType("text/html");
        java.io.PrintWriter out = response.getWriter();

        try {
            writer = response.getWriter();
        } catch (IOException ex) {
            log(OctetStreamReader.class.getName() + "has thrown an exception: " + ex.getMessage());
        }

        String filename = request.getHeader("X-File-Name");

        String map = request.getParameter("map1");
        System.out.println("Map :::::::::::::::::" + request.getParameter("map1"));

        String zone = request.getParameter("zone1");
        System.out.println("Zone :::::::::::::::::" + request.getParameter("zone1"));
        try {

            Connection connection;
            Statement statement;
            String sourceURL = "jdbc:mysql://localhost:3306/photo?user=root";
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(sourceURL);
            statement = connection.createStatement();

            is = request.getInputStream();
            file = new File(realPath + filename);
            tempFile = "" + file;
            System.out.println("FILE ################ " + tempFile);
            fos = new FileOutputStream(file);
            IOUtils.copy(is, fos);

            System.out.print(realPath);

            BufferedImage image = ImageIO.read(file);

            BufferedImage newImage = new BufferedImage(256, 256, BufferedImage.TYPE_INT_RGB);

            Graphics g = newImage.createGraphics();
            g.drawImage(image, 0, 0, 256, 256, null);

            g.dispose();

            //  RescaleOp rescaleOp = new RescaleOp(1.2f, 15, null);
            //  rescaleOp.filter(newImage, newImage);
            // image = newImage;
            int imgH = newImage.getHeight();
            int imgW = newImage.getWidth();  // Read Image size
            //String tempWrite = null;

            System.out.println("width, height: " + imgW + ", " + imgH);
            //  int colorValue = red+green+blue;
            int[][] pixels = new int[imgW][imgH]; // Here Image forced to be 500*500
           
            int sumA = 0, sumB = 0, counterM = 0, counterN = 0;

            int sr[] = new int[colorH];
            int cr[] = new int[colorH];

            double ratio = 1;
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
                        }else if(icolorH == colorH -1 ){
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

            for (int icolorH =1 ; icolorH <= colorH-1; icolorH++) {

                ratio = ratio / r[icolorH];
            }

            String sql = "select * from newphoto where name = \"" + filename + "\"";
            System.err.print(sql);
            ResultSet myresult = statement.executeQuery(sql);
            // out.println("<table border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" id=\"table_01\">");
            if (!myresult.next()) {
                sql = "insert into newphoto (name,zone,map,r1,r2,r3,r4,r5,r6,r7,r8,ratio) values (\"" + filename + "\",\"" + zone + "\",\"" + map + "\",\"" + r[0] + "\",\"" + r[1] + "\",\"" + r[2] + "\",\"" + r[3] + "\",\"" + r[4] + "\",\"" + r[5] + "\",\"" + r[6] + "\",\"" + r[7] + "\",\"" + ratio + "\") ";
           /// sql = "insert into newphoto (name,zone,map,r1,r2,r3,r4,r5,r6,r7,r8,ratio) values (\"" + filename + "\",\"" + zone + "\",\"" + map + "\",'0','0','0','0','0','0','0','0',\"" + ratio + "\") ";

                int rs = statement.executeUpdate(sql);
            } else {
                sql = "update  newphoto set r1 = \"" + r[0] + "\" ,r2 = \"" + r[1] + "\" , r3= \"" + r[2] + "\", r4= \"" + r[3] + "\", r5= \"" + r[4] + "\", r6= \"" + r[5] + "\", r7= \"" + r[6] + "\", r8= \"" + r[7] + "\" , ratio= \"" + ratio + "\" where name=\"" + filename + "\" and zone = \"" + zone + "\" ";

                int rs = statement.executeUpdate(sql);
            }

            response.setStatus(response.SC_OK);
            writer.print("{success: true}");

        } catch (FileNotFoundException ex) {
            response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
            writer.print("{success: false}");
            log(OctetStreamReader.class.getName() + "has thrown an exception: " + ex.getMessage());
        } catch (Exception ex) {
            response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
            writer.print("{success: false}");
            log(OctetStreamReader.class.getName() + "has thrown an exception: " + ex.getMessage());
        } finally {
            try {
                fos.close();
                is.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        writer.flush();
        writer.close();
        System.out.println(tempFile + "Upload completed");

    }

    public int averagePixelRGB(int pixel) {
        int red = (pixel >> 16) & 0xff;
        int green = (pixel >> 8) & 0xff;
        int blue = (pixel) & 0xff;
        int avgRGB;
        avgRGB = (red + green + blue) / 3;
        return avgRGB;
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

        /*
         try {
         // Create file 
         FileWriter fstream = new FileWriter("/tmp/input1.txt");
         BufferedWriter out = new BufferedWriter(fstream);
         out.write(SaveText.Text);
         //Close the output stream
         out.close();
         } catch (Exception e) {//Catch exception if any
         System.err.println("Error: " + e.getMessage());
         }
         * */
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
