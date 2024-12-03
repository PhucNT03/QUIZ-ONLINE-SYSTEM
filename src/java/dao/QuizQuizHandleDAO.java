package dao;

import bean.Question;
import bean.QuizQuizHandle;
import bean.User;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của QuizQuizHandleDAOImpl
 *
 */
public interface QuizQuizHandleDAO {

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
    public QuizQuizHandle generateQuiz(ArrayList<Question> questionList, int quizId, User user) throws Exception;

    /**
     * get number of answered question (submited quiz)
     *
     * @param quiz the target quiz. It is a <code>QuizQuizHandle</code> object
     * @return a <code>QuizQuizHandle</code> object.
     * @throws java.lang.Exception
     */
    public int getAnsweredQuestion(QuizQuizHandle quiz) throws Exception;

    /**
     * turn a list of question into list of question quiz handle
     *
     * @param quizTakeId the target quiz's id. It is a <code>int</code>
     * primitive type
     * @return a <code>QuizQuizHandle</code> object.
     * @throws java.lang.Exception
     */
    public QuizQuizHandle getReviewQuiz(int quizTakeId) throws Exception;

}
