
package servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.ServletUtils;
import java.io.DataInputStream;

/**
 *
 * @author mickey
 */
public class WriteToFileServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String dim = null;
        String dim2 = null;
        try {
             //  String Opt1 = request.getParameter("num_attendees");
               String m1_1 = request.getParameter("m1-1");
             //  out.print(m1_1);
               String m1_2 = request.getParameter("m1-2");
             //  out.print(m1_2);
               String m1_3 = request.getParameter("m1-3");
              // out.print(m1_3);
               String m1_4 = request.getParameter("m1-4");
            //   out.print(m1_4);
               String m1_5 = request.getParameter("m1-5");
             //  out.print(m1_5);
               String m2_1 = request.getParameter("m2-1");
            //   out.print(m2_1);
               String m2_2 = request.getParameter("m2-2");
            //   out.print(m2_2);
               String m2_3 = request.getParameter("m2-3");
           //    out.print(m2_3);
               String m2_4 = request.getParameter("m2-4");
           //    out.print(m2_4);
               String m2_5 = request.getParameter("m2-5");
           //    out.print(m2_5);
               
               //out.print(Opt1);
               String msg1 = null;
               String msg2 = null;
               
               if(!"".equals(m1_1) && !"".equals(m1_2) && !"".equals(m1_3) && !"".equals(m1_4) && !"".equals(m1_5) ){ // 5 มิติ
                    
                      msg1 = "0"+" "+m1_1+"\n"
                           +"1"+" "+m1_2+"\n"
                           +"2"+" "+m1_3+"\n"
                           +"3"+" "+m1_4+"\n"
                           +"4"+" "+m1_5;
                      
                      dim = "5";
             
               }else if(!"".equals(m1_1) && !"".equals(m1_2) && !"".equals(m1_3) && !"".equals(m1_4) && "".equals(m1_5)){// 4 มิติ
                    msg1 = "0"+" "+m1_1+"\n"
                           +"1"+" "+m1_2+"\n"
                           +"2"+" "+m1_3+"\n"
                           +"3"+" "+m1_4;
                    dim = "4";
               }else if(!"".equals(m1_1) && !"".equals(m1_2) && !"".equals(m1_3) && "".equals(m1_4) && "".equals(m1_5)){// 3 มิติ
                    msg1 = "0"+" "+m1_1+"\n"
                           +"1"+" "+m1_2+"\n"
                           +"2"+" "+m1_3;
                    dim = "3";
                    
               }else if(!"".equals(m1_1) && !"".equals(m1_2) && "".equals(m1_3) && "".equals(m1_4) && "".equals(m1_5)){// 2 มิติ
                    msg1 = "0"+" "+m1_1+"\n"
                           +"1"+" "+m1_2;
                    
                    dim="2";
               }else if(!"".equals(m1_1) && "".equals(m1_2) && "".equals(m1_3) && "".equals(m1_4) && "".equals(m1_5)){// 1 มิติ
                  msg1 = "0"+" "+m1_1;
                    dim="1";
               }else{
                   out.print("ERROR1 - Please enter the first metrix");
                   dim="error1";
               }               
                System.out.println("msg1 = "+msg1);
                
                //========================================= Join txt2
              
                if(!"".equals(m2_1) && !"".equals(m2_2) && !"".equals(m2_3) && !"".equals(m2_4) && !"".equals(m2_5) ){ // 5 มิติ
                    
                    msg2 = "0"+" "+m2_1+"\n"
                           +"1"+" "+m2_2+"\n"
                           +"2"+" "+m2_3+"\n"
                           +"3"+" "+m2_4+"\n"
                           +"4"+" "+m2_5;
                    dim2="5";
             
               }else if(!"".equals(m2_1) && !"".equals(m2_2) && !"".equals(m2_3) && !"".equals(m2_4) && "".equals(m2_5)){// 4 มิติ
                    msg2 = "0"+" "+m2_1+"\n"
                           +"1"+" "+m2_2+"\n"
                           +"2"+" "+m2_3+"\n"
                           +"3"+" "+m2_4;
                    dim2="4";
               }else if(!"".equals(m2_1) && !"".equals(m2_2) && !"".equals(m2_3) && "".equals(m2_4) && "".equals(m2_5)){// 3 มิติ
                    msg2 = "0"+" "+m2_1+"\n"
                           +"1"+" "+m2_2+"\n"
                           +"2"+" "+m2_3;
                    dim2="3";
               }else if(!"".equals(m2_1) && !"".equals(m2_2) && "".equals(m2_3) && "".equals(m2_4) && "".equals(m2_5)){// 2 มิติ
                    msg2 = "0"+" "+m2_1+"\n"
                           +"1"+" "+m2_2;
                    dim2="2";
               }else if(!"".equals(m2_1) && "".equals(m2_2) && "".equals(m2_3) && "".equals(m2_4) && "".equals(m2_5)){// 1 มิติ
                    msg2 = "0"+" "+m2_1;
                    dim2="1";
               }else{
                   out.print("ERROR2 - Please enter the second metrix");
                   dim2="error2";
               }
               System.out.println("msg2 = "+msg2);
               
               if(dim.equals(dim2)){
                   Writer output1 = null, output2 = null;
                   File file1 = new File(this.getServletContext().getRealPath("") +"/left");
                   File file2 = new File(this.getServletContext().getRealPath("")+"/right");
                   file1.createNewFile();
                   file2.createNewFile();
                   output1 = new BufferedWriter(new FileWriter(file1));
                   output2 = new BufferedWriter(new FileWriter(file2));
                   output1.write(msg1);
                   output2.write(msg2);
                   output1.close();
                   output2.close();

                   System.out.println("All file has been written");
                   System.out.println("where to write file1:"+file1.getAbsolutePath());
                   System.out.println("where to write file2:"+file2.getAbsolutePath());

                   //--------------------------- Start external program
                   String copyLeft = "/usr/local/hadoop/bin/hadoop dfs -copyFromLocal "+file1.getAbsolutePath()+" /user/tuk/NetBeansProjects/MyMul/input";
                   //String copyLeft = "cp "+file1.getAbsolutePath()+" /home/mickey/apache-tomcat-7.0.14/bin/input";
                   System.out.println("copyLeft command >> "+copyLeft);
                   String copyRight = "/usr/local/hadoop/bin/hadoop dfs -copyFromLocal "+file2.getAbsolutePath()+" /user/tuk/NetBeansProjects/MyMul/input";
                   //String copyRight = "cp "+file2.getAbsolutePath()+" /home/mickey/apache-tomcat-7.0.14/bin/input";
                   System.out.println("copyRight command >> "+copyRight);
                   //String setClassPath = "export HADOOP_CLASSPATH=/home/mickey/MyMul/bin";
                   String hadoopCmd = "/usr/local/hadoop/bin/hadoop MyMul /user/tuk/NetBeansProjects/MyMul/input /user/tuk/NetBeansProjects/MyMul/MyMul/output/"+dim;
                   String catCmd = "head /user/tuk/NetBeansProjects/MyMul/output/part-r-00000";
                   //String hadoop = "~/hadoop-0.20.203.0/bin/hadoop MyMul /home/mickey/MyMul/input /home/mickey/MyMul/output "+dim;
                   Runtime runtime = Runtime.getRuntime();
                   Process procCopyL = null, procCopyR = null, procClassPath = null, procHadoop = null, procCat = null;

                   Process process = null;
                   try {
                        System.out.println("Inside try to run runtime.exec");
                        procCopyL = runtime.exec(copyLeft);
                        procCopyR = runtime.exec(copyRight);
                        System.out.println("Files were copied");
                        //procClassPath = runtime.exec(setClassPath);
                        procHadoop = runtime.exec(hadoopCmd);
                        DataInputStream hdoopDIS = new DataInputStream(procHadoop.getInputStream());
                        String hadoopLine = null;
                        while ((hadoopLine = hdoopDIS.readLine()) != null) {
                            out.println(hadoopLine);
                        }
                        
                        procCat = runtime.exec(catCmd);
                        DataInputStream catDIS = new DataInputStream(procCat.getInputStream());
                        String catLine = null;
                        while ((catLine = catDIS.readLine()) != null) {
                            out.println(catLine);
                        }
                        /*
                        DataInputStream inR = new DataInputStream(procCopyR.getInputStream());
                        while ((lineR = inR.readLine()) != null) {
                            out.println(lineR);
                        }*/
                        /*process = runtime.exec(command);
                        
                        DataInputStream in = new DataInputStream(process.getInputStream());

                        // Read and print the output
                        String line = null;
                        while ((line = in.readLine()) != null) {
                            out.println(line);
                        }*/
                        System.out.println("Hadoop was run");
                   }catch(Exception e){
                        out.println("Problem with hadoop: "+ServletUtils.getStackTraceAsString(e));
                   }
               
               
               //System.out.println("THIS IS BUGGY");
               //System.out.println(txt1);
               //System.out.println(m1_1+" "+m1_2+""+m1_3);
               //System.out.println(m2_1+" "+m2_2+""+m2_3);

               }else{
                   out.println("Please enter the same matrix dimension");
               }
              
        } finally {            
            out.close();
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
