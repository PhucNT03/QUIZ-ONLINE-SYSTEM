package dao.impl;

import bean.DimensionType;
import dao.DBConnection;
import dao.DimensionTypeDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * Lớp này chứa các method của DimensionTypeDAOImpl
 *
 *
 */
public class DimensionTypeDAOImpl extends DBConnection implements DimensionTypeDAO {

    @Override
    public ArrayList<DimensionType> getAllDimensionTypes() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<DimensionType> dimensionTypesList = new ArrayList<>();
        String sql = "SELECT [dimensionTypeId]\n"
                + "      ,[dimensionTypeName]\n"
                + "      ,[status]\n"
                + "  FROM [QuizSystem].[dbo].[DimensionType]\n"
                + "  WHERE status = 1 ";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                dimensionTypesList.add(
                        new DimensionType(rs.getInt("dimensionTypeId"),
                                rs.getString("dimensionTypeName"),
                                rs.getBoolean("status")));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return dimensionTypesList;
    }

    @Override
    public DimensionType getDimensionTypeById(int dimensionTypeId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        String sql = "SELECT * FROM [DimensionType] WHERE dimensionTypeId=" + dimensionTypeId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                return new DimensionType(rs.getInt("dimensionTypeId"),
                        rs.getString("dimensionTypeName"),
                        rs.getBoolean("status"));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }

        return null;
    }

}
