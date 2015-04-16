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
import ij.gui.GenericDialog;
import ij.plugin.PlugIn;
import ij.process.ImageProcessor;

import com.labun.surf.IntegralImage;
import com.labun.surf.InterestPoint;
import com.labun.surf.Params;

import java.util.Date;
import java.util.List;



/**
 *SUFT Algorithm Show description Image
 * @author root
 */
public class ImageCount1 implements PlugIn {

    String title = "SURF: Find Interest Points";
  //  private static final String awsAccessKey = "AKIAIVBF3KZA7GD7HL6A";
  //  private static final String awsSecretKey = "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";
  //  private static final String BUCKET_NAME = "hadoopdesktop";
    
   
    public void run(String arg[]) {

     
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
        String[] images = new String[1];
        images[0] = arg[0];
        //System.out.println(arg);
        System.out.println(arg[0]);
   //     GenericDialog gd = new GenericDialog("Parameter" + " (" + title + ")");
      //  gd.addChoice("Image:", images, images[0]);

      //  Params.addSurfParamsToDialog(gd);
        //gd.showDialog();

        //if (gd.wasCanceled()) {
        //    return;
        //}
        System.out.println("Hello");
        //////////////////////////////////////////////////////////////////

        ImagePlus activeImage = IJ.openImage(images[0]);
      //  Params p = Params.getSurfParamsFromDialog(gd);

     //   p.getStatistics().startTime = new Date();
     //  p.getStatistics().imageTitle = activeImage.getTitle();

        long begin, end;

        begin = System.currentTimeMillis();
        IntegralImage intImg = new IntegralImage(activeImage.getProcessor(), true);
        end = System.currentTimeMillis();
     //   p.getStatistics().timeIntegralImage = end - begin;

        List<InterestPoint> ipts = IJFacade.detectAndDescribeInterestPoints(intImg);

        System.out.println("Hello");

        if (ipts.size() == 0) {
            IJ.showMessage(title, "No Interest Points found.");
            return;
        }
        String Text = "";
        for (int i = 0; i < ipts.size(); i++) {
            Text = Text + ipts.get(i) + "";
        }

        /*
        try {
        // Create file 
        FileWriter fstream = new FileWriter("/home/tuk/TestFindMember/input/"+activeImage.getTitle()+".txt");
        BufferedWriter out = new BufferedWriter(fstream);
        out.write(Text);
        //Close the output stream
        out.close();
        } catch (Exception e) {//Catch exception if any
        System.err.println("Error: " + e.getMessage());
        }
         */
        InterestPoint.saveToFile1(ipts, arg[1]+"/input/input1.txt", true);
      //  InterestPoint.saveToFile1(ipts, "input.txt", true);
        // Draw interest points on a copy of the active image.
        /*
        try {

            AWSCredentials awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);

         
            RestS3Service s3Service = new RestS3Service(awsCredentials);

            S3Bucket testBucket = s3Service.getBucket(BUCKET_NAME);

            File fileData = new File("input.txt");
            S3Object fileObject = new S3Object(fileData);

            fileObject.setAcl(AccessControlList.REST_CANNED_PUBLIC_READ);

            s3Service.putObject(testBucket, fileObject);

            System.out.println("S3Object with data: " + fileObject);


        } catch (Exception e) {
            System.err.println("Amazon cannot connecting");
        }
        * */

        System.out.println("yes");
        ImageProcessor ip2 = activeImage.getProcessor().duplicate().convertToRGB();
//        IJFacade.drawInterestPoints(ip2, ipts, p);
        String title = String.format("%s: %d Interest Points",
                activeImage.getTitle().split(":")[0], ipts.size());
        ImagePlus imp2 = new ImagePlus(title, ip2);
        //imp2.show();
//		imp2.getCanvas().zoom100Percent();

        //if (p.isDisplayStatistics()) {
          IJFacade.initializeStatisticsWindow();
     //   IJFacade.displayStatistics(p);
        // }


    }

    @Override
    public void run(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
