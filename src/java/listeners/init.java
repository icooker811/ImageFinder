/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

/**
 * Web application lifecycle listener.
 * @author mickey
 */
public class init implements ServletContextListener {
    
    Connection conn;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
                try {
                    conn = getMemberdb().getConnection();
                } catch (SQLException ex) {
                                   
            }
        } catch (NamingException ex) {

        }
    
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
          try {
            conn.close();
        } catch (SQLException ex) {
          
        }
    }

    private DataSource getMemberdb() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/memberdb");
    }
}
