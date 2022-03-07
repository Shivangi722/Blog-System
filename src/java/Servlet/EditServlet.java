package Servlet;

import database.User_database;
import entities.Message;
import entities.User_Register;
import helper.Connection1;
import helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            String userEmail = request.getParameter("user-email");
            String userName = request.getParameter("user-name");
            String userPassword = request.getParameter("user-password");
            String userAbout = request.getParameter("user-about");
            
            Part userProfile = request.getPart("image");
            
            String imageName=userProfile.getSubmittedFileName();
            //get the user  from the session ..
            HttpSession s=request.getSession();
            User_Register user=(User_Register)s.getAttribute("CurrentUser");
            
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile = user.getprofile();
            user.setprofile(imageName);
            //update databse
            User_database user_database = new User_database(Connection1.getConnection());
            
            boolean ans = user_database.updateUser(user);
            if(ans){
                String path=request.getRealPath("/")+"pics"+File.separator+user.getprofile();
                String oldpath=request.getRealPath("/")+"pics"+File.separator+oldFile;
                if(!oldFile.equals("default.png")){
                    Helper.deleteFile(oldpath);
                }
                    if(Helper.saveFile(userProfile.getInputStream(), path)){
                        Message msg=new Message("proile updated..","success","alert-success");
                        s.setAttribute("msg",msg);
                    }
            }
            else{ 
                Message msg=new Message("proile not updated..","error","alert-danger");
                        s.setAttribute("msg",msg);
            }
            response.sendRedirect("Profile.jsp");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
