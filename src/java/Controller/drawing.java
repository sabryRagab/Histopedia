package Controller;

import Model.Circle;
import Model.Marker;
import Model.Polygon;
import Model.Polyline;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ahmed
 */
@WebServlet(urlPatterns = {"/drawing"})
public class drawing extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            request.setCharacterEncoding("UTF-8");
            int event_id = Integer.parseInt(request.getParameter("event_id"));

                    //////////////marker
            String marker = request.getParameter("marker");
            String info = request.getParameter("info");
            String infoarr[] = info.split(",");
            //out.println(info + "<br>");
            if (!marker.equals("")) {
                String markers[] = marker.split(" ");
                int markerParamter = 2;
                int j = 0;
                for (int i = 0; i < markers.length; i++) {
                    out.println(markers[i] + "------");
                    if (i % 2 == 0) {
                        markers[i] = markers[i].substring(1, markers[i].length() - 1);
                        //out.println( markers[i] );
                    } else {
                        markers[i] = markers[i].substring(0, markers[i].length() - 1);
                        //out.println( markers[i] );
                    }
                    if (i % 2 == 1) {
                        Marker mark = new Marker(-1, event_id, Double.parseDouble(markers[i - 1]), Double.parseDouble(markers[i]), infoarr[j], "icon", null);
                        mark.insertSimpleMarker();
                        j++;
                    }

                }
            }
            /////////////marker

            String polyline = request.getParameter("polyline");
            String polylines[] = polyline.split(" ");
            String polylinecordinate = request.getParameter("polylinecordinats");
            String polylinecordinates[] = polylinecordinate.split("his");
            //

            /// polyline 
            int paramterNumberPolygon = 6;
            for (int i = 0, j = 0; i < (polylines.length) / paramterNumberPolygon; i++, j += (paramterNumberPolygon - 1)) {

                Polyline polyl = new Polyline();
                polyl.insertPolylineInDB(event_id, polylines[i + j], polylines[i + 1 + j], polylines[i + 2 + j],
                        polylines[i + 3 + j], polylines[i + 4 + j], polylines[i + 5 + j], polylinecordinates[i]);
            }

            String polygon = request.getParameter("polygon");
            String polygons[] = polygon.split(" ");
            String polygoncordinate = request.getParameter("polygoncordinats");
            String polygoncordinates[] = polygoncordinate.split("his");
            /// polygne
            for (int i = 0, j = 0; i < (polygons.length) / paramterNumberPolygon; i++, j += (paramterNumberPolygon - 1)) {

                Polygon poly2 = new Polygon();
                poly2.insertPolygonInDB(event_id, polygons[i + j], polygons[i + 1 + j], polygons[i + 2 + j],
                        polygons[i + 3 + j], polygons[i + 4 + j], polygons[i + 5 + j], polygoncordinates[i]);
            }

            String circle = request.getParameter("circle");
            String circles[] = circle.split(" ");
            int paramterNumberCircle = 8;
            for (int i = 0, j = 0; i < (circles.length) / paramterNumberCircle; i++, j += (paramterNumberCircle - 1)) {
                Circle c1 = new Circle();
                c1.insertCircleInDB(event_id, circles[i + j], circles[i + 1 + j], circles[i + 2 + j], circles[i + 3 + j], circles[i + 4 + j], circles[i + 5 + j], circles[i + 6 + j], circles[i + 7 + j]);
            }

            response.sendRedirect("editEvent.jsp?event_id="
                    + event_id);

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
            Logger.getLogger(drawing.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(drawing.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(drawing.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(drawing.class.getName()).log(Level.SEVERE, null, ex);
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
