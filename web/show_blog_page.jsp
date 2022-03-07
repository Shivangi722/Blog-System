<%@page import="database.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="database.User_database"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Category"%>
<%@page import="entities.Post"%>
<%@page import="database.PostDao"%>
<%@page import="helper.Connection1"%>
<%@page import="entities.User_Register"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="Error_Page.jsp" %>
<%
    User_Register user=(User_Register)session.getAttribute("CurrentUser");
    if(user==null){
        response.sendRedirect("LogIn.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d =  new PostDao(Connection1.getConnection());
    Post p = d.getPostByPostId(postId);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle() %></title>
        <!-- css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/MyStyle.css">
        <style>
            .banner-background{
                clip-path: polygon(100% 0, 100% 94%, 67% 100%, 48% 95%, 31% 100%, 0 95%, 0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user_info{
                font-size: 20px;
            }
            .row_user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            body{
                background:url(img/background_img.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
        
        <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v9.0" nonce="3t3fQRbO"></script>

    </head>
    <body>
        
        <!--navbar start-->
        <nav class="navbar navbar-expand-lg navbar-dark primary_background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-gitlab"></span>Blog System</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                      <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="Profile.jsp"><span class="fa fa-leanpub"></span> Learn Code <span class="sr-only">(current)</span></a>
                        </li>

                        <li class="nav-item dropdown">
                          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                              <span class="fa fa-check-square-o"></span> Categories

                          </a>
                          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming</a>
                            <a class="dropdown-item" href="#">Project</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                          </div>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><span class="fa fa-mobile-phone"></span>  Contact</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span>  Add Post</a>
                        </li>
                         
                      </ul>
                        <ul class="navbar-nav mr-right">
                            <li class="nav-item">
                                <h5><a class="nav-link" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user"></span>  <%= user.getName()%></a></h5>
                            </li>
                        
                            <li class="nav-item">
                                <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-circle"></span>  LogOut</a>
                            </li>
                        
                        </ul>
                    </div>
        </nav>
        <!-- navbar end -->
        
        <!-- Main Content of the body-->
        <main>
            <div class="container">
                <div class="row my-4"> 
                    <div class="col-md-8 offset-md-2">
                        <div class="card ">
                            <div class="card-header primary_background text-white">
                                <h4 class="post-title"><%= p.getpTitle() %></h4>
                            </div>
                            <div class="card-body">
                                <img src="blog_pics/<%= p.getpPic()  %>" class="card-img-top my-2" alt="Card image cap">
                                <div class="row my-3 row_user">
                                    <div class="col-md-8">
                                        <%
                                            User_database ud=new User_database(Connection1.getConnection());
                                        %>
                                        <p class="post-user_info"><a href="#"> <%=ud.getUserByUserId(p.getUserId()).getName() %></a>: has posted</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p class="post-date"> <%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                    </div>
                                </div>
                                <p class="post-content"><%= p.getpContent() %></p>
                                <br>
                                <br>
                                <div class="post-code">
                                    <pre><%= p.getpCode() %></pre>
                                </div>
                            </div>
                            <div class="card-footer primary_background text-center">
                                
                                <%
                                  LikeDao ld= new LikeDao(Connection1.getConnection());
                                  
                                %>
                                <a href="#!" onclick="doLike(<%= p.getPid() %>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></a>
                                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
                            </div>
                                <div class="card-footer">
                                    <div class="fb-comments" data-href="http://localhost:8080/BlogSystem/show_blog_page.jsp?post_id=<%= p.getPid() %>" data-width="" data-numposts="5"></div>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- end Main Content of the body-->
            <!-- Modal -->
            <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header primary_background text-white text-center">
                    <h5 class="modal-title" id="exampleModalLabel">Blog System</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                      <div class="container text-center">
                          <img src="pics/<%=  user.getprofile()%>" class="img-fluid" style="border-radius:50%; max-width: 150px">
                          <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5> 
                          
                          <!--details-->
                          <div id="profile-details">
                          <table class="table table-striped">
                            <tbody>
                              <tr>
                                <th scope="row">Id : </th>
                                <td><%= user.getId() %></td>
                              </tr>
                              <tr>
                                <th scope="row">Email</th>
                                <td><%= user.getEmail() %></td>
                              </tr>
                              <tr>
                                <th scope="row">Gender</th>
                                <td><%= user.getGender() %></td>
                              </tr>
                              <tr>
                                <th scope="row">Status</th>
                                <td><%= user.getAbout() %></td>
                              </tr>
                              <tr>
                                <th scope="row">Registered Date</th>
                                <td><%= user.getDateTime().toLocalDateTime() %></td>
                              </tr>
                            </tbody>
                          </table>
                          </div>
                              <!--profile edit--->
                              <div id="profile-edit" style="display: none;">
                                  <h3 class="mt-2">Please Edit Carefully</h3>
                                  <form action="EditServlet" method="post" enctype="multipart/form-data">
                                      <table class="table">
                                          <tr>
                                              <td>ID :</td>
                                              <td><%= user.getId() %></td>
                                          </tr>
                                          <tr>
                                              <td>Email :</td>
                                              <td><input type="email" class="form-control" name="user-email" value="<%= user.getEmail() %>"></td>
                                          </tr>
                                          <tr>
                                              <td>Name :</td>
                                              <td><input type="text" class="form-control" name="user-name" value="<%= user.getName() %>"></td>
                                          </tr>
                                          <tr>
                                              <td>Password :</td>
                                              <td><input type="password" class="form-control" name="user-password" value="<%= user.getPassword() %>"></td>
                                          </tr>
                                          <tr>
                                              <td>Gender :</td>
                                              <td><%= user.getGender().toUpperCase() %></td>
                                          </tr>
                                          <tr>
                                              <td>About :</td>
                                              <td>
                                                  <textarea class="form-control" name="user-about" rows="3"> <%= user.getAbout() %>
                                                  </textarea>
                                              </td>
                                          </tr>
                                          <tr>
                                              <td>New Profile :</td>
                                              <td>
                                                  <input type="file" name="image" class="form-control">
                                              </td>
                                          </tr>
                                      </table>
                                                  <div class="container">
                                                      <button type="submit" class="btn btn-outline-primary">Save</button>
                                                  </div>
                                  </form>
                              </div>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                  </div>
                </div>
              </div>
            </div>
            <!--modal end-->
            
            <!-- post modal start-->
            
                <!-- Modal -->
                <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <div class="modal-body">
                          <form action="AddPostServlet" method="post" id="add-post-form">
                              <div class="form-group">
                                  <select class="form-control" name="cid">
                                      <option selected disabled>---select categories---</option>
                                      <%
                                          PostDao postd = new PostDao(Connection1.getConnection());
                                          ArrayList<Category> list = postd.getAllCategories();
                                          for(Category c:list){
                                      %>
                                      <option  value="<%= c.getCid() %>"><%= c.getName() %></option>
                                      <%
                                          }
                                      %>
                                  </select>
                              </div>
                              <div class='form-group'>
                                  <input type="text" name="pTitle" placeholder="Enter Post Title" class="form-control" required>
                              </div>
                              <div class='form-group'>
                                  <textarea placeholder="Enter your content" name="pContent" style="height:200px" class="form-control"></textarea>
                              </div>
                              <div class='form-group'>
                                  <textarea placeholder="Enter your program(if any)" name="pCode" style="height:200px" class="form-control"></textarea>
                              </div>
                              <div class='form-group'>
                                  <label>Select your pick</label><br>
                                  <input type="file" name="pic">
                              </div>
                              <div class="container text-center from-group">
                                  <button type="submit" class="btn btn-outline-primary">Post</button>
                              </div>
                          </form>
                      </div>
                      
                    </div>
                  </div>
                </div>
            <!-- post modal end-->
        
           
        <!-- javascript -->
        <script
            src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
            crossorigin="anonymous"></script> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/MyJavaScript.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function(){
                let editStatus=false;
                $('#edit-profile-btn').click(function(){
                    if(editStatus==false){
                        $('#profile-details').hide();
                        $('#profile-edit').show();
                        editStatus=true;
                        $(this).text("Back")
                    }
                    else{
                        $('#profile-details').show();
                        $('#profile-edit').hide();
                        editStatus=false;
                        $(this).text("Edit")
                    }
                })
            });
        </script>
        <!-- now add post js -->
        <script>
            $(document).ready(function (e){
                $("#add-post-form").on("submit",function(event){
                      //this code gets called when form is submitted...
                      event.preventDefault();
                      console.log("vdashdv")
                      let form =new FormData(this);
                        //now requesting call servlet                 
                        $.ajax({
                            url: "AddPostServlet",
                            type: 'POST',
                            data: form,
                            success: function(data, textStatus, jqXHR){
                                console.log(data)
                                if(data.trim()=='done'){
                                    swal("Good job!", "Save successfully..", "success");
                                }
                            },
                            error: function(jqXHR, textStatus, errorThrown){
                                swal("Error!", "Something went wrong!  try again", "error");
                            },
                            processData: false,
                            contentType: false
                        });
                });
            });
        </script>
    </body>
</html>
