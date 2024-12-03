package dao;

import bean.Quiz;
import java.util.ArrayList;


/**
 * Lớp này chứa các interface của QuizDAOImpl
 *
 */
public interface QuizDAO {

    /**
     * add a quiz into the database
     *
     * @param quiz
     * @return
     * @throws Exception
     */
    public int addQuiz(Quiz quiz) throws Exception;

    /**
     * get all simulation quiz by user search
     *
     * @param userId user's id. <code>int</code> primitive type
     * @param subjectId user's registered subject's id. <code>int</code>
     * primitive type
     * @param quizName search string to search quiz by name. <code>String</code>
     * primitive type
     * @return all simulation quiz by user. <code>ArrayList<Quiz></code> object
     * @throws Exception
     */
    public ArrayList<Quiz> getAllSimulationQuizByUser(int userId, int subjectId, String quizName) throws Exception;

    /**
     * get taken quiz by takeQuiz's Id
     *
     * @param quizTakeId the target quiz's id. It is a <code>int</code>
     * primitive type
     * @return a quiz <code>Quiz</code> object.
     * @throws java.lang.Exception
     */
    public Quiz getQuizByQuizTakeId(int quizTakeId) throws Exception;

    /**
     * Get quiz that have some same attribute
     *
     * @param quiz
     * @return
     * @throws Exception
     */
    public int getQuizIdCreated(Quiz quiz) throws Exception;

    /**
     * add quiz's question to the database
     *
     * @param quizId
     * @param questionId
     * @return
     * @throws Exception
     */
    public int addQuizQuestion(int quizId, int questionId) throws Exception;

    public Quiz getQuizById(int quizId) throws Exception;
    
    public ArrayList<Quiz> getQuizBySubject(int subjectId) throws Exception;
}
