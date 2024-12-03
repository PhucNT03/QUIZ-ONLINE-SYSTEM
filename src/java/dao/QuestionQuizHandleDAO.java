package dao;

import bean.Answer;
import bean.QuestionQuizHandle;

/**
 * Lớp này chứa các interface của QuestionQuizHandleDAOImpl
 *
 */
public interface QuestionQuizHandleDAO {

    /**
     * turn a Question into QuestionQUizHandle type
     *
     * @param questionId the target question's id. It is a <code>int</code>
     * primitive type
     * @return a QuestionQuizHandle <code>QuestionQuizHandle</code> object.
     * @throws java.lang.Exception
     */
    public QuestionQuizHandle generateQuestionById(int questionId) throws Exception;

    /**
     * get right answer of the question
     *
     * @param question the target question's id. It is a
     * <code>QuestionQuizHandle</code> object
     * @return right answer of the question. It is <code>Answer</code> object.
     * @throws java.lang.Exception
     */
    public Answer getRightAnswer(QuestionQuizHandle question) throws Exception;

    /**
     * mark and unmark question
     *
     * @param question the target question's id. It is a
     * <code>QuestionQuizHandle</code> object
     * @return void.
     * @throws java.lang.Exception
     */
    public void markQuestion(QuestionQuizHandle question) throws Exception;

}
