/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

/**
 *
 * @author sabry
 */
public class Search extends DatabaseConnection {

    private int project_id;
    private String tag_name;

    public Search() throws SQLException {
        super();
    }

    public Search(int project_id, String tag_name) throws SQLException {
        super();
        this.project_id = project_id;
        this.tag_name = tag_name;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public String getTag_name() {
        return tag_name;
    }

    public void setTag_name(String tag_name) {
        this.tag_name = tag_name;
    }

    /**
     * Author :abdelrahman Hellawy
     *
     * @param word
     * @param match
     * @return int
     */
    public int getCount(String word, String match) throws SQLException {
        this.openConnection();
        Vector<Integer> counts = new Vector<Integer>();
        int j = -1;
        int flag = 0;
        int count = 0;
        for (int i = 0; i < word.length(); i++) {
            j++;
            if ((j + 1 == match.length() || i + 1 == word.length())) {

                counts.add(count);
                break;
            }
            if (word.charAt(i) == match.charAt(j)) {

                count++;
                flag = 1;
            }

            if (flag == 1 && match.charAt(j + 1) != word.charAt(i + 1)) {

                counts.add(count);
                count = 0;
                flag = 0;
                j = -1;
            }

        }
        for (int c = 0; c < counts.size() - 1; c++) {
            for (int d = 0; d < counts.size() - c - 1; d++) {
                if (counts.get(d) < counts.get(d + 1)) /* For descending order use < */ {
                    int swap = 0;
                    swap = counts.get(d);
                    counts.set(d, counts.get(d + 1));
                    counts.set(d + 1, swap);
                }
            }
        }
        this.closeConnection();
        return counts.get(0);
    }

    /**
     * Author :abdelrahman Hellawy
     *
     * @param project_id
     * @return Vector<Search>
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public Vector<Search> getMatchedSearchValue(String project_id) throws SQLException, ClassNotFoundException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        try {

            pstmt = con.prepareStatement("select * from search where project_id= " + project_id);

            rs = pstmt.executeQuery();
            Vector<Search> Searchvector = new Vector<Search>();
            int i = 0;
            while (rs.next()) {

                Search searchObject = new Search();
                System.out.println("Hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeererhehhhhhhhhhhherehhehhe");

                searchObject.project_id = rs.getInt(1);
                searchObject.tag_name = rs.getString(2);
                Searchvector.add(searchObject);
                System.out.println("name" + Searchvector.get(i).getTag_name());
                i++;
            }
            this.closeConnection();
            return Searchvector;
        } catch (Exception ex) {
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
            }
        }

        this.closeConnection();

        return null;

    }

    public Vector<Search> GetMatchedSearchTags(String searchValue) throws SQLException {
        this.openConnection();
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        OutputStream img;
        String s = null;

        Vector<Search> serchresults = new Vector<Search>();
        try {

            pstmt = con.prepareStatement("select * from search ");

            rs = pstmt.executeQuery();

            int i = 0;
            searchValue = searchValue.toLowerCase();
            while (rs.next()) {

                Search searchObject = new Search();

                String NameDatabase = rs.getString(2).toLowerCase();
                System.out.println("search value Function serch value=" + searchValue + " namedatabase=" + NameDatabase);
                if (NameDatabase.contains(searchValue) || searchValue.contains(NameDatabase)) {

                    searchObject.tag_name = rs.getString(2);
                    searchObject.project_id = rs.getInt(1);

                    serchresults.add(searchObject);
                }

            }
            System.out.println("Fouuuuuuuuuuuuuuuuuuuuuuuund Proooooooooject");
            this.closeConnection();
            return serchresults;
        } catch (Exception ex) {
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
            }
        }

        if (serchresults.size() < 1) {
            Search searchObject = new Search();
            searchObject.setTag_name("empty");
            serchresults.add(searchObject);
        }
        this.closeConnection();
        return serchresults;
    }

}
