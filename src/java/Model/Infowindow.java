package Model;

import java.sql.SQLException;

public class Infowindow extends DatabaseConnection {

    private int infowindow_id;
    private int marker_id;
    private int event_id;
    private double lat;
    private double lng;
    private String title;
    private String content;

    public Infowindow() throws SQLException {
        super();
    }

    public Infowindow(int infowindow_id, int marker_id, int event_id, double lat, double lng, String title, String content) throws SQLException {
        super();
        this.infowindow_id = infowindow_id;
        this.event_id = event_id;
        this.marker_id = marker_id;
        this.lat = lat;
        this.lng = lng;
        this.title = title;
        this.content = content;
    }

    public int getInfowindow_id() {
        return infowindow_id;
    }

    public void setInfowindow_id(int infowindow_id) {
        this.infowindow_id = infowindow_id;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
