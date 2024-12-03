package dao.impl;

import bean.SubjectCate;
import dao.DBConnection;
import dao.SubjectCateDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * The class has methods needed for initialize connection with database and
 * execute queries with SubjectCate and associate tables
 *
 */
public class SubjectCateDAOImpl extends DBConnection implements SubjectCateDAO {

    /**
     * Get subject categories of a specified subject
     *
     * @param subjectId
     * @return
     * @throws Exception
     */
    @Override
    public ArrayList<SubjectCate> getSubjectCateBySubject(int subjectId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
 /* Getcategory list of the subject */
        ArrayList<SubjectCate> categories = new ArrayList<>();
        String sql = "SELECT C.[subjectId]\n"
                + "      ,C.[cateId]\n"
                + "	   ,S.[status]\n"
                + "	   ,S.subjectCateName\n"
                + "  FROM [QuizSystem].[dbo].[CategorySubject] C \n"
                + "  INNER JOIN [QuizSystem].[dbo].SubjectCate S\n"
                + "  ON C.cateId = S.subjectCateId WHERE C.subjectId = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, subjectId);
            rs = pre.executeQuery();
            while (rs.next()) {
                categories.add(new SubjectCate(rs.getInt("cateId"), rs.getString("subjectCateName"), rs.getBoolean("status")));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return categories;
    }

    @Override
    public ArrayList<SubjectCate> getRemainSubjectCateBySubject(int subjectId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
 /* Getcategory list of the subject */
        ArrayList<SubjectCate> remainCategories = new ArrayList<>();
        String sql = "SELECT [subjectCateId]\n"
                + "      ,[subjectCateName]\n"
                + "      ,[status]\n"
                + "  FROM [QuizSystem].[dbo].[SubjectCate]\n"
                + "  WHERE [subjectCateId] NOT IN (SELECT C.[cateId]\n"
                + "				FROM [QuizSystem].[dbo].[CategorySubject] C\n"
                + "				INNER JOIN [QuizSystem].[dbo].SubjectCate S\n"
                + "				ON C.cateId = S.subjectCateId WHERE C.subjectId = ?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, subjectId);
            rs = pre.executeQuery();
            while (rs.next()) {
                remainCategories.add(new SubjectCate(rs.getInt("subjectCateId"), rs.getString("subjectCateName"), rs.getBoolean("status")));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return remainCategories;
    }
   


    @Override
    public int addCategorySubject(int subjectId, int categoryId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        String sql = "INSERT INTO dbo.CategorySubject(subjectId,cateId) "
                + "VALUES(?,?)";
        int check = 0;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, subjectId);
            pre.setInt(2, categoryId);
            check = pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return check;
    }


    @Override
    public int deteleCategorySubject(int subjectId, int categoryId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        String sql = "DELETE FROM dbo.CategorySubject "
                + "WHERE subjectId = ? AND "
                + "cateId = ?";
        int check = 0;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, subjectId);
            pre.setInt(2, categoryId);
            check = pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return check;
    }

    @Override
    public String[] getSubjectCateIdBySubject(int subjectId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
 /* Getcategory list of the subject */
        ArrayList<String> categoryId = new ArrayList<>();
        String sql = "SELECT C.[cateId]\n"
                + "  FROM [QuizSystem].[dbo].[CategorySubject] C \n"
                + "  INNER JOIN [QuizSystem].[dbo].SubjectCate S\n"
                + "  ON C.cateId = S.subjectCateId WHERE C.subjectId = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, subjectId);
            rs = pre.executeQuery();
            while (rs.next()) {
                categoryId.add(rs.getString("cateId"));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }

        String[] idString = new String[categoryId.size()];
        return categoryId.toArray(idString);
    }
}
