package servlets;

import com.oreilly.servlet.ServletUtils;

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
import org.apache.commons.io.IOUtils;

public class MapUploadServlet extends HttpServlet {
   
    public ImageCount1 imageCount;
    private boolean isMultipart;
    private int maxFileSize = 500 * 1024;
    private int maxMemSize = 10 * 1024;
    private File file;
    private String NameOnServer;
    private String filePath;
    private String fieldName;
    //   private String realNameOnServer;
//    public TestUseEMR emr;
    public String ans = "";
    public String name = "";
    
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



        //=isMultipart = ServletFileUpload.isMultipartContent(request);
        response.setContentType("text/html");
        java.io.PrintWriter out = response.getWriter();
        
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
        // Location to save data that is larger than maxMemSize.
        //String filePath = request.getRealPath("")+"/client";

        //File file1 = new File(this.getServletContext().getRealPath("") +"/left");
        //file1.createNewFile();
        System.out.println("\n\n RealPath >> " + filePath);
        name = request.getParameter("name");
  //      factory.setRepository(new File(filePath));
        // Create a new file upload handler
       // ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
     //   upload.setSizeMax(maxFileSize);

     //   InputStream is = null;
     //   FileOutputStream fos = null;
     //   String tempFile = "";
        
        
        try {
            
    //        is = request.getInputStream();
    //        file = new File(fieldName);
            
            Connection connection;
            Statement statement;
            String sourceURL = "jdbc:mysql://localhost:3306/photo?user=root";
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(sourceURL);
            statement = connection.createStatement();
            String sql = "insert into zone (zone) values (\"" + name +  "\") ";
            
            int rs = statement.executeUpdate(sql);
            
     //       String sql1 = "DELETE FROM newphoto WHERE name NOT IN ( SELECT name FROM (SELECT name FROM newphoto ORDER BY name DESC ) )foo;";
            
     //       int rs1 = statement.executeUpdate(sql1);
            
            ans = "Successful Insert Zone";
        } catch (Exception ex) {
           ans = "Unsuccessful Insert Zone";
            System.out.print(ex.getMessage());
        }

        //System.out.println("str " + resultArr);
        //     request.setAttribute("zone", zone);
        request.setAttribute("ans", ans);
        RequestDispatcher rd = request.getRequestDispatcher("phoinsert.jsp");
        rd.forward(request, response);
        
        
        System.out.println("\n\n==================================\nThis is the end of servlet");
        m2 = System.currentTimeMillis();
        System.out.println("m1 = " + m1 + ", m2 = " + m2);
        System.out.println(" TIME USED :" + (m2 - m1));
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
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
