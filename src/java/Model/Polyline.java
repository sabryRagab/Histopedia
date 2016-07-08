package Model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Polyline extends Shape {

    private int polyline_id;
    private int event_id;
    private String coordinates;

    public Polyline() throws SQLException {
        super();
    }

    public Polyline(int polyline_id, int event_id,
            String strokeColor, double strokeOpacity, double strokeWeight, String coordinates) throws SQLException {
        super(strokeColor, strokeOpacity, strokeWeight);
        this.polyline_id = polyline_id;
        this.event_id = event_id;
        this.coordinates = coordinates;
    }

    public int getPolyline_id() {
        return polyline_id;
    }

    public void setPolyline_id(int polyline_id) {
        this.polyline_id = polyline_id;
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    public String getCoordinates() {
        return coordinates;
    }

    public void setCoordinates(String coordinates) {
        this.coordinates = coordinates;
    }

    /**
     * @author Ahmed Said & Sabry
     * @param e_id
     * @param polygonType
     * @param strokeColor
     * @param strokeOpacity
     * @param strokeWeight
     * @param fillColor
     * @param fillOpacity
     * @param coordinates
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void insertPolylineInDB(int e_id, String polygonType, String strokeColor,
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
        if (fillColor.endsWith("undefined")) {
            preStmt.setString(6, null);
        } else {
            preStmt.setString(6, fillColor);
        }
        if (fillOpacity.endsWith("undefined")) {
            preStmt.setString(7, null);
        } else {
            preStmt.setString(7, fillOpacity);
        }
        preStmt.setString(8, coordinates);
        preStmt.execute();
        this.closeConnection();

    }

    /**
     * @author Ahmed Said & Sabry
     * @param event_id
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public ArrayList<Polyline> getPolylines(int event_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ArrayList<Polyline> polylines = new ArrayList<>();

        Statement stmt = con.createStatement();
        ResultSet rs;

        rs = stmt.executeQuery("SELECT * FROM polygon WHERE event_id  = '" + event_id + "'  and polygon_type = 'polyline' ");
        while (rs.next()) {
            Polyline p = new Polyline(rs.getInt(1), rs.getInt(2), rs.getString(4), rs.getDouble(5),
                    rs.getDouble(6), rs.getString(9));

            polylines.add(p);
        }
        this.closeConnection();
        return polylines;
    }
}
