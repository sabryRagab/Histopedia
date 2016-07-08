package Model;

import com.sun.corba.se.impl.oa.poa.Policies;
import java.io.OutputStream;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;

public class Event extends DatabaseConnection {

    private int event_id;
    private int project_id;
    private int is_published;
    private int year;
    private int month;
    private int day;
    private double lat;
    private double lng;
    private String details;
    private int map_zoom_level;
    private ArrayList<Marker> markers;
    private ArrayList<Infowindow> infowindows;
    private ArrayList<Circle> circles;
    private ArrayList<Polygon> polygons;
    private ArrayList<Polyline> polylines;

    public Event() throws SQLException {
        super();
    }

    public Event(int event_id, int project_id, int is_published, int year, int month, int day, double lat, double lng, String details, int map_zoom_level) throws SQLException {
        super();
        this.event_id = event_id;
        this.project_id = project_id;
        this.is_published = is_published;
        this.year = year;
        this.month = month;
        this.day = day;
        this.lat = lat;
        this.lng = lng;
        this.details = details;
        this.map_zoom_level = map_zoom_level;
    }

    public int getIs_published() {
        return is_published;
    }

    public void setIs_published(int is_published) {
        this.is_published = is_published;
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public int getMap_zoom_level() {
        return map_zoom_level;
    }

    public void setMap_zoom_level(int map_zoom_level) {
        this.map_zoom_level = map_zoom_level;
    }

    public ArrayList<Marker> getMarkers() {
        return markers;
    }

    public void setMarkers(ArrayList<Marker> markers) {
        this.markers = markers;
    }

    public ArrayList<Infowindow> getInfowindows() {
        return infowindows;
    }

    public void setInfowindows(ArrayList<Infowindow> infowindows) {
        this.infowindows = infowindows;
    }

    public ArrayList<Circle> getCircles() {
        return circles;
    }

    public void setCircles(ArrayList<Circle> circles) {
        this.circles = circles;
    }

    public ArrayList<Polygon> getPolygons() {
        return polygons;
    }

    public void setPolygons(ArrayList<Polygon> polygons) {
        this.polygons = polygons;
    }

    public ArrayList<Polyline> getPolylines() {
        return polylines;
    }

    public void setPolylines(ArrayList<Polyline> polylines) {
        this.polylines = polylines;
    }

    /**
     * Author :abdelrahman Hellawy
     *
     * @param event_id
     * @return Event
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public Event getEvent(int event_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;
        String id;
        id = Integer.toString(event_id);

        pstmt = con.prepareStatement("select * from event where event_id=" + id);

        rs = pstmt.executeQuery();
        Event event_object = new Event();
        if (rs.next()) {
            event_object.event_id = rs.getInt(1);
            event_object.year = rs.getInt(4);
            event_object.month = rs.getInt(5);
            event_object.day = rs.getInt(6);
            event_object.details = rs.getString(7);
            event_object.map_zoom_level = rs.getInt(8);
            event_object.lat = rs.getDouble(9);
            event_object.lng = rs.getDouble(10);
                        Circle circle = new Circle();
            event_object.setCircles(circle.getCircles(rs.getInt(1)));

            Polygon polygon = new Polygon();
            event_object.setPolygons(polygon.getPolygons(rs.getInt(1)));

            Polyline polyline = new Polyline();
            event_object.setPolylines(polyline.getPolylines(rs.getInt(1)));

            Marker marker = new Marker();
            event_object.setMarkers(marker.getMarkers(rs.getInt(1)));


        }
        this.closeConnection();
        return event_object;
    }

    /**
     * Author :abdelrahman Hellawy
     *
     * @param eventobject
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void update_text_editor(Event eventobject) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement preparedStatement = null;
        System.out.println("Updaaaaaaaaaaaaaaaaaaated Text editor" + event_id);
        String event_id = "";
        Integer.toString(eventobject.getEvent_id());

        String sql = "UPDATE event SET details = ? "
                + " WHERE event_id = ?";
        preparedStatement = con.prepareStatement(sql);

        preparedStatement.setString(1, eventobject.getDetails());
        preparedStatement.setInt(2, eventobject.getEvent_id());

        // execute update SQL stetement
        int affected = preparedStatement.executeUpdate();

        if (affected > 0) {
            System.out.println("The row updaaaaaaaaaaaaaaaaaaaaaaaated");
        } else {
            System.out.println("No User CReated");
        }

        System.out.println("savvvvvvvvvvvvvvvvvvvvvvvvvvvvve function");
        this.closeConnection();
    }

    /**
     * @Author AbdelRahman Gamal
     * @param yr
     * @param mon
     * @param dy
     * @param projectId
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void setEventDate(int yr, int mon, int dy, int projectId) throws SQLException, ClassNotFoundException {
        this.openConnection();
        String parmQuery = "Insert Into event (year,month,day,map_zoom_level,lat,lng,project_id) Values (?,?,?,?,?,?,?)";

        PreparedStatement stmt;
        stmt = con.prepareStatement(parmQuery, Statement.RETURN_GENERATED_KEYS);

        stmt.setInt(1, yr);
        stmt.setInt(2, mon);
        stmt.setInt(3, dy);
        stmt.setInt(4, 2);
        stmt.setDouble(5, 17.214264);
        stmt.setDouble(6, 15.644531);
        stmt.setInt(7, projectId);
        stmt.executeUpdate();
        this.closeConnection();
    }

    /**
     * @Author Abdelrahman Gamal
     * @param lat
     * @param lng
     * @param zoom
     * @param id
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void saveCoordinates(double lat, double lng, int zoom, int id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        Statement stmt = null;
        try {
            stmt = (Statement) con.createStatement();
            String q = "UPDATE event SET lat='" + lat + "'" + ", lng='" + lng + "'" + ", map_zoom_level='" + zoom + "'" + "WHERE event_id='" + id + "'";
            stmt.executeUpdate(q);

        } catch (Exception e) {
            out.print(e);
        }
        stmt.close();
        this.closeConnection();
    }

    /**
     * @Author Abdelrahman Gamal
     * @return id
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public int getLastEventId() throws ClassNotFoundException, SQLException {
        this.openConnection();
        ResultSet RS = null;
        Statement statement = null;
        int id = 0;
        try {
            statement = (Statement) con.createStatement();
            RS = statement.executeQuery("SELECT * FROM event ORDER BY event_id DESC LIMIT 1");
            while (RS.next()) {
                id = RS.getInt(1);
            }
        } catch (Exception e) {
            out.print(e);
        }

        statement.close();
        RS.close();
        statement.close();
        this.closeConnection();
        return id;
    }

    /**
     * @Author Abdelrahman Gamal
     * @param id
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public void deleteCurrentEvent(int id) throws ClassNotFoundException, SQLException {
        this.openConnection();
        String parmQuery = "delete from event where event_id = ? ";
        PreparedStatement preStm = con.prepareStatement(parmQuery);
        preStm.setInt(1, id);
        preStm.executeUpdate();

        preStm.close();
        this.closeConnection();
    }

    /**
     * @Author Abdelrahman Gamal
     * @param id
     * @return date
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public String getEventDate(int id) throws ClassNotFoundException, SQLException {
        this.openConnection();
        String date = "";
        ResultSet RS = null;
        Statement statement = null;
        try {
            statement = (Statement) con.createStatement();
            RS = statement.executeQuery("SELECT day,month,year FROM event where event_id='" + id + "'");
            while (RS.next()) {
                date += RS.getInt("day") + " ";
                date += RS.getInt("month") + " ";
                date += RS.getInt("year") + " ";
            }
        } catch (Exception e) {
            out.print(e);
        }

        RS.close();
        statement.close();
        this.closeConnection();
        return date;
    }

    /**
     * @Author Abdelrahman Gamal
     * @param month
     * @return monthName[month]
     */
    public String nameOfMonth(int month) {
        String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        return monthNames[month];
    }

    /**
     * @Author Abdelrahman Gamal
     * @param year
     * @param month
     * @param day
     * @param published
     * @param id
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void saveUpdatedDate(int year, int month, int day, int published, int id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            String q = "update event set year=" + year + ", month=" + month + " , day=" + day + ", is_published=" + published + " where event_id=" + id + "";
            //update event set year=100 , month=5 , day=1 , is_published=1 where event_id=1
            stmt.executeUpdate(q);

        } catch (Exception e) {
            out.print(e);
        }

        stmt.close();
        this.closeConnection();
    }

    
    /**
     * @Author Abdelrahman Gamal
     * @param id
     * @return project_id
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public int getProject_id(int id) throws ClassNotFoundException, SQLException {
        this.openConnection();
        int project_id = 0;
        ResultSet RS = null;
        Statement statement = null;
        try {
            statement = (Statement) con.createStatement();
            RS = statement.executeQuery("select project_id from event where event_id='" + id + "'");
            while (RS.next()) {
                project_id = RS.getInt("project_id");
            }
        } catch (Exception e) {
            out.print(e);
        }

        RS.close();
        statement.close();
        this.closeConnection();
        return project_id;
    }

    /**
     * @Author Abdelrahman Gamal
     * @param id
     * @return is_publish
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public int is_published(int id) throws ClassNotFoundException, SQLException {
        this.openConnection();
        int is_publish = 0;
        ResultSet RS = null;
        Statement statement = null;
        try {
            statement = (Statement) con.createStatement();
            RS = statement.executeQuery("select is_published from event where event_id='" + id + "'");
            while (RS.next()) {
                is_publish = RS.getInt("is_published");
            }
        } catch (Exception e) {
            out.print(e);
        }

        RS.close();
        statement.close();
        this.closeConnection();
        return is_publish;
    }

    /**
     * @Author Abdelrahman Gamal
     * @param projct_id
     * @param user_id
     * @return count
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public int is_user_project(int projct_id, int user_id) throws ClassNotFoundException, SQLException {
        this.openConnection();
        int count = 0;
        ResultSet RS = null;

        Statement statement = null;
        try {
            statement = (Statement) con.createStatement();
            RS = statement.executeQuery("select  *  from  project where  project_id=" + projct_id + " and user_id=" + user_id + "");
            while (RS.next()) {

                count++;

            }
        } catch (Exception e) {
            out.print(e);
        }
        RS.close();
        statement.close();
        this.closeConnection();
        return count;
    }

    /**
     * @author Abdo Gamal
     * @param projct_id
     * @param user_id
     * @return
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public int is_user_event(int projct_id, int user_id) throws ClassNotFoundException, SQLException {
        this.openConnection();
        int count = 0;
        ResultSet RS = null;

        Statement statement = null;
        try {
            statement = (Statement) con.createStatement();
            RS = statement.executeQuery("select  *  from event inner join project  where project.project_id=event.project_id and event.project_id=" + projct_id + " and project.user_id=" + user_id + "");
            while (RS.next()) {

                count++;

            }
        } catch (Exception e) {
            out.print(e);
        }

        RS.close();
        statement.close();
        this.closeConnection();
        return count;
    }

    /**
     * @author Sabry Ragab
     * @param project_id
     * @return
     * @throws SQLException
     */
    public ArrayList<Event> getPublishedEvents(int project_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ArrayList<Event> events = new ArrayList<>();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        pstmt = con.prepareStatement("select * from event where project_id= '" + project_id + "' and is_published > 0");

        rs = pstmt.executeQuery();
        while (rs.next()) {
            Event event_object = new Event();
            event_object.event_id = rs.getInt(1);
            event_object.is_published = rs.getInt(2);
            event_object.project_id = rs.getInt(3);
            event_object.year = rs.getInt(4);
            event_object.month = rs.getInt(5);
            event_object.day = rs.getInt(6);
            event_object.details = rs.getString(7);
            event_object.map_zoom_level = rs.getInt(8);
            event_object.lat = rs.getDouble(9);
            event_object.lng = rs.getDouble(10);

            Circle circle = new Circle();
            event_object.setCircles(circle.getCircles(rs.getInt(1)));

            Polygon polygon = new Polygon();
            event_object.setPolygons(polygon.getPolygons(rs.getInt(1)));

            Polyline polyline = new Polyline();
            event_object.setPolylines(polyline.getPolylines(rs.getInt(1)));

            Marker marker = new Marker();
            event_object.setMarkers(marker.getMarkers(rs.getInt(1)));

            events.add(event_object);

        }
        this.closeConnection();
        return events;
    }

    /**
     * @author Sabry Ragab
     * @param project_id
     * @return
     * @throws SQLException
     */
    public ArrayList<Event> getAllEvents(int project_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ArrayList<Event> events = new ArrayList<>();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        pstmt = con.prepareStatement("select * from event where project_id= '" + project_id + "'");

        rs = pstmt.executeQuery();
        while (rs.next()) {
            Event event_object = new Event();
            event_object.event_id = rs.getInt(1);
            event_object.is_published = rs.getInt(2);
            event_object.project_id = rs.getInt(3);
            event_object.year = rs.getInt(4);
            event_object.month = rs.getInt(5);
            event_object.day = rs.getInt(6);
            event_object.details = rs.getString(7);
            event_object.map_zoom_level = rs.getInt(8);
            event_object.lat = rs.getDouble(9);
            event_object.lng = rs.getDouble(10);

            Circle circle = new Circle();
            event_object.setCircles(circle.getCircles(rs.getInt(1)));

            Polygon polygon = new Polygon();
            event_object.setPolygons(polygon.getPolygons(rs.getInt(1)));

            Polyline polyline = new Polyline();
            event_object.setPolylines(polyline.getPolylines(rs.getInt(1)));

            Marker marker = new Marker();
            event_object.setMarkers(marker.getMarkers(rs.getInt(1)));

            events.add(event_object);
        }
        this.closeConnection();
        return events;
    }

    public ArrayList<Event> sortEventsAscending(ArrayList<Event> eventList) throws SQLException {
        this.openConnection();
        for (int i = 0; i < eventList.size(); i++) {
            for (int j = i + 1; j < eventList.size(); j++) {
                if (eventList.get(i).getYear() > eventList.get(j).getYear()) {
                    Collections.swap(eventList, i, j);
                } else if (eventList.get(i).getYear() == eventList.get(j).getYear()
                        && eventList.get(i).getMonth() > eventList.get(j).getMonth()) {
                    Collections.swap(eventList, i, j);
                } else if (eventList.get(i).getYear() == eventList.get(j).getYear()
                        && eventList.get(i).getMonth() == eventList.get(j).getMonth()
                        && eventList.get(i).getDay() > eventList.get(j).getDay()) {
                    Collections.swap(eventList, i, j);
                }
            }
        }
        this.closeConnection();
        return eventList;
    }

    public int checkDateEvent(int year, int month, int day, int project_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        int count = 0;
        pstmt = con.prepareStatement("select year,month,day from event where year='" + year + "' and month ='" + month + "' and day ='" + day + "' and project_id='" + project_id + "'");

        rs = pstmt.executeQuery();
        if (rs.next()) {
            count++;
        }
        this.closeConnection();
        return count;
    }
}
