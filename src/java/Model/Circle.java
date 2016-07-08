package Model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Circle extends Shape {

    private int circle_id;
    private int event_id;
    private double lat;
    private double lng;
    private double radius;
    private double fillOpacity;
    private String fillColor;

    public Circle() throws SQLException {
        super();
    }

    public Circle(int circle_id, int event_id, String strokeColor, double strokeOpacity,
            double strokeWeight, double lat, double lng, double radius,
            double fillOpacity, String fillColor) throws SQLException {
        super(strokeColor, strokeOpacity, strokeWeight);
        this.event_id = event_id;
        this.circle_id = circle_id;
        this.lat = lat;
        this.lng = lng;
        this.radius = radius;
        this.fillOpacity = fillOpacity;
        this.fillColor = fillColor;
    }

    public Circle(String strokeColor, double strokeOpacity, double strokeWeight) throws SQLException {
        super(strokeColor, strokeOpacity, strokeWeight);
        // TODO Auto-generated constructor stub
    }

    public int getCircle_id() {
        return circle_id;
    }

    public void setCircle_id(int circle_id) {
        this.circle_id = circle_id;
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

    public double getRadius() {
        return radius;
    }

    public void setRadius(double radius) {
        this.radius = radius;
    }

    public double getFillOpacity() {
        return fillOpacity;
    }

    public void setFillOpacity(double fillOpacity) {
        this.fillOpacity = fillOpacity;
    }

    public String getFillColor() {
        return fillColor;
    }

    public void setFillColor(String fillColor) {
        this.fillColor = fillColor;
    }

    /**
     * @author Ahmed Said & Sabry Ragab
     * @param e_id
     * @param lat
     * @param lan
     * @param radious
     * @param strokeColor
     * @param strokeOpacity
     * @param strokeWeight
     * @param fillColor
     * @param fillOpacity
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void insertCircleInDB(int e_id, String lat, String lan, String radious, String strokeColor, String strokeOpacity, String strokeWeight, String fillColor, String fillOpacity) throws SQLException, ClassNotFoundException {

        this.openConnection();
        
        String query = "insert into circle ( event_id , lat , lng, radius , strokeColor , strokeOpacity , "
                + "strokeWeight ,fillColor ,fillOpacity  )"
                + " values (?,?,?,?,?,?,?,?,?) ";

        PreparedStatement preStmt = null;
        preStmt = con.prepareStatement(query);
        preStmt.setInt(1, e_id);
        preStmt.setDouble(2, Double.parseDouble(lat));
        preStmt.setDouble(3, Double.parseDouble(lan));
        preStmt.setDouble(4, Double.parseDouble(radious));
        preStmt.setString(5, strokeColor);
        preStmt.setDouble(6, Double.parseDouble(strokeOpacity));
        preStmt.setDouble(7, Double.parseDouble(strokeWeight));
        preStmt.setString(8, fillColor);
        preStmt.setDouble(9, Double.parseDouble(fillOpacity));
        preStmt.execute();
        preStmt.close();
        this.closeConnection();
    }

    /**
     * @zuthor Ahmed Said & Sabry Ragab
     * @param event_id
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException 
     */
    public ArrayList<Circle> getCircles(int event_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ArrayList<Circle> circles = new ArrayList<>();

        Statement stmt = con.createStatement();
        ResultSet rs;
        rs = stmt.executeQuery("SELECT * FROM circle WHERE event_id = '" + event_id + "'");
        while (rs.next()) {
            Circle c = new Circle(rs.getInt(1), rs.getInt(2), rs.getString(6), rs.getDouble(7), rs.getDouble(8), rs.getDouble(3),  rs.getDouble(4),
                    rs.getDouble(5),  rs.getDouble(10), rs.getString(9));
            circles.add(c);
        }
        this.closeConnection();
        return circles;
    }

}
