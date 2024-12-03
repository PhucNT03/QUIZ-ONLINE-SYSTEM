package dao.impl;

import bean.Slider;
import dao.DBConnection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import dao.SliderDAO;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 * The class has methods needed for initialize connection with database and
 * execute queries with Slider and associate tables
 *
 */
public class SliderDAOImpl extends DBConnection implements SliderDAO {

    /**
     * get all slider in database
     *
     * @return <code>ArrayList<Slider><code> object
     * @throws java.lang.Exception
     */
    @Override
    public ArrayList<Slider> getSlider() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        ArrayList<Slider> allSlider = new ArrayList();
        String sql = "SELECT * FROM [Slider]";
        /* Get the slider */
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int sliderId = rs.getInt("sliderId");
                String sliderTitle = rs.getString("sliderTitle");
                String image = rs.getString("image");
                String link = rs.getString("link");
                String note = rs.getString("note");
                allSlider.add(new Slider(sliderId, sliderTitle, image, link, note, true));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return allSlider;

    }

}
