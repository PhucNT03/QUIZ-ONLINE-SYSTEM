package dao.impl;

import bean.CustomerQuiz;
import bean.Quiz;
import dao.CustomerQuizDAO;
import dao.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 * Lớp này có các phương thức thực hiện truy xuất và ghi dữ liệu vào database
 * liên quan tới bảng CustomerQuiz, TakeAnswer phục vụ cho các chức năng liên
 * quan tới QuizReview của dự án
 *
 */
public class CustomerQuizDAOImpl extends DBConnection implements CustomerQuizDAO {

    @Override

    public ArrayList<CustomerQuiz> getQuizByUser(int userId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        CustomerQuiz add = null;
        QuizDAOImpl quizDAO = new QuizDAOImpl();
        TestTypeDAOImpl testTypeDAO = new TestTypeDAOImpl();
        ArrayList<CustomerQuiz> custormerQuiz = new ArrayList<>();
        String sql = "SELECT [quizTakeId]\n"
                + "      ,[quizId]\n"
                + "      ,[userId]\n"
                + "      ,[score]\n"
                + "      ,[time]\n"
                + "      ,[sumitedAt]\n"
                + "      ,[status]\n"
                + "  FROM [QuizSystem].[dbo].[CustomerQuiz]\n"
                + "  WHERE userId = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, userId);
            rs = pre.executeQuery();
            while (rs.next()) {
                Timestamp time = new Timestamp(rs.getTimestamp("sumitedAt").getTime());
                add = new CustomerQuiz(rs.getInt("quizTakeId"),
                        rs.getInt("quizId"),
                        rs.getInt("userId"),
                        rs.getInt("score"),
                        rs.getInt("time"),
                        time,
                        rs.getBoolean("status"));
                Quiz quiz = quizDAO.getQuizById(rs.getInt("quizId"));
                add.setQuizName(quiz.getQuizName());
                add.setSubjectName(quiz.getSubject().getSubjectName());
                add.setTestTypeName(testTypeDAO.getTestTypeById(quiz.getTestTypeId()).getTestTypeName());
                custormerQuiz.add(add);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return custormerQuiz;
    }

    @Override
    public ArrayList<CustomerQuiz> getAllCustomerQuiz() throws Exception {
        ArrayList<CustomerQuiz> allCustomerQuiz = null;
        return allCustomerQuiz;
    }

    /**
     * get the last added customer quiz
     *
     * @return a customer quiz. It is a <code>CustomerQuiz</code> object.
     * @throws java.lang.Exception
     */
    @Override
    public CustomerQuiz getLastAddedCustomerQuiz() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        String sql = "SELECT TOP 1 * FROM [CustomerQuiz] ORDER BY quizTakeId DESC";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                Timestamp time = new Timestamp(rs.getTimestamp("sumitedAt").getTime());
                return new CustomerQuiz(rs.getInt("quizTakeId"),
                        rs.getInt("quizId"),
                        rs.getInt("userId"),
                        rs.getInt("score"),
                        rs.getInt("time"),
                        time,
                        rs.getBoolean("status"));
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    /**
     * get user's taken quiz
     *
     * @param quizTakeId target quiz. It is a <code>int</code> primitive type
     * @return a quiz. It is a <code>CustomerQuiz</code> object
     * @throws Exception
     */
    @Override
    public CustomerQuiz getQuizByTakeQuizId(int quizTakeId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "SELECT * FROM [CustomerQuiz] WHERE quizTakeId=" + quizTakeId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                Timestamp time = new Timestamp(rs.getTimestamp("sumitedAt").getTime());
                return new CustomerQuiz(rs.getInt("quizTakeId"),
                        rs.getInt("quizId"),
                        rs.getInt("userId"),
                        rs.getInt("score"),
                        rs.getInt("time"),
                        time,
                        rs.getBoolean("status"));
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

}
