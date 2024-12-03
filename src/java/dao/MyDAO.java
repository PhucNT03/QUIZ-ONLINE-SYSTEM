package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Lớp này chứa các interface của AnswerDAOImpl
 *
 */
public class MyDAO extends DBConnection{
    public Connection conn = null;
    public PreparedStatement ps = null;
    public ResultSet rs = null;
    public String xSql = null;
    
    public MyDAO(){
        conn = connection;
    }
    
    public void finalize(){
        try{
            if (conn != null) conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
