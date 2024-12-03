package dao.impl;

import bean.Answer;
import bean.Question;
import bean.QuestionQuizHandle;
import bean.Quiz;
import bean.QuizQuizHandle;
import bean.User;
import dao.CustomerQuizDAO;
import dao.DBConnection;
import dao.QuestionDAO;
import dao.QuizQuizHandleDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * Lớp này có các phương thức thực hiện tạo ra những bài quiz từ các câu hỏi lấy
 * từ database phục vụ funtion QuizHandle hoặc QuizReview
 *
 */
public class QuizQuizHandleDAOImpl extends DBConnection implements QuizQuizHandleDAO {

    /**
     * turn a list of question into list of question quiz handle
     *
     * @param questionList target question list. It is a
     * <code>java.util.ArrayList</code> object
     * @param quizId the Id of the quiz whose above questionList. It is
     * <code>int</code> primitive type
     * @param user user doing quiz. <code>User</code> object
     *
     * @return a <code>QuizQuizHandle</code> object.
     * @throws java.lang.Exception
     */
    @Override
    public QuizQuizHandle generateQuiz(ArrayList<Question> questionList, int quizId, User user) throws Exception {
        QuizQuizHandle quiz = new QuizQuizHandle();
        QuestionQuizHandleDAOImpl questionQuizzHandleDAO = new QuestionQuizHandleDAOImpl();
        QuizDAOImpl quizDAO = new QuizDAOImpl();
        Quiz quizInDatabase = quizDAO.getQuizById(quizId);
        for (Question question : questionList) {
            int questionId = question.getQuestionId();
            QuestionQuizHandle questionQH = questionQuizzHandleDAO.generateQuestionById(questionId);//turn a question into question quiz handle
            quiz.addQuestion(questionQH);                                                           //add question to list           
        }

        quiz.setQuiz(quizInDatabase);
        quiz.setTime(quizInDatabase.getQuizDuration());
        quiz.setUser(user);
        return quiz;
    }

     /**
     * get number of answered question (submited quiz)
     *
     * @param quiz the target quiz. It is a <code>QuizQuizHandle</code> object
     * @return a <code>QuizQuizHandle</code> object.
     * @throws java.lang.Exception
     */
    @Override
    public int getAnsweredQuestion(QuizQuizHandle quiz) throws Exception {
        ArrayList<QuestionQuizHandle> questionList = quiz.getQuestions();
        int count = 0;
        for (QuestionQuizHandle question : questionList) {
            if (question.getAnsweredId() != 0) {
                count += 1;
            }
        }
        return count;
    }
    
      /**
     * turn a list of question into list of question quiz handle
     *
     * @param quizTakeId the target quiz's id. It is a <code>int</code>
     * primitive type
     * @return a <code>QuizQuizHandle</code> object.
     * @throws java.lang.Exception
     */
    @Override
    public QuizQuizHandle getReviewQuiz(int quizTakeId) throws Exception {
        QuestionDAO questionDAO = new QuestionDAOImpl();
        QuizQuizHandle reviewQuiz = new QuizQuizHandle();
        QuizDAOImpl quizDAO = new QuizDAOImpl();
        Quiz quiz = quizDAO.getQuizByQuizTakeId(quizTakeId);
        CustomerQuizDAO customerQuizInterface = new CustomerQuizDAOImpl();
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        AnswerDAOImpl answerDAO = new AnswerDAOImpl();
        ArrayList<QuestionQuizHandle> questionList = new ArrayList();
        String sql = "SELECT * FROM [TakeAnswer] WHERE quizTakeId=" + quizTakeId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                Question question = questionDAO.getQuestionById(rs.getInt("questionId"));
                ArrayList<Answer> answers = answerDAO.getAnswersByQuenstionId(rs.getInt("questionId"));
                questionList.add(new QuestionQuizHandle(question,
                        answers,
                        rs.getInt("answerId"),
                        rs.getBoolean("status")));
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
        reviewQuiz.setQuestions(questionList);
        reviewQuiz.setQuiz(quiz);
        reviewQuiz.setTime(customerQuizInterface.getQuizByTakeQuizId(quizTakeId).getTime());
        return reviewQuiz;
    }

  
}
