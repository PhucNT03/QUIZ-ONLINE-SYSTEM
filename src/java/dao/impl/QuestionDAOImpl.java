package dao.impl;

import bean.Question;
import dao.DBConnection;
import dao.QuestionDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * Lớp này có các phương thức thực hiện truy xuất và ghi dữ liệu vào database
 * liên quan tới bảng Question phục vụ cho các chức năng liên quan tới Question
 * của dự án
 *
 */
public class QuestionDAOImpl extends DBConnection implements QuestionDAO {

     /**
     *
     * @param numberOfQuestion
     * @param subjectId
     * @param dimensionId
     * @return <code>ArrayList<DimensionType></code> object
     * @throws Exception
     */
    @Override
    public ArrayList<Question> getQuestionForCreateQuiz(int numberOfQuestion, int subjectId, int dimensionId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;/* Result set returned by the sqlserver */
        PreparedStatement pre = null;/* Prepared statement for executing sql queries */
        ArrayList<Question> questionList = new ArrayList<>();
        String sql = "SELECT [questionId]\n"
                + "      ,[subjectId]\n"
                + "      ,[dimensionId]\n"
                + "      ,[lessonId]\n"
                + "      ,[content]\n"
                + "      ,[media]\n"
                + "      ,[explanation]\n"
                + "      ,[status]\n"
                + "  FROM [QuizSystem].[dbo].[Question]\n"
                + "  WHERE subjectId = ? AND dimensionId = ? AND [status] = 1\n"
                + "  ORDER BY NEWID()";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, subjectId);
            pre.setInt(2, dimensionId);
            rs = pre.executeQuery();
            while (rs.next() && questionList.size() < numberOfQuestion) {
                Question pro = new Question();
                pro.setQuestionId(rs.getInt("questionId"));
                pro.setSubjectId(rs.getInt("subjectId"));
                pro.setDimensionId(rs.getInt("dimensionId"));
                pro.setLessonId(rs.getInt("lessonId"));
                pro.setContent(rs.getString("content"));
                pro.setMedia(rs.getString("media"));
                pro.setStatus(rs.getBoolean("status"));
                questionList.add(pro);
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return questionList;
    }

     /**
     * get list of question of the target quiz
     *
     * @param quizId the target quiz's id. It is a <code>int</code> primitive
     * type
     * @return a list of question. It is a <code>java.util.ArrayList</code>
     * object.
     * @throws java.lang.Exception
     */
    @Override
    public ArrayList<Question> getQuestionByQuizId(int quizId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */

        ArrayList<Question> questionList = new ArrayList();
        ArrayList<Integer> idList = new ArrayList();
        String sql = "SELECT * FROM [QuizQuestion] WHERE quizId=" + quizId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                idList.add(rs.getInt("questionId"));
            }
            for (int id : idList) {
                questionList.add(getQuestionById(id));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        return questionList;
    }



    /**
     * turn a list of question into list of question quiz handle
     *
     * @param questionId the target question's id. It is a <code>int</code>
     * primitive type
     * @return a question. It is a <code>Question</code> object.
     * @throws java.lang.Exception
     */
    @Override
    public Question getQuestionById(int questionId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "SELECT * FROM Question WHERE questionId=" + questionId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                return new Question(rs.getInt("questionId"),
                        rs.getInt("subjectId"),
                        rs.getInt("dimensionId"),
                        rs.getInt("lessonId"),
                        rs.getString("content"),
                        rs.getString("media"),
                        rs.getString("explanation"),
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
