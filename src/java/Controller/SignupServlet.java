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
@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

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
            throws ServletException, IOException, MessagingException, SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            request.setCharacterEncoding("UTF-8");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            String uuid = UUID.randomUUID().toString();
            String sp[] = uuid.split("-");
            String key = sp[4];

            String to = email;
            String subject = "account activation";
            String mailmessage
                    = "\t\t\t WELCOME " + name.toUpperCase()
                    + "\n\n"
                    + "Thanks for signing up!\n"
                    + "Your account has been created, "
                    + "you can login after you have activated your account "
                    + "by pressing the url below."
                    + " \n"
                    + "Please click this link to activate your account:\n"
                    + "http://localhost:8080/HistoryEncyclopedia/accountActivation?email=" + email + "&key=" + key
                    + "\n"
                    + "Your's"
                    + "\n"
                    + "The Histopedia team ";

            String from = "histopedia2016@gmail.com";
            String host = "smtp.gmail.com";
            String pass = "12345qwert12345asdfg";

            Properties properties = System.getProperties();
            properties.put("mail.smtp.starttls.enable", "true");
            properties.setProperty("mail.smtp.host", host);
            properties.setProperty("mail.smtp.user", from);
            properties.setProperty("mail.smtp.password", pass);
            properties.setProperty("mail.smtp.port", "587");
            properties.setProperty("mail.smtp.auth", "true");
            Session session = Session.getDefaultInstance(properties, null);

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setActivate(0);
            user.setRkey(key);
            if (user.isEmailExist()) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('can not registered with previous registered email.');");
                out.println("location='signup.jsp';");
                out.println("</script>");
            } else if (user.addInDB()) {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(from));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject(subject);
                message.setText(mailmessage);
                Transport transport = session.getTransport("smtps");
                transport.connect(host, from, pass);
                InternetAddress[] addresses = new InternetAddress[1];
                addresses[0] = new InternetAddress(to);
                transport.sendMessage(message, addresses);

                HttpSession s = request.getSession();
                s.setAttribute("email", email);

                request.setAttribute("user_id", user.getUser_id());
                user.closeConnection();
                response.sendRedirect(request.getContextPath() + "/mypage.jsp?user_id=" + user.getUser_id());
                //RequestDispatcher View = getServletContext().getRequestDispatcher("/mypage.jsp");
                //View.forward(request, response);
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('uncompletely registeration process.');");
                out.println("location='signup.jsp';");
                out.println("</script>");
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
        try {
            processRequest(request, response);
        } catch (MessagingException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (MessagingException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
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
