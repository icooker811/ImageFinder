/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

/**
 *
 * @author Tuky
 */
public class Block {

    public String name;
    public int x;
    public int y;
    public int width;
    public int height;
   
    public Block(String name,int x,int  y,int width,int height){
        this.name = name;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }
    
    
}
