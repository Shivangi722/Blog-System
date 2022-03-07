<%@page import="entities.User_Register"%>
<%@page import="database.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="entities.Post"%>
<%@page import="database.PostDao"%>
<%@page import="helper.Connection1"%>
<div class="row">
    <%
    User_Register user=(User_Register)session.getAttribute("CurrentUser");
    if(user==null){
        response.sendRedirect("LogIn.jsp");
    }
%>
<%
        Thread.sleep(1000);
        PostDao d = new PostDao(Connection1.getConnection());
        int cid=Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if(cid==0){
            posts = d.getAllPosts(); 
        }
        else{
            posts = d.getPostByCatId(cid);
        }
        if(posts.size()==0){
               out.println("<h3 class='display-3 text-center'>No posts in this category..</h3");
               return;
        }
        for(Post p:posts){
            %>
            <div class="col-md-6 mt-2">
                <div class="card">
                    <img src="blog_pics/<%= p.getpPic()  %>" class="card-img-top" alt="Card image cap">
                    <div class="card-body">
                        <b> <%= p.getpTitle() %> </b>
                        <p> <%= p.getpContent() %> </p>
                    </div>
                    <div class="card-footer primary_background text-center">
                        <%
                            LikeDao ld = new LikeDao(Connection1.getConnection());
                        %>
                        <a href="#!" onclick="doLike(<%= p.getPid() %>, <%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid()) %></span></a>
                        <a href="show_blog_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read More...</a>
                        <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
                    </div>
                </div>
            </div>
            <%
        }
%>
</div>