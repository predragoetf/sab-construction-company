/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Stefan Tubic
 */
public class DB {
    //Connection string je u formatu: jdbc:sqlserver://[serverName[\instanceName][:portNumber]][;property=value[;property=value]]
    private static String serverName = "localhost";
    private static String instanceName = ".";
    private static int portNumber = 1433;
    private static String database = "gradjevina2";
    private static String username = "sa";
    private static String password = "sa";
    private static String connectionString = "jdbc:sqlserver://" + serverName + "\\" + instanceName + ":" + portNumber + ";databaseName=" + database + ";username=" + username + ";password=" + password;
    
    public static Connection connection;
    //public static Statement statement;
    
    static{
        try {
            connection = DriverManager.getConnection(connectionString);
            //statement = connection.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
