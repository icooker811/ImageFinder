package servlets;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.LinkedList;
import javax.servlet.http.HttpServlet;
import servlets.*;

/**
 *
 * @author Tuky
 */
public class Getdirection {

    public LinkedList<Block> line;
    public LinkedList<Node> nodemap;

    public void setMap(LinkedList<Block> blockmap) {

        nodemap = new LinkedList<Node>();

        for (int i = 0; i < blockmap.size(); i++) {

            Block A = blockmap.get(i);

            Node Apa = new Node(A.name, A.x, A.y);

            LinkedList<Block> connect = new LinkedList<Block>();
            System.out.println(" " + A.name);

            float[] scoords = {A.x, A.y};
            float[] sdimensions = {A.width, A.height};

            for (int j = 0; j < blockmap.size(); j++) {

                Block B = blockmap.get(j);

                // double angle = Math.atan2(B.y - A.y, B.x - A.x) * 180 / Math.PI;
                //System.out.println(angle);
                //&& (((A.y ) <= B.y ) && ((A.y + A.height ) <= B.y ) ||  (((B.y ) <= A.y ) && ((B.y + B.height ) <= A.y )))
                float[] coords = {B.x, B.y};
                float[] dimensions = {B.width, B.height};

                if (isOverlap(scoords, sdimensions, coords, dimensions) && i != j) {
                    System.out.println("c--->" + B.name);
                    connect.add(B);

                }

            }
            Apa.connect = connect;
            nodemap.add(Apa);
        }
    }

    private boolean isOverlap(float[] scoords, float[] sdimensions,
            float[] coords, float[] dimensions) {
        final float FUDGE_FACTOR = 1.021f;
        for (int i = 0; i < scoords.length; i++) {
            boolean overlapInThisDimension = false;
            if (scoords[i] == coords[i]) {
                overlapInThisDimension = true;
            } else if (scoords[i] < coords[i]) {
                if (scoords[i] + FUDGE_FACTOR * sdimensions[i] >= coords[i]) {
                    overlapInThisDimension = true;
                }
            } else if (scoords[i] > coords[i]) {
                if (coords[i] + FUDGE_FACTOR * dimensions[i] >= scoords[i]) {
                    overlapInThisDimension = true;
                }
            }
            if (!overlapInThisDimension) {
                return false;
            }
        }
        return true;
    }

    public LinkedList<Block> Getdirection(Block A, Block B) {

        System.out.println(A.name + "   " + B.name);
        LinkedList<Block> line = new LinkedList<Block>();
        line.add(A);
        Block now = A;
        while (!now.equals(B)) {

            for (int i = 0; i < nodemap.size(); i++) {
                Node Apa = nodemap.get(i);

                if (now.name.equalsIgnoreCase(Apa.name)) {
                    double min = 999;
                    Block bmin = null;

                    // System.out.println(Apa.connect.size());
                    for (int ii = 0; ii < Apa.connect.size(); ii++) {

                        Block bconnect = Apa.connect.get(ii);
                        double length = Math.sqrt((bconnect.x - B.x) * (bconnect.x - B.x) + (bconnect.y - B.y) * (bconnect.y - B.y));

                        if (bconnect.equals(B)) {
                            min = 0;
                            bmin = bconnect;
                            break;
                        } else {
                            for (int j = 0; j < nodemap.size(); j++) {
                                Node Secondpa = nodemap.get(j);

                                if (bconnect.name.equalsIgnoreCase(Secondpa.name)) {
                                    double smin = 999;

                                    for (int jj = 0; jj < Secondpa.connect.size(); jj++) {

                                        Block bsconnect = Secondpa.connect.get(jj);
                                        double slength = Math.sqrt((bsconnect.x - B.x) * (bsconnect.x - B.x) + (bsconnect.y - B.y) * (bsconnect.y - B.y));
                                        if (smin > slength && line.indexOf(bsconnect) == -1) {

                                            smin = slength;
                                        }

                                    }
                                    length = length + smin;
                                    break;
                                }
                            }

                            if (min > length && line.indexOf(bconnect) == -1) {
                                min = length;
                                bmin = bconnect;

                            }
                        }

                    }

                    now = bmin;
                    break;
                }
            }
            line.add(now);
            System.out.println("---->" + now.name);
        }
        return line;
    }

    public class Node {

        public String name;
        public int x;
        public int y;

        public LinkedList<Block> connect;

        public Node(String name, int x, int y) {
            this.name = name;
            this.x = x;
            this.y = y;
        }

    }
}
