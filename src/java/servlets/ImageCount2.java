/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

/**
 *
 * @author root
 */
import static ij.IJ.d2s;
import ij.IJ;
import ij.ImagePlus;
import ij.WindowManager;
import ij.gui.GenericDialog;
import ij.io.OpenDialog;
import ij.plugin.PlugIn;
import ij.process.ImageProcessor;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Map.Entry;

import com.labun.surf.IntegralImage;
import com.labun.surf.InterestPoint;
import com.labun.surf.Matcher;
import com.labun.surf.Params;
import com.labun.surf.Matcher.Point2Df;

import java.io.*;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * SUFT Algorithm Show description Image
 *
 * @author root
 */
public class ImageCount2 implements PlugIn {

    String title = "SURF: Find Interest Points";
    private static final String awsAccessKey = "AKIAIVBF3KZA7GD7HL6A";
    private static final String awsSecretKey = "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";
    private static final String BUCKET_NAME = "hadoopdesktop";

    public void run(String[] arg) {

        // Get IDs of opened images.
       /*
         int[] imageIDs = WindowManager.getIDList();
         if (imageIDs == null || imageIDs.length < 1) {
         IJ.error(title, "Please open an image first.");
         return;
         }
         * 
        
        
         int activeImageID = IJ.getImage().getID();
         // Prepare list of opened images
         int activeImageIndex = 0;
         String[] images = new String[imageIDs.length];
         for (int i = 0; i < imageIDs.length; i++) {
         images[i] = WindowManager.getImage(imageIDs[i]).getTitle();
         if (imageIDs[i] == activeImageID) {
         activeImageIndex = i;
         }
         }
         */
        //  String[]img =  arg);
        String[] images = new String[1];
        images[0] = arg[0]+""+arg[1];
        //System.out.println(arg);
        System.out.println(images[0]);
        final GenericDialog gd = new GenericDialog("Parameter" + " (" + title + ")");
        gd.addChoice("Image:", images, images[0]);

        Params.addSurfParamsToDialog(gd);
        //gd.showDialog();

        //if (gd.wasCanceled()) {
        //    return;
        //}
        // System.out.println("Hello");
        //////////////////////////////////////////////////////////////////

        ImagePlus activeImage = IJ.openImage(images[0]);
        Params p = Params.getSurfParamsFromDialog(gd);

        p.getStatistics().startTime = new Date();
        p.getStatistics().imageTitle = activeImage.getTitle();

        long begin, end;

        begin = System.currentTimeMillis();
        IntegralImage intImg = new IntegralImage(activeImage.getProcessor(), true);
        end = System.currentTimeMillis();
        p.getStatistics().timeIntegralImage = end - begin;

        List<InterestPoint> ipts = IJFacade.detectAndDescribeInterestPoints(intImg, p);

        System.out.println("Hello");

        if (ipts.size() == 0) {
            IJ.showMessage(title, "No Interest Points found.");
            return;
        }
        // String Text = "";
        //  for (int i = 0; i < ipts.size(); i++) {
        //    Text = Text + ipts.get(i) + "";
        // }
        String greeting = InterestPoint.messageToFile(ipts,  arg[1] , true);
        System.out.print(arg[0] + "/input/" + arg[1] + ".txt");
        SaveText.Text = SaveText.Text + greeting + "\n";


        try {
            // Create file 
            FileWriter fstream = new FileWriter(arg[0] + "/input/" + arg[1] + ".txt");
            BufferedWriter out = new BufferedWriter(fstream);
            out.write(greeting);
            //Close the output stream
            out.close();
        } catch (Exception e) {//Catch exception if any
            System.err.println("Error: " + e.getMessage());
        }

        /**
         * *****************************Save***************************
         */
        // InterestPoint.saveToFile(ipts, "/home/tuk/TestFindMember/input/input/"+activeImage.getTitle()+".txt", true);
        // Draw interest points on a copy of the active image.
        /*
         try {
         AWSCredentials awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);

         /* ************
         * Code Samples
         * ************
         */

        /*
         * Connecting to S3
         */
        // Your Amazon Web Services (AWS) login credentials are required to manage S3 accounts.
        // These credentials are stored in an AWSCredentials object:
        // To communicate with S3 use the RestS3Service.
           /* RestS3Service s3Service = new RestS3Service(awsCredentials);

         // A good test to see if your S3Service can connect to S3 is to list all the buckets you own.
         // If a bucket listing produces no exceptions, all is well.

           

         /*
         * Create a bucket
         */
        // To store data in S3 you must first create a bucket, a container for objects.

        /*  S3Bucket testBucket = s3Service.getBucket(BUCKET_NAME);

         String greeting = InterestPoint.messageToFile(ipts, activeImage.getTitle()+".txt", true);
         S3Object helloWorldObject = new S3Object("inputFileLocation/"+activeImage.getTitle()+".txt");


         ByteArrayInputStream greetingIS = new ByteArrayInputStream(
         greeting.getBytes(Constants.DEFAULT_ENCODING));
         helloWorldObject.setDataInputStream(greetingIS);
         helloWorldObject.setContentLength(
         greeting.getBytes(Constants.DEFAULT_ENCODING).length);
         helloWorldObject.setContentType("text/plain");

         // Upload the data objects.

         s3Service.putObject(testBucket, helloWorldObject);

         // Print details about the uploaded object.
         System.out.println("S3Object with data: " + helloWorldObject);

         } catch (Exception e) {
         System.err.println("Amazon cannot connecting");
         }


         /***************************************************************/
        ImageProcessor ip2 = activeImage.getProcessor().duplicate().convertToRGB();
        IJFacade.drawInterestPoints(ip2, ipts, p);
        String title = String.format("%s: %d Interest Points",
                activeImage.getTitle().split(":")[0], ipts.size());
        ImagePlus imp2 = new ImagePlus(title, ip2);
        //imp2.show();
//		imp2.getCanvas().zoom100Percent();

        //if (p.isDisplayStatistics()) {
        IJFacade.initializeStatisticsWindow();
        IJFacade.displayStatistics(p);
        // }


    }

    @Override
    public void run(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}