package dao;

import bean.Answer;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của AnswerDAOImpl
 *
 */
public interface AnswerDAO {
    
    /**
     * get Answer by QuestionId
     *
     * @param questionId the target question id. It is a <code>int</code>
     * primitive
     * @return a list of Answer. It is a <code>java.util.ArrayList</code>
     * @throws Exception
     */
    public ArrayList<Answer> getAnswersByQuenstionId(int questionId) throws Exception;
    
}
