/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Project;
import Model.Search;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author hp
 */
@WebServlet(name = "getSearchValue", urlPatterns = {"/getSearchValue"})
public class getSearchValue extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        request.setCharacterEncoding("UTF-8");

        String searchValue = "";

        searchValue = request.getParameter("keyword");
        if (searchValue == null || searchValue == "") {
            System.out.println("Here Ya Kbeeeeeeeeeeeeeeeeeeeeeeeeeeer");
            response.sendRedirect("error.jsp");
            return;
        }

        User userobject = new User();
        Vector<User> users = new Vector<User>();
        users = userobject.getMatchedSearchUser(searchValue);

        for (int c = 0; c < users.size() - 1; c++) {
            for (int d = 0; d < users.size() - c - 1; d++) {
                Search searchobject = new Search();

                int count1 = searchobject.getCount(users.get(d).getName(), searchValue);
                int count2 = searchobject.getCount(users.get(d + 1).getName(), searchValue);
                if (count1 < count2) {

                    User swap = new User();
                    swap = users.get(d);
                    users.set(d, users.get(d + 1));
                    users.set(d + 1, swap);
                }
            }
        }

        Project projectobject = new Project();
        Vector<Project> projects = new Vector<Project>();
        projects = projectobject.GetMatchedSearchProject(searchValue);

        Search searchobject = new Search();
        Vector<Search> searchvector = new Vector<Search>();
        searchvector = searchobject.GetMatchedSearchTags(searchValue);
        System.out.println("in VecvecvevVecvecvevVecvecvevVecvecvevVecvecvevVecvecvevSIze SIzeSIzeSIzeSIzeSIze=" + projects.size());

        HashMap<Integer, String> mymap = new HashMap<Integer, String>();
        if (!projects.get(0).getName().equals("empty")) {
            System.out.println("projects.get(0).getName().equals(\"empty\")" + projects.get(0).getName());
            System.out.println(" MAAAAAAAAAAp ");

            for (int i = 0; i < projects.size(); i++) {

                mymap.put(projects.get(i).getProject_id(), projects.get(i).getName());
            }
        }

        if (projects.get(0).getName().equals("empty")) {

            mymap.put(-1, "empty");
        }

        for (int i = 0; i < searchvector.size(); i++) {
            if (mymap.get(searchvector.get(i).getProject_id()) == null) {

                if (mymap.get(-1) != null) {
                    System.out.println("in Iffffffffffffffffffffffffffffffff ");
                    mymap.clear();
                    //  projects.clear();
                }

                Project projectobject2 = new Project();

                projectobject2 = projectobject2.getProjectByProjectId(searchvector.get(i).getProject_id());

                System.out.println("in MAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaap =" + searchvector.get(i).getProject_id());

                if (projectobject2.getName() != null) {
                    mymap.put(projectobject2.getProject_id(), projectobject2.getName());
                    projects.add(projectobject2);
                }
            }
        }
        if (projects.size() > 1 && projects.get(0).getName().equals("empty")) {
           // System.out.println("remove emptyyyyyyyyyyyyyyyy Project  ");

            projects.remove(0);
        }

        if (!projects.get(0).getName().equals("empty")) {

            for (int c = 0; c < projects.size() - 1; c++) {
                for (int d = 0; d < projects.size() - c - 1; d++) {

                    int count1 = searchobject.getCount(projects.get(d).getName(), searchValue);
                    int count2 = searchobject.getCount(projects.get(d + 1).getName(), searchValue);
                    if (count1 < count2) {

                        Project swap = new Project();
                        swap = projects.get(d);
                        projects.set(d, projects.get(d + 1));

                        projects.set(d + 1, swap);
                    }
                }
            }

        }

        HttpSession session = request.getSession(true);

        session.setAttribute("matchusers", users);

        session.setAttribute("matchprojects", projects);

        response.sendRedirect("searchResults.jsp");

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getSearchValue</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getSearchValue at " + "" + "</h1>");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(getSearchValue.class.getName()).log(Level.SEVERE, null, ex);
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
