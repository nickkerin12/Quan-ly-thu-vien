package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    
    
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-99T6CSB8:1433;databaseName=LibraryManagement;encrypt=true;trustServerCertificate=true;";
    
    private static final String USER = "sa"; 
    
    private static final String PASS = "12345"; 
    
    // 4. Driver
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Nạp driver SQL Server
            Class.forName(DRIVER);
            
            // Mở kết nối
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("LỖI: Không thể kết nối đến SQL Server! Kiểm tra lại DB_URL, USER, PASS và JDBC Driver.");
        }
        return conn;
    }
}