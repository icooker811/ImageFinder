/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author mickey
 */
public class MemberTable {
    
    public Member findById(int id){
        Member member = new Member();
        try {
            Connection conn = getMemberdb().getConnection();
            Statement stm  = conn.createStatement();        // Query cmd to query the database return result in resultset เหมือนเป็นสเต็บนะ จำๆๆๆ
            String sql = "Select * From member where id like '"+id+"'";
            ResultSet result = stm.executeQuery(sql);
            
            if(result.next()){// แบงค์กล่าวว่า "sql ที่ query เข้ามาจะอยู่เหมือนแบบบรรทัดถัดไปข้อมูลใน resultset" เราก็เลยต้อง .next ไปตัวนึง
                System.out.println("++++++++++++++++++++++++++++++++");
                member.setId(result.getInt(1)); // สร้าง obj จาก class member มาแล้ว query >>> 1 คือ column แรก
                member.setName(result.getString(2));
                member.setPassword(result.getString(3));
                member.setEmail(result.getString(4));
            }
            else{
                System.out.println("------------------------------");
                member = null;
            }
        } catch (Exception ex) {
            
        }
        return member;
       }
    
    

    private DataSource getMemberdb() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/memberdb");
    }
    
    
}