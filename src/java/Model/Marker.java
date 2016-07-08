package Model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Marker extends DatabaseConnection {

    private int marker_id;
    private int event_id;
    private double lat;
    private double lng;
    private String title;
    private String icon;
    private Infowindow infowindow;

    public Marker() throws SQLException {
        super();
    }

    public Marker(int marker_id, int event_id, double lat, double lng, String title, String icon, Infowindow infowindow) throws SQLException {
        super();
        this.marker_id = marker_id;
        this.event_id = event_id;
        this.lat = lat;
        this.lng = lng;
        this.title = title;
        this.icon = icon;
        this.infowindow = infowindow;
    }

    public int getMarker_id() {
        return marker_id;
    }

    public void setMarker_id(int marker_id) {
        this.marker_id = marker_id;
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Infowindow getInfowindow() {
        return infowindow;
    }

    public void setInfowindow(Infowindow infowindow) {
        this.infowindow = infowindow;
    }

    /**
     * @author Sabry Ragab
     * @param event_id
     * @throws SQLException
     */
    public void insertSimpleMarker() throws SQLException {
this.openConnection();
        String query = "INSERT INTO marker (event_id, lat, lng, title) VALUES(?,?,?,?)";
        PreparedStatement prepStmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        prepStmt.setInt(1, this.event_id);
        prepStmt.setDouble(2, this.lat);
        prepStmt.setDouble(3, this.lng);
        prepStmt.setString(4, this.title);
        prepStmt.executeUpdate();
        ResultSet keys = prepStmt.getGeneratedKeys();
        keys.next();
        this.marker_id = keys.getInt(1);
        this.closeConnection();
    }

    /**
     * @author Ahmed Said & Sabry Ragab
     * @param event_id
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException 
     */
    public  ArrayList<Marker> getMarkers(int id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        System.out.println("Event id = " + id + " in getMarkers function");
        ArrayList<Marker> markers = new ArrayList<>();
        Statement stmt = con.createStatement();
        ResultSet rs;
        rs = stmt.executeQuery("SELECT * FROM marker WHERE event_id = '" + id + "'");
        while (rs.next()) {
            Marker c = new Marker(rs.getInt(1), rs.getInt(2), rs.getDouble(3), rs.getDouble(4),
                    rs.getString(5), rs.getString(6), new Infowindow());
            markers.add(c);
        }
        this.closeConnection();
        return markers;
    }

}
