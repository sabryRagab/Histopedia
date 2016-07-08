package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    public Connection con;

    public DatabaseConnection() throws SQLException {

    }

    public void openConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnfe) {
            System.err.println("Error loading driver: " + cnfe);
        }

        con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/Histopedia"
                + "?useUnicode=yes&characterEncoding=UTF-8",
                "root", "root");
    }

    public void closeConnection() throws SQLException {
        con.close();
    }
}
