package Model;
import java.sql.SQLException;


public  class Shape extends DatabaseConnection{
	protected String strokeColor;
	protected double strokeOpacity;
	protected double strokeWeight;
	
        public Shape() throws SQLException{
            super();
        }
        
	public Shape(String strokeColor, double strokeOpacity, double strokeWeight) throws SQLException {
		super();
		this.strokeColor = strokeColor;
		this.strokeOpacity = strokeOpacity;
		this.strokeWeight = strokeWeight;
	}

	public String getStrokeColor() {
		return strokeColor;
	}

	public void setStrokeColor(String strokeColor) {
		this.strokeColor = strokeColor;
	}

	public double getStrokeOpacity() {
		return strokeOpacity;
	}

	public void setStrokeOpacity(double strokeOpacity) {
		this.strokeOpacity = strokeOpacity;
	}

	public double getStrokeWeight() {
		return strokeWeight;
	}

	public void setStrokeWeight(double strokeWeight) {
		this.strokeWeight = strokeWeight;
	}
	
	
	
	
	
}
