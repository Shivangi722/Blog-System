
package database;
import entities.User_Register;
import java.sql.*;
import org.apache.catalina.User;

public class User_database {
    private Connection con;
    
    public User_database (Connection con)
    {
        this.con=con;
    }
    
    //insert data
    
    public boolean InsertUser(User_Register user){
        boolean b=false;
        try{
            //databse
            String query = "Insert into user_register(name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement pst=this.con.prepareStatement(query);
                                
            pst.setString(1,user.getName());
            pst.setString(2,user.getEmail());
            pst.setString(3,user.getPassword());
            pst.setString(4,user.getGender());
            pst.setString(5,user.getAbout());
            pst.executeUpdate();
            b=true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return b;
    }
    //get user by useremail and userpassword
    
    public User_Register getUserByEmailAndPassword(String Email, String Password){
        User_Register user=null;
        try{
            String query="select * from user_register where Email=? and Password=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1,Email);
            pst.setString(2,Password);
            ResultSet set = pst.executeQuery();
            if(set.next()){
                user=new User_Register();
                //data from db
                
                String name=set.getString("name");
                
                //set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email")); 
                user.setPassword(set.getString("password")); 
                user.setGender(set.getString("gender")); 
                user.setAbout(set.getString("about")); 
                user.setprofile(set.getString("profile")); 
                user.setDateTime(set.getTimestamp("rdate"));
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return user;
    } 

    public boolean updateUser(User_Register user1){
        boolean f=false;
        try{
            String query = "update user_register set Name=? , Email=? , Password=?, Gender=?, About=?, profile=? where Id=?";
            
            PreparedStatement pst = con.prepareStatement(query);
             
            pst.setString(1,user1.getName());
            pst.setString(2,user1.getEmail());
            pst.setString(3,user1.getPassword());
            pst.setString(4,user1.getGender());
            pst.setString(5,user1.getAbout());
            pst.setString(6, user1.getprofile());
            pst.setInt(7, user1.getId());
            
            pst.executeUpdate();
            
            f = true;
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    public User_Register getUserByUserId(int Id){
        User_Register user=null;
        try{
            String q="select * from user_register where Id=?";
            PreparedStatement p =  this.con.prepareCall(q);
            p.setInt(1, Id);
            ResultSet set = p.executeQuery();
            if(set.next()){
                user=new User_Register();
                //data from db
                
                String name=set.getString("name");
                
                //set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email")); 
                user.setPassword(set.getString("password")); 
                user.setGender(set.getString("gender")); 
                user.setAbout(set.getString("about")); 
                user.setprofile(set.getString("profile")); 
                user.setDateTime(set.getTimestamp("rdate"));
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return user;
    }
}
