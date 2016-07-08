/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author OSAMA
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/ContactServlet"})
public class ContactServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
             request.setCharacterEncoding("UTF-8");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String msg = request.getParameter("message"); 
            
            String to="histopedia2016@gmail.com";
            String subject= "questionairing or helping";
            String mailmessage=name+" want to contact us.her/his information"
                    + "\n"
                    + "Name:    "+name+"\n"
                    + "Email:   "+email+"\n"
                    + "Phone:   "+phone+"\n"
                    + "Message:\n\t"
                    + msg;
            
            String from="histopedia2016@gmail.com";
            String host = "smtp.gmail.com";
            String password ="12345qwert12345asdfg";
            
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
                
                System.out.println("Message Sent Successfully");
                
                out.println("<script type=\"text/javascript\">");
                out.println("alert('message sent successfully.');");
                out.println("location='contact.html';");
                out.println("</script>");
                
                
            }catch(MessagingException excp){
                System.out.println(excp);
            }
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
