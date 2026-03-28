package com.app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;;


public class DBManager {
    public static Connection getConnection() throws SQLException, ClassNotFoundException{

        Class.forName("com.mysql.cj.jdbc.Driver");

        String dbUrl = System.getenv("DB_URL");
        String dbUser = System.getenv("DB_USER");
        String dbPass  = System.getenv("DB_PASS");

        if(dbUrl == null){
            System.out.println("WARNING: DB_URL env variable is missing , Using localhostfallback");
            dbUrl = "jdbc:mysql://localhost:3306/testdb";
            dbUser = "root";
            dbPass = "root";
        }
        return DriverManager.getConnection(dbUrl, dbUser, dbPass);
    }
    
}
