package database;
import entities.Category;
import entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list = new ArrayList<>();
        try{
            String query = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(query);
            while(set.next()){
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("discription");
                Category c = new Category(cid,name,description);
                list.add(c);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean savePost(Post p){
        boolean f=false;
         try{
             String q="insert into post(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
             PreparedStatement pst=con.prepareStatement(q);
             pst.setString(1, p.getpTitle());
             pst.setString(2, p.getpContent());
             pst.setString(3, p.getpCode());
             pst.setString(4, p.getpPic());
             pst.setInt(5, p.getCatId());
             pst.setInt(6, p.getUserId());
             pst.executeUpdate();
             f=true;
         }
         catch(Exception e){
             e.printStackTrace();
         }
        return f;
    }
    
    //get all the post
    public List<Post> getAllPosts(){
        
        List<Post> list = new ArrayList<>();
        
            //fetch all the post
            
            try{
                PreparedStatement p = con.prepareStatement("select * from post order by pid desc");
                ResultSet set = p.executeQuery();
                while(set.next()){
                    int pid=set.getInt("pid");
                    String pTitle = set.getString("pTitle");
                    String pContent = set.getString("pContent");
                    String pCode = set.getString("pCode");
                    String pPic = set.getString("pPic");
                    Timestamp date = set.getTimestamp("pDate");
                    int catId = set.getInt("catId");
                    int userId = set.getInt("userId");
                    Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);  
                    list.add(post);
                }
            }
            catch(Exception e){
                e.printStackTrace();
            }
        return list;
    }
    
    public List<Post> getPostByCatId(int catId){
        List<Post> list = new ArrayList<>();
        
            //fetch all the post by id 
             try{
                PreparedStatement p = con.prepareStatement("select * from post where catId=?");
                p.setInt(1, catId);
                ResultSet set = p.executeQuery();
                while(set.next()){
                    int pid=set.getInt("pid");
                    String pTitle = set.getString("pTitle");
                    String pContent = set.getString("pContent");
                    String pCode = set.getString("pCode");
                    String pPic = set.getString("pPic");
                    Timestamp date = set.getTimestamp("pDate");
                    int userId = set.getInt("userId");
                    Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);  
                    list.add(post);
                }
            }
            catch(Exception e){
                e.printStackTrace();
            }
        return list;
    }
    
    public Post getPostByPostId(int postId){
        Post post=null;
        try{
            String q = "select * from post where pid=?";
            PreparedStatement p = this.con. prepareStatement(q);
            p.setInt(1, postId);
            ResultSet set = p.executeQuery();
            if(set.next()){
                int pid=set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int cid=set.getInt("userId");
                int userId = set.getInt("userId");
                post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, userId);  
                   
            }
        }
        catch(Exception e){
            e.printStackTrace();
        } 
        return post;
    }
}

