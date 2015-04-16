/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

/**
 *
 * @author Tuky
 */
public class BlockColor {
    public String name;
    public double up;
    public double down;
    public double ratio;
    public BlockColor(String name, double  up, double down , double ratio){
        this.name = name;
        this.up = up;
        this.down = down;
        this.ratio = ratio;
    }
}
