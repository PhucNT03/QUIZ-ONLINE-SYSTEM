package dao;

import bean.CustomerQuiz;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của CustomerQuizDAOImpl
 *
 */
public interface CustomerQuizDAO {

    public ArrayList<CustomerQuiz> getAllCustomerQuiz() throws Exception;

    /**
     * get the last added customer quiz
     *
     * @return a customer quiz. It is a <code>CustomerQuiz</code> object.
     * @throws java.lang.Exception
     */
    public CustomerQuiz getLastAddedCustomerQuiz() throws Exception;

    /**
     * get user's taken quiz
     *
     * @param quizTakeId target quiz. It is a <code>int</code> primitive type
     * @return a quiz. It is a <code>CustomerQuiz</code> object
     * @throws Exception
     */
    public CustomerQuiz getQuizByTakeQuizId(int quizTakeId) throws Exception;

    public ArrayList<CustomerQuiz> getQuizByUser(int userId) throws Exception;
}
