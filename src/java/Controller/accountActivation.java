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
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "accountActivation", urlPatterns = {"/accountActivation"})
public class accountActivation extends HttpServlet {

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
            String email = request.getParameter("email");
            String key = request.getParameter("key");
            if (((email.equals("")) || (email.equals(null))) || ((key.equals("")) || (key.equals(null)))) {
                System.out.println("error");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('can't activate your account, some error happened.');");
                out.println("location='index.jsp';");
                out.println("</script>");
            } else {
                User user = new User();
                if (user.activateUser(email, key)) {
                    HttpSession s = request.getSession();
                    s.setAttribute("email", email);
                    user.setEmail(email);
                    int id = user.getIdByEmail();
                    request.setAttribute("user_id", id);
                    user.closeConnection();
                    user.setUser_id(id);
                    response.sendRedirect(request.getContextPath() + "/mypage.jsp?user_id=" + user.getUser_id());
                } else {
                    user.closeConnection();
                    System.out.println("error");
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('can't activate your account, some error happened.');");
                    out.println("location='index.jsp';");
                    out.println("</script>");
                }
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
        } catch (SQLException ex) {
            Logger.getLogger(accountActivation.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(accountActivation.class.getName()).log(Level.SEVERE, null, ex);
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
