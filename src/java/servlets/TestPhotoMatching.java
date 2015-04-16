/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import com.labun.surf.IntegralImage;
import com.labun.surf.InterestPoint;
import com.labun.surf.Matcher;
import com.labun.surf.Params;
import ij.IJ;
import ij.ImagePlus;
import ij.gui.GenericDialog;
import ij.io.OpenDialog;
import ij.process.ImageProcessor;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

/**
 *
 * @author Tuky
 */
public class TestPhotoMatching {

    static String title = "SURF: Find Interest Points";

    /**
     * @param args the command line arguments
     */
    public static List<InterestPoint> ipts1;
    public TestPhotoMatching(String args) {
                String images = args;
        
       // images[1] = args[1];

        //////////////////////////////////////////////////////////////////

        ImagePlus activeImage1 = IJ.openImage(images);

        Params p = new Params();

        IntegralImage intImg1 = new IntegralImage(activeImage1.getProcessor(), true);

        ipts1 = IJFacade.detectAndDescribeInterestPoints(intImg1, p);
    
    }
    public static int run(String args) {
        // TODO code application logic here

        String[] images = new String[2];
        images[0] = args;
       // images[1] = args[1];

        //////////////////////////////////////////////////////////////////

        //ImagePlus activeImage1 = IJ.openImage(images[0]);
        ImagePlus activeImage2 = IJ.openImage(images[0]);

        Params p = new Params();


        IntegralImage intImg2 = new IntegralImage(activeImage2.getProcessor(), true);

        List<InterestPoint> ipts2 = IJFacade.detectAndDescribeInterestPoints(intImg2, p);

        System.out.print("ipts1: " + ipts1.size() + "\n");
        System.out.print("ipts2: " + ipts2.size() + "\n");
        // }

        Map<InterestPoint, InterestPoint> matchedPoints = Matcher.findMathes(ipts1, ipts2);
        if (true) {
           Map<InterestPoint, InterestPoint> matchedPointsReverse = Matcher.findMathes(ipts2, ipts1);
           matchedPoints = intersection(matchedPoints, matchedPointsReverse);
        }

        System.out.print(matchedPoints.size() + "\n");
        return matchedPoints.size();
    }

    static Map<InterestPoint, InterestPoint> intersection(Map<InterestPoint, InterestPoint> map1, Map<InterestPoint, InterestPoint> map2) {
        // take only those points that matched in the reverse comparison too
        Map<InterestPoint, InterestPoint> result = new HashMap<InterestPoint, InterestPoint>();
        for (InterestPoint ipt1 : map1.keySet()) {
            InterestPoint ipt2 = map1.get(ipt1);
            if (ipt1 == map2.get(ipt2)) {
                result.put(ipt1, ipt2);
            }
        }
        return result;
    }

    float[][] loadHomographyMatrixFromFile() {

        OpenDialog od = new OpenDialog("Choose a file containing 3x3 Homography Matrix" + " (" + title + ")", null);
        String dir = od.getDirectory();
        String fileName = od.getFileName();
        if (fileName == null) {
            return null;
        }
        String fullName = dir + fileName;
        float[][] res = new float[3][3];

        try {
            Scanner in = new Scanner(new File(fullName));
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                    res[i][j] = in.nextFloat();
                }
            }
            in.close();
        } catch (FileNotFoundException e) {
            IJ.error("SURF: loadHomographyFromFile", e.getMessage());
            res = null;
        }

        return res;
    }
}
