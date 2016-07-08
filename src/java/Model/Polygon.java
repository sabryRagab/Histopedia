package Model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javafx.scene.text.Text;

public class Polygon extends Shape {

    private int polygon_id;
    private int event_id;
    private double fillOpacity;
    private String fillColor;
    private String coordinates;

    public Polygon() throws SQLException {
        super();
    }

    public Polygon(int polygon_id, int event_id, String strokeColor, double strokeOpacity,
            double strokeWeight, double fillOpacity, String fillColor,
            String coordinates) throws SQLException {
        super(strokeColor, strokeOpacity, strokeWeight);
        this.polygon_id = polygon_id;
        this.event_id = event_id;
        this.fillOpacity = fillOpacity;
        this.fillColor = fillColor;
        this.coordinates = coordinates;
    }

    public int getPolygon_id() {
        return polygon_id;
    }

    public void setPolygon_id(int polygon_id) {
        this.polygon_id = polygon_id;
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
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

    public String getCoordinates() {
        return coordinates;
    }

    public void setCoordinates(String coordinates) {
        this.coordinates = coordinates;
    }

    /**
     * @author Ahmed Said & Sabry Ragab
     * @param e_id
     * @param polygonType
     * @param strokeColor
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void insertPolygonInDB(int e_id, String polygonType, String strokeColor,
            String strokeOpacity, String strokeWeight, String fillColor,
            String fillOpacity, String coordinates) throws SQLException, ClassNotFoundException {
        this.openConnection();
        String query = "insert into polygon ( event_id , polygon_type ,strokeColor , strokeOpacity , "
                + "strokeWeight ,fillColor ,fillOpacity, coordinates)"
                + " values (?,?,?,?,?,?,?,?) ";

        PreparedStatement preStmt = null;
        preStmt = con.prepareStatement(query);
        preStmt.setInt(1, e_id);
        preStmt.setString(2, polygonType);
        preStmt.setString(3, strokeColor);
        preStmt.setDouble(4, Double.parseDouble(strokeOpacity));
        preStmt.setDouble(5, Double.parseDouble(strokeWeight));
        preStmt.setString(6, fillColor);
        preStmt.setDouble(7, Double.parseDouble(fillOpacity));
        preStmt.setString(8, coordinates);

        preStmt.execute();
        preStmt.close();
        this.closeConnection();
    }

    /**
     * @author Ahmed Said & Osama
     * @param event_id
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public ArrayList<Polygon> getPolygons(int id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ArrayList<Polygon> polygons = new ArrayList<>();
        Statement stmt = con.createStatement();
        ResultSet rs;

        rs = stmt.executeQuery("SELECT * FROM polygon WHERE event_id = '" + id + "'  and polygon_type = 'polygon' ");
        while (rs.next()) {

            Polygon p = new Polygon(rs.getInt(1), rs.getInt(2), rs.getString(4), rs.getDouble(5), rs.getDouble(6),
                    rs.getDouble(8), rs.getString(7), rs.getString(9));
            polygons.add(p);

        }
        this.closeConnection();
        return polygons;
    }
}
