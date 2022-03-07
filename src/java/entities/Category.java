package entities;
public class Category {
    
    private int cid;
    private String name;
    private String discription;

    public Category(int cid, String name, String description) {
        this.cid = cid;
        this.name = name;
        this.discription = description;
    }

    public Category() {
    }
    
    public Category(String name, String description){
        this.name = name;
        this.discription = description;
    }

    public int getCid() {
        return cid;
    }

    public String getDescription() {
        return discription;
    }

    public String getName() {
        return name;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public void setDescription(String description) {
        this.discription = description;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
