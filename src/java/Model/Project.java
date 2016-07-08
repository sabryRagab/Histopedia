package Model;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Vector;

public class Project extends DatabaseConnection {

    private int project_id;
    private int user_id;
    private String name;
    private String project_desc;
    private int is_published;
    private int likes;
    private int views;
    private String photo;
    private Timestamp creation_date;
    private ArrayList<Event> events;
    private Object insertUser;

    public Project() throws SQLException {
        super();
    }

    public Project(int project_id, int user_id, String name, String project_desc, int is_published, int likes, int views, String photo, Timestamp creation_date, ArrayList<Event> events) throws SQLException {
        super();
        this.project_id = project_id;
        this.user_id = user_id;
        this.name = name;
        this.project_desc = project_desc;
        this.is_published = is_published;
        this.likes = likes;
        this.views = views;
        this.photo = photo;
        this.creation_date = creation_date;
        this.events = events;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProject_desc() {
        return project_desc;
    }

    public void setProject_desc(String project_desc) {
        this.project_desc = project_desc;
    }

    public int getIs_published() {
        return is_published;
    }

    public void setIs_published(int is_published) {
        this.is_published = is_published;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Timestamp getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Timestamp creation_date) {
        this.creation_date = creation_date;
    }

    public ArrayList<Event> getEvents() {
        return events;
    }

    public void setEvents(ArrayList<Event> events) {
        this.events = events;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    /**
     * Author :Abdelrahman Hellawy
     *
     * @param user_id
     * @return Vector<Project>
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws SQLException
     */
    public Vector<Project> getProject(int user_id) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;
        String id;
        id = Integer.toString(user_id);
        System.out.println("User Id Get Project Function: " + user_id);
        try {

            pstmt = con.prepareStatement("select * from project where user_id=" + id);

            rs = pstmt.executeQuery();
            Vector<Project> projects = new Vector<Project>();
            int i = 0;
            while (rs.next()) {
                Project projectObject = new Project();
                System.out.println("Hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeererhehhhhhhhhhhherehhehhe");
                projectObject.project_id = rs.getInt(1);
                projectObject.name = rs.getString(2);
                projectObject.project_desc = rs.getString(3);
                projectObject.creation_date = rs.getTimestamp(6);
                projectObject.views = rs.getInt(7);
                projectObject.likes = rs.getInt(8);
                byte barray[] = rs.getBytes(9);
                String base64 = "data:image/jpg;base64,";
                base64 = base64 + Base64.getEncoder().encodeToString(barray);
                projectObject.photo = base64;
                projects.add(projectObject);
                System.out.println("name" + projects.get(i).getName());
                i++;

            }
            this.closeConnection();
            return projects;
        } catch (Exception ex) {
        }
        this.closeConnection();
        return null;

    }

    /**
     * Author :Abdelrahman Hellawy
     *
     * @return Vector<Project>
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws SQLException
     */
    public Vector<Project> getTop50Project() throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        try {

            pstmt = con.prepareStatement("select * from project");

            rs = pstmt.executeQuery();
            Vector<Project> projects = new Vector<Project>();
            int i = 0;
            while (rs.next()) {
                if (rs.getInt(4) == 1) {
                    Project projectObject = new Project();
                    System.out.println("Hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeererhehhhhhhhhhhherehhehhe");
                    projectObject.project_id = rs.getInt(1);
                    projectObject.name = rs.getString(2);
                    projectObject.project_desc = rs.getString(3);
                    projectObject.is_published = rs.getInt(4);
                    projectObject.user_id = rs.getInt(5);
                    projectObject.creation_date = rs.getTimestamp(6);
                    projectObject.views = rs.getInt(7);
                    projectObject.likes = rs.getInt(8);
                    byte barray[] = rs.getBytes(9);
                    String base64 = "data:image/jpg;base64,";
                    base64 = base64 + Base64.getEncoder().encodeToString(barray);
                    projectObject.photo = base64;
                    projects.add(projectObject);
                    System.out.println("name" + projects.get(i).getName());
                    i++;
                }

            }
            this.closeConnection();
            return projects;
        } catch (Exception ex) {
        }
        this.closeConnection();
        return null;

    }

    /**
     * Author :Abdelrahman Hellawy
     *
     * @param searchValue
     * @return Vector<Project>
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public Vector<Project> GetMatchedSearchProject(String searchValue) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        Vector<Project> projects = new Vector<Project>();
        try {

            pstmt = con.prepareStatement("select * from project ");

            rs = pstmt.executeQuery();

            int i = 0;
            searchValue = searchValue.toLowerCase();
            while (rs.next()) {

                Project projectObject = new Project();
                System.out.println("Prooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooject");
                String NameDatabase = rs.getString(2).toLowerCase();
                if (NameDatabase.contains(searchValue) || searchValue.contains(NameDatabase)) {
                    System.out.println("Here");
                    if (rs.getInt(4) == 1) {
                        projectObject.project_id = rs.getInt(1);
                        projectObject.name = rs.getString(2);
                        projectObject.project_desc = rs.getString(3);
                        projectObject.is_published = rs.getInt(4);
                        projectObject.user_id = rs.getInt(5);
                        projectObject.creation_date = rs.getTimestamp(6);
                        projectObject.views = rs.getInt(7);
                        projectObject.likes = rs.getInt(8);
                        byte barray[] = rs.getBytes(9);
                        String base64 = "data:image/jpg;base64,";
                        base64 = base64 + Base64.getEncoder().encodeToString(barray);
                        projectObject.photo = base64;
                        projects.add(projectObject);
                    }
                }
                System.out.println("nameDatabase" + projects.get(i).getName());
                i++;

            }
            this.closeConnection();
            return projects;
        } catch (Exception ex) {
        }

        if (projects.size() < 1) {
            Project projectObject = new Project();
            projectObject.setName("empty");
            projects.add(projectObject);
        }
        this.closeConnection();
        return projects;

    }

    /**
     * @Author Ahmed said
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public void deleteProject() throws ClassNotFoundException, SQLException {
        this.openConnection();
        String parmQuery;
        PreparedStatement preStm;
        parmQuery = "  DELETE FROM project WHERE project_id = ? ";
        preStm = con.prepareStatement(parmQuery);
        preStm.setInt(1, this.project_id);
        preStm.executeUpdate();
        preStm.close();
        this.closeConnection();
    }

    /**
     * @author Ahmed Said
     * @return user id of current project
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public int getOwnerID() throws SQLException, ClassNotFoundException {
        this.openConnection();
        int id = 0;
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT  user_id  FROM project where project_id = '" + this.project_id + "'");
        while (rs.next()) {
            id = rs.getInt("user_id");
        }
        rs.close();
        this.closeConnection();
        return id;

    }

    /**
     * Add project to database and set project id
     *
     * @author Ahmed said
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void addProject() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        this.openConnection();
        String query = "INSERT INTO project (name , project_desc , is_published ,user_id , creation_date , views , likes, photo) VALUES( ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement preStmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        preStmt.setString(1, this.name);
        preStmt.setString(2, this.project_desc);
        preStmt.setInt(3, this.is_published);
        preStmt.setInt(4, this.user_id);
        preStmt.setTimestamp(5, this.creation_date);
        preStmt.setInt(6, this.views);
        preStmt.setInt(7, this.likes);
        byte barray[] = this.getProjectDefaultImage(2);
        InputStream is = new ByteArrayInputStream(barray);
        preStmt.setBlob(8, is);
        preStmt.executeUpdate();
        ResultSet keys = preStmt.getGeneratedKeys();
        keys.next();
        this.project_id = keys.getInt(1);
        this.closeConnection();
    }

    /**
     * @author Ahmed Said
     * @return last project id in database
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public int getLastProjectId() throws SQLException, ClassNotFoundException {
        this.openConnection();
        int id = 0;
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT  project_id  FROM project ");
        while (rs.next()) {
            id = rs.getInt("project_id");
        }
        rs.close();
        this.closeConnection();
        return id;
    }

    /**
     * @description update project data in database
     * @author Ahmed Said
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void updateProject() throws SQLException, ClassNotFoundException {
        this.openConnection();
        String query = "UPDATE project SET name = ? , project_desc = ? , is_published = ?  "
                + "    WHERE project_id = ? ";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, this.name);
        ps.setString(2, this.project_desc);
        ps.setInt(3, this.is_published);
        ps.setInt(4, this.project_id);

        // execute insert SQL stetement
        ps.executeUpdate();
        ps.close();
        this.closeConnection();
    }

    /**
     * @description this function get project data from data base then set them
     * in object
     * @author Ahmed Said & Sabry Ragab
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void setProjectDataUsingId() throws SQLException, ClassNotFoundException {
        this.openConnection();
        Statement stmt = con.createStatement();
        ResultSet rs;

        rs = stmt.executeQuery("SELECT * FROM project WHERE project_id = '" + this.project_id + "'");
        while (rs.next()) {
            this.name = rs.getString("name");
            this.project_desc = rs.getString("project_desc");
            this.is_published = rs.getInt("is_published");
            this.user_id = rs.getInt("user_id");
            this.creation_date = rs.getTimestamp("creation_date");
            this.views = rs.getInt("views");
            this.likes = rs.getInt("likes");
            byte barray[] = rs.getBytes("photo");
            String base64 = "data:image/jpg;base64,";
            base64 = base64 + Base64.getEncoder().encodeToString(barray);
            this.photo = base64;
        }

        rs.close();
        this.closeConnection();
    }

    /**
     * @description Add new tags to database
     * @author Ahmed Said
     * @param project_id
     * @param tags
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public void addTag(int project_id, String tags) throws SQLException, ClassNotFoundException {
        this.openConnection();
        PreparedStatement preStmt = null;
        String query = "insert into search ( project_id , tag_name) values ( ?, ?)";
        preStmt = con.prepareStatement(query);
        preStmt.setInt(1, project_id);
        preStmt.setString(2, tags);
        preStmt.execute();
        preStmt.close();
        this.closeConnection();
    }

    /**
     * @description check if tag is exist in database or not
     * @author Ahmed Said
     * @param project_id
     * @param tag
     * @return true if exist or not otherwise
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public boolean isExist(int project_id, String tag) throws SQLException, ClassNotFoundException {
        this.openConnection();
        Statement stmt = con.createStatement();
        ResultSet rs;
        rs = stmt.executeQuery("SELECT tag_name FROM search WHERE project_id = '" + project_id + "'");
        while (rs.next()) {
            String res = rs.getString("tag_name");
            if (tag.equals(res)) {
                this.closeConnection();
                return true;
            }   //exist
        }
        rs.close();
        this.closeConnection();
        return false;  // not exist
    }

    /**
     * @Description Get all tags by project id
     * @author Ahmed Said
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public String getProjectTags() throws SQLException, ClassNotFoundException {
        this.openConnection();
        String allTags = "";
        Statement stmt = con.createStatement();
        ResultSet rs;

        rs = stmt.executeQuery("SELECT tag_name FROM search WHERE project_id = '" + this.project_id + "'");
        while (rs.next()) {
            if (!(rs.getString("tag_name").equals(""))) {
                allTags += (rs.getString("tag_name") + " ");
            }
        }

        rs.close();
        this.closeConnection();
        return allTags;
    }

    public byte[] getProjectDefaultImage(int id) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
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

    /**
     * @hellawy & Sabry
     * @param stream
     * @param id
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public void saveImage(InputStream stream, int id) throws ClassNotFoundException, SQLException {
        this.openConnection();
        ResultSet rs = null;

        String message = null;  // message will be sent back to client
        try {

            // constructs SQL statement
            String sql = "INSERT INTO testtb (id, img) values (?, ?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, id);
            if (stream != null) {

                System.out.println("Herrrrrrrrrrrrrrrrrrrrrrrr");
                statement.setBlob(2, stream);
            }
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
        } catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        }
        this.closeConnection();
    }

    /**
     * @Hellawy @param is
     * @throws SQLException
     */
    public void SaveProjectImage(InputStream is) throws SQLException {
        this.openConnection();
        String query = "UPDATE project SET photo = ?  "
                + "    WHERE project_id = ? ";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setBlob(1, is);
        ps.setInt(2, this.project_id);
        // execute insert SQL stetement
        ps.executeUpdate();
        ps.close();
        this.closeConnection();
    }

    /**
     * @author Sabry Ragab Darwish
     * @return
     * @throws SQLException
     */
    public boolean isPublishedAndExist() throws SQLException {
        this.openConnection();
        boolean isFound = false;

        Statement stmt = con.createStatement();
        ResultSet rs;
        rs = stmt.executeQuery("SELECT * FROM project WHERE project_id = '" + this.project_id + "'  and is_published > 0");
        while (rs.next()) {
            isFound = true;
            break;
        }
        rs.close();
        this.closeConnection();
        return isFound;  // not exist
    }

    public Project getProjectByProjectId(int project_id) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;
        String id;
        id = Integer.toString(user_id);
        System.out.println("User Id Get Project Function: " + user_id);
        try {

            pstmt = con.prepareStatement("select * from project where project_id=" + project_id);

            rs = pstmt.executeQuery();
            int i = 0;

            if (rs.next()) {
                if (rs.getInt(4) == 1) {
                    System.out.println("Hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeererhehhhhhhhhhhherehhehhe");
                    this.project_id = rs.getInt(1);
                    this.name = rs.getString(2);
                    this.project_desc = rs.getString(3);
                    this.is_published = rs.getInt(4);
                    this.user_id = rs.getInt(5);
                    this.creation_date = rs.getTimestamp(6);
                    this.views = rs.getInt(7);
                    this.likes = rs.getInt(8);
                    byte barray[] = rs.getBytes(9);
                    String base64 = "data:image/jpg;base64,";
                    base64 = base64 + Base64.getEncoder().encodeToString(barray);
                    this.photo = base64;
                }
            }
            this.closeConnection();
            return this;
        } catch (Exception ex) {
        }
        this.closeConnection();
        return this;

    }
    
    public void updateViews() throws SQLException, ClassNotFoundException {
        this.openConnection();
        String query = "UPDATE project SET views = ?  "
                + "    WHERE project_id = ? ";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, this.views);
        ps.setInt(2, this.project_id);
        // execute insert SQL stetement
        ps.executeUpdate();
        ps.close();
        this.closeConnection();
    }

}
