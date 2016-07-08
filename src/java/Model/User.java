package Model;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import static java.lang.System.out;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Vector;

public class User extends DatabaseConnection {

    private int user_id;
    private String email;
    private String name;
    private String password;
    private String country;
    private String city;
    private String user_desc;
    private String gender;
    private String photo;
    private String rkey;
    private int activate;
    private ArrayList<Project> projects;

    public User() throws SQLException {
        super();
    }

    public User(int user_id, String email, String name, String password, String country, String city, String user_desc, String gender, String photo, String rkey, int activate, ArrayList<Project> projects) throws SQLException {
        super();
        this.user_id = user_id;
        this.email = email;
        this.name = name;
        this.password = password;
        this.country = country;
        this.city = city;
        this.user_desc = user_desc;
        this.gender = gender;
        this.photo = photo;
        this.rkey = rkey;
        this.activate = activate;
        this.projects = projects;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getUser_desc() {
        return user_desc;
    }

    public void setUser_desc(String user_desc) {
        this.user_desc = user_desc;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getRkey() {
        return rkey;
    }

    public void setRkey(String rkey) {
        this.rkey = rkey;
    }

    public int getActivate() {
        return activate;
    }

    public void setActivate(int activate) {
        this.activate = activate;
    }

    public ArrayList<Project> getProjects() {
        return projects;
    }

    public void setProjects(ArrayList<Project> projects) {
        this.projects = projects;
    }

    public boolean isExist() throws SQLException {
        this.openConnection();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT email,password FROM User;");

        while (resultSet.next()) {
            if ((email.equals(resultSet.getString("email")))
                    && (password.equals(resultSet.getString("password")))) {
                resultSet.close(); //release resources
                stmt.close(); //release resourcesF
                this.closeConnection();
                return true;
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources
        this.closeConnection();
        return false;
    }

    public boolean isEmailExist() throws SQLException {
        this.openConnection();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT email FROM User;");

        while (resultSet.next()) {
            if (email.equals(resultSet.getString("email"))) {
                resultSet.close(); //release resources
                stmt.close(); //release resourcesF
                return true;
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources
        this.closeConnection();
        return false;
    }

    public boolean addInDB() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        this.openConnection();
        this.user_id = this.getLastId() + 1;
         this.openConnection();
        String paramQuery = "Insert into user (user_id,email,name,password,rkey,activate, photo)"
                + " Values (?,?,?,?,?,?,?)";
        PreparedStatement insertUser = con.prepareStatement(paramQuery);
        insertUser.setInt(1, this.user_id);
        insertUser.setString(2, this.email);
        insertUser.setString(3, this.name);
        insertUser.setString(4, this.password);
        insertUser.setString(5, this.rkey);
        insertUser.setInt(6, this.activate);
        byte barray[] = this.getUserDefaultImage(1);
        InputStream is = new ByteArrayInputStream(barray);
        insertUser.setBlob(7, is);
        int rowCount = insertUser.executeUpdate();
        if (rowCount > 0) {
            insertUser.close();
            this.closeConnection();
            return true;
        }
        insertUser.close();
        this.closeConnection();
        return false;
    }

    public boolean updateuser() throws SQLException {
        this.openConnection();
        String paramQuery = "update user set name='" + name + "'" + ", password='" + password + "', country='" + country + "',"
                + "city='" + city + "',user_desc='" + user_desc + "', gender='" + gender
                + "', email='" + email + "' where user_id=" + this.user_id + ";";
        Statement stmt;
        stmt = con.createStatement();
        int rowCount = stmt.executeUpdate(paramQuery);

        if (rowCount > 0) {
            stmt.close();
            this.closeConnection();
            return true;
        }
        stmt.close();
        this.closeConnection();
        return false;

    }

    public int getLastId() throws SQLException {
        this.openConnection();
        int i = 0;
        try (
                Statement stmt = con.createStatement();
                ResultSet resultSet = stmt.executeQuery("SELECT user_id FROM User;")) {
            while (resultSet.next()) {
                i = resultSet.getInt("user_id");
            }
            stmt.close();
            resultSet.close();
        }
        this.closeConnection();
        return i;
    }

    public int getIdByEmail() throws SQLException {
        this.openConnection();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT user_id FROM user where email='" + email + "';");
        int i = 0;
        while (resultSet.next()) {
            i = resultSet.getInt("user_id");
        }
        stmt.close();
        resultSet.close();
        this.closeConnection();
        return i;
    }

    public boolean addKeyInDB(String email, String key) throws SQLException {
        this.openConnection();
        String paramQuery = "update user set rkey='" + key + "'" + "where email='" + email + "'";
        Statement stmt;
        stmt = con.createStatement();
        int rowCount = stmt.executeUpdate(paramQuery);

        if (rowCount > 0) {
            stmt.close();
            this.closeConnection();
            return true;
        }
        stmt.close();
        this.closeConnection();
        return false;
    }

    public boolean checkValidationKey(String email, String key) throws SQLException {
        this.openConnection();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT email,rkey FROM User");

        while (resultSet.next()) {
            if ((email.equals(resultSet.getString("email")))
                    && (key.equals(resultSet.getString("rkey")))) {
                resultSet.close(); //release resources
                stmt.close(); //release resourcesF
                this.closeConnection();
                return true;
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources
        this.closeConnection();
        return false;
    }

    public boolean resetPassword(String email, String password) throws SQLException {
        this.openConnection();
        String paramQuery = "update user set password='" + password + "'" + "where email='" + email + "'";
        Statement stmt;
        stmt = con.createStatement();
        int rowCount = stmt.executeUpdate(paramQuery);

        if (rowCount > 0) {
            stmt.close();
            this.closeConnection();
            return true;
        }
        stmt.close();
        this.closeConnection();
        return false;
    }

    public boolean activateUser(String email, String key) throws SQLException {
        this.openConnection();
        String paramQuery = "update user set activate=1 where "
                + "email='" + email + "'and rkey='" + key + "'and activate=0";
        Statement stmt;
        stmt = con.createStatement();
        int rowCount = stmt.executeUpdate(paramQuery);

        if (rowCount > 0) {
            stmt.close();
            this.closeConnection();
            return true;
        }
        stmt.close();
        this.closeConnection();
        return false;
    }

    public void updateuserphoto(InputStream is) throws SQLException {
        this.openConnection();
        String query = "UPDATE user SET photo = ?  "
                + "    WHERE user_id = ? ";

        System.out.println("updaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaate Function");
        PreparedStatement ps = con.prepareStatement(query);
        ps.setBlob(1, is);
        ps.setInt(2, this.user_id);
        // execute insert SQL stetement
        ps.executeUpdate();
        ps.close();
        this.closeConnection();
    }

    public void getUserInformation() throws SQLException {
        this.openConnection();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM User where "
                + "user_id=" + this.user_id + ";");
        while (resultSet.next()) {
            this.setEmail(resultSet.getString("email"));
            this.setName(resultSet.getString("name"));
            this.setPassword(resultSet.getString("password"));
            this.setCountry(resultSet.getString("country"));
            this.setCity(resultSet.getString("city"));
            this.setGender(resultSet.getString("gender"));
            this.setUser_desc(resultSet.getString("user_desc"));
            byte barray[] = resultSet.getBytes(9);
            String base64 = "data:image/jpg;base64,";
            base64 = base64 + Base64.getEncoder().encodeToString(barray);
            this.photo = base64;
        }
        stmt.close();
        resultSet.close();
        this.closeConnection();
    }

    /**
     * Author Abdelrahman Hellawy
     *
     * @param user_id
     * @return User
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public User GetUserByUserId(String user_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        pstmt = con.prepareStatement("select * from user where user_id=" + user_id);

        rs = pstmt.executeQuery();

        int i = 0;
        User userobject = new User();
        if (rs.next()) {

            System.out.println("Hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeererhehhhhhhhhhhherehhehhe");
            userobject.user_id = rs.getInt(1);
            userobject.email = rs.getString(2);
            userobject.name = rs.getString(3);
            userobject.country = rs.getString(5);
            userobject.city = rs.getString(6);
            userobject.user_desc = rs.getString(7);
            userobject.gender = rs.getString(8);
            byte barray[] = rs.getBytes(9);
            String base64 = "data:image/jpg;base64,";
            base64 = base64 + Base64.getEncoder().encodeToString(barray);
            userobject.photo = base64;

        }
        this.closeConnection();
        return userobject;
    }

    /**
     * Author Abdelrahman Hellawy
     *
     * @param user_id
     * @return int
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public int check_user_id(String user_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        pstmt = con.prepareStatement("SELECT user_id FROM user ORDER BY user_id DESC LIMIT 1");
        rs = pstmt.executeQuery();

        int i = 0;
        int id = Integer.parseInt(user_id);
        if (rs.next()) {

            System.out.println("Hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeererhehhhhhhhhhhherehhehhe");
            int Databaseuser_id = rs.getInt(1);
            if (id > Databaseuser_id) {
                this.closeConnection();
                return -1;
            }
            if (id <= Databaseuser_id) {
                this.closeConnection();
                return 1;
            }

        }

        return -1;

    }

    /**
     * Author Abdelrahman Hellawy
     *
     * @param searchValue
     * @return Vector<User>
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public Vector<User> getMatchedSearchUser(String searchValue) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        pstmt = con.prepareStatement("select * from user ");

        rs = pstmt.executeQuery();

        int i = 0;
        Vector<User> users = new Vector<User>();
        searchValue = searchValue.toLowerCase();
        while (rs.next()) {
            User userobject = new User();
            String NameDatabase = rs.getString(3).toLowerCase();
            if (NameDatabase.contains(searchValue) || searchValue.contains(NameDatabase)) {
                userobject.user_id = rs.getInt(1);
                userobject.email = rs.getString(2);
                userobject.name = rs.getString(3);
                userobject.country = rs.getString(5);
                userobject.city = rs.getString(6);
                userobject.user_desc = rs.getString(7);
                userobject.gender = rs.getString(8);
                byte barray[] = rs.getBytes(9);
                String base64 = "data:image/jpg;base64,";
                base64 = base64 + Base64.getEncoder().encodeToString(barray);
                userobject.photo = base64;
                users.add(userobject);
            }
        }
        this.closeConnection();
        return users;
    }

    /**
     * @authot Hellawy
     * @param id
     * @return
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws SQLException
     */
    public byte[] getUserDefaultImage(int id) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;
        String idd;
        idd = Integer.toString(id);
        pstmt = con.prepareStatement("select * from testtb where id=" + idd);
        rs = pstmt.executeQuery();
        byte barray[] = null;
        if (rs.next()) {
            barray = rs.getBytes(2);
        }
        this.closeConnection();
        return barray;

    }
}
