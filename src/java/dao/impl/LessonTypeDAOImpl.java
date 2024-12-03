package dao.impl;

import bean.LessonType;
import dao.DBConnection;
import dao.LessonTypeDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * The class has methods needed for initialize connection with database and
 * execute queries with LessonType and associate tables
 *
 */
public class LessonTypeDAOImpl extends DBConnection implements LessonTypeDAO {

    @Override
     public ArrayList<LessonType> getAllLessonType() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<LessonType> lessonTypesList = new ArrayList<>();
        String sql = "SELECT [lessonTypeId]\n"
                + "      ,[lessonTypeName]\n"
                + "      ,[status]\n"
                + "  FROM [QuizSystem].[dbo].[LessonType]\n"
                + "  WHERE status = 1 ";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                lessonTypesList.add(
                        new LessonType(rs.getInt("lessonTypeId"),
                                rs.getString("lessonTypeName"),
                                rs.getBoolean("status")));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return lessonTypesList;
    }
}
