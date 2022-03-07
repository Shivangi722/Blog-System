<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <!-- css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/MyStyle.css">
        
    </head>
    <body>
        <!-- navbar--> 
        <%@include file="navbar.jsp"%>
        
        <main class="primary_background p-5 " style="padding-bottom: 50px">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header text-center">
                            <span class="fa fa-user fa-2x"></span>
                            <h3>Register Here</h3>
                        </div>
                        <div class="card-body">
                            <form action="RegisterServlet" id="reg-form" method="POST">
                                    <div class="form-group">
                                      <label for="user_name">User Name</label>
                                      <input type="text" name="user_name" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputEmail1">Email address</label>
                                      <input type="email" name="user_email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Password</label>
                                      <input type="password" name="user_password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                    </div>
                                    <div class="form-group">
                                      <label for="exampleInputPassword1">Gender</label>
                                      <br>
                                      <input type="radio" id="gender" name="gender" value="Male">Male
                                      <input type="radio" id="gender" name="gender" value="Female">FeMale
                                    </div>
                                    <div class="form-group">
                                        <textarea name="about" class="form-control" id="" rows="5" placeholder="Enter Something about Yourself"></textarea>
                                    </div>
                                    <div class="form-check">
                                      <input type="checkbox" name="check" class="form-check-input" id="exampleCheck1">
                                      <label class="form-check-label" for="exampleCheck1">Agree term and condition</label>
                                    </div>
                                <br>
                                <div class="container text-center" id="loader" style="display: none;">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4> please wait.. </h4>
                                </div>
                                <button type="submit" id="submit-btn" class="btn btn-primary">SignUp</button>
                            </form>
                        </div>
                        
                    </div>
                </div>
            </div>
        </main>
        <!-- script-->
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
                console.log("loaded")
                $('#reg-form').on('submit',function(event){
                    event.preventDefault();
                    let form=new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();
                    //send register servlet
                    $.ajax({
                        url: "RegisterServlet",
                        type:'POST',
                        data: form,
                        success: function(data, textStatus, jqXHR){
                            console.log(data)
                            $("#submit-btn").show();
                            $("#loader").hide();
                            if(data.trim()==='done'){
                                swal("Register successfully.. ")
                                    .then((value) => {
                                        window.location = "LogIn.jsp"
                                });
                            }
                            else{
                                swal(data);
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown){
                            $("#submit-btn").show();
                            $("#loader").hide();
                            swal("Something went wrong.. Please try again ");
                        },
                        processData: false,
                        contentType: false
                    });           
                });
            });
        </script>
    </body>
</html>
