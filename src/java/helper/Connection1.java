package helper;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class Connection1 {
    private static Connection con;
    public static Connection getConnection(){
        try{
            if(con==null){
                Class.forName("com.mysql.cj.jdbc.Driver");
                String s1 = "jdbc:mysql://localhost:3306/blogsystem?useSSL=false";
                String s2 = "root";
                String s3 = "root";
                con = DriverManager.getConnection(s1,s2,s3);
            }
        }
        catch(Exception e){
            e.printStackTrace(); 
            System.out.println(con);
        }
        
        return con;
    }
}
