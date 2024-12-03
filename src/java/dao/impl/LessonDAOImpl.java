package dao.impl;

import bean.Lesson;
import dao.DBConnection;
import dao.LessonDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * The class has methods needed for initialize connection with database and 
 * execute queries with Lesson and associate tables
 *
 */
public class LessonDAOImpl extends DBConnection implements LessonDAO {
    @Override
    public ArrayList<Lesson> getAllLessons() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        ArrayList<Lesson> listLesson = new ArrayList();
        String sql = "SELECT [lessonId]\n"
                + "      ,[subjectId]\n"
                + "      ,[lessonName]\n"
                + "      ,[lessonOrder]\n"
                + "      ,[lessonTypeId]\n"
                + "      ,[videoLink]\n"
                + "      ,[content]\n"
                + "      ,[status]\n"
                + "  FROM [QuizSystem].[dbo].[Lesson]";
        /* Get the dimension */
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            /* Get information from resultset and add it to arrayList */
            while (rs.next()) {
                int lessonId = rs.getInt("lessonId");
                int subjectId = rs.getInt("subjectId");
                String lessonName = rs.getString("lessonName");
                int lessonOrder = rs.getInt("lessonOrder");
                int lessonTypeId = rs.getInt("lessonTypeId");
                String videoLink = rs.getString("videoLink");
                String content = rs.getString("content");
                Boolean status = rs.getBoolean("status");
                listLesson.add(new Lesson(lessonId, subjectId, lessonName, lessonOrder, lessonTypeId, videoLink, content, status, null));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return listLesson;
    }
    
    @Override
    public Lesson getLessonById(int lessonId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        Lesson lessonById = null;
        String sql = "SELECT * FROM [Lesson] WHERE [lessonId] = ?";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, lessonId);
            rs = pre.executeQuery();
            if (rs.next()) {
                int subjectId = rs.getInt("subjectId");
                String lessonName = rs.getString("lessonName");
                int lessonOrder = rs.getInt("lessonOrder");
                int lessonTypeId = rs.getInt("lessonTypeId");
                String videoLink = rs.getString("videoLink");
                String content = rs.getString("content");
                Boolean status = rs.getBoolean("status");

                lessonById = new Lesson(lessonId, subjectId, lessonName, lessonOrder, lessonTypeId, videoLink, content, status, null);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return lessonById;
    }

    @Override
    public ArrayList<Lesson> getAllLessonBySubjectId(int subjectId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

 /* Get dimension list of the subject */
        ArrayList<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT L.[lessonId]"
                + "      ,S.[subjectId]\n"
                + "      ,L.[lessonName]\n"
                + "      ,L.[lessonOrder]\n"
                + "      ,L.[lessonTypeId]\n"
                + "	  ,LT.lessonTypeName\n"
                + "      ,L.[videoLink]\n"
                + "      ,L.[content]\n"
                + "      ,L.[status]\n"
                + "  FROM [QuizSystem].[dbo].[Subject] S "
                + "  INNER JOIN [QuizSystem].[dbo].[Lesson] L ON S.subjectId = L.subjectId\n"
                + "  INNER JOIN [QuizSystem].[dbo].[LessonType] LT ON LT.lessonTypeId = L.lessonTypeId\n"
                + "  WHERE S.subjectId = " + subjectId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                lessons.add(new Lesson(rs.getInt("lessonId"), 
                        subjectId, 
                        rs.getString("lessonName"),
                        rs.getInt("lessonOrder"),
                        rs.getInt("lessonTypeId"),
                        rs.getString("videoLink"),
                        rs.getString("content"),
                        rs.getBoolean("status"),
                        rs.getString("lessonTypeName")));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return lessons;
    }

}
