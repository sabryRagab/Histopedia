/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author OSAMA
 */
@WebServlet(name = "ForgetPasswordServlet", urlPatterns = {"/ForgetPasswordServlet"})
public class ForgetPasswordServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
             request.setCharacterEncoding("UTF-8");
            String uuid = UUID.randomUUID().toString();
            String sp[]=uuid.split("-");
            String key= sp[4];
            
            String to=request.getParameter("email");
            User user=new User();
            user.setEmail(to);
            if( !user.isEmailExist()) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Email address is not in exist in the system.');");
                out.println("location='index.jsp';");
                out.println("</script>");
                return;
            }
            String subject= "reset password";
            String mailmessage=
                    "SomBody (hofully you) request a new password for Histopedia"
                    + " account for "+to
                    + " no change have made to your account yet."
                    +"\n"
                    + "you can reset your password"
                    + " using this key:"
                    + "\n\t\t"
                    +key
                    +"\n"
                    + "Your's"
                    + "\n"
                    + "The Histopedia team ";
            
            
            user.addKeyInDB(to,key);
            user.closeConnection();
            HttpSession s = request.getSession();
            s.setAttribute("email", to);

            
            String from="histopedia2016@gmail.com";
            String host = "smtp.gmail.com";
            String password ="12345qwert12345asdfg";
            int port = 587;   //465
            
            Properties properties = System.getProperties();
            properties.put("mail.smtp.starttls.enable", "true");
            properties.setProperty("mail.smtp.host",host );
            properties.setProperty("mail.smtp.user", from);
            properties.setProperty("mail.smtp.password", password);
            properties.setProperty("mail.smtp.port", "587");
            properties.setProperty("mail.smtp.auth", "true");
            Session session = Session.getDefaultInstance(properties,null);
            try
            {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(from));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject(subject);
                message.setText(mailmessage);
                Transport transport = session.getTransport("smtps");
                transport.connect(host,from,password);
                InternetAddress[] addresses = new InternetAddress[1];
                addresses[0] = new InternetAddress(to);
                transport.sendMessage(message,addresses);
                
            }catch(MessagingException excp){
                System.out.println(excp);
            }
            
            RequestDispatcher View = getServletContext().getRequestDispatcher("/keyValidation.jsp");
            View.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ForgetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ForgetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
