package dao.impl;

import bean.Answer;
import bean.Question;
import bean.QuestionQuizHandle;
import dao.DBConnection;
import dao.QuestionQuizHandleDAO;
import java.util.ArrayList;

/**
 * Lớp này có các phương thức thực hiện tạo ra những câu hỏi trong bài quiz bằng
 * các câu hỏi lấy từ database, kết hợp với QuizQuizHandle để phục vụ funtion
 * QuizHandle hoặc QuizReview
 *
 */
public class QuestionQuizHandleDAOImpl extends DBConnection implements QuestionQuizHandleDAO {

    /**
     * get right answer of the question
     *
     * @param question the target question's id. It is a
     * <code>QuestionQuizHandle</code> object
     * @return right answer of the question. It is <code>Answer</code> object.
     * @throws java.lang.Exception
     */
    @Override
    public Answer getRightAnswer(QuestionQuizHandle question) throws Exception {
        ArrayList<Answer> answerList = question.getAnswerList();
        for (Answer answer : answerList) {
            if (answer.isIsCorrect()) {
                return answer;
            }
        }
        return null;
    }

    /**
     * mark and unmark question
     *
     * @param question the target question's id. It is a
     * <code>QuestionQuizHandle</code> object
     * @return void.
     */
    @Override
    public void markQuestion(QuestionQuizHandle question) throws Exception {
        if (question.isMarked()) {
            question.setMarked(false);
        } else {
            question.setMarked(true);
        }
    }

    /**
     * turn a Question into QuestionQUizHandle type
     *
     * @param questionId the target question's id. It is a <code>int</code>
     * primitive type
     * @return a QuestionQuizHandle <code>QuestionQuizHandle</code> object.
     * @throws java.lang.Exception
     */
    @Override
    public QuestionQuizHandle generateQuestionById(int questionId) throws Exception {
        QuestionDAOImpl questionDAO = new QuestionDAOImpl();
        AnswerDAOImpl answerDAO = new AnswerDAOImpl();
        Question question = questionDAO.getQuestionById(questionId);                        //get question
        ArrayList<Answer> answers = answerDAO.getAnswersByQuenstionId(questionId);          //get question's answer list
        return new QuestionQuizHandle(question, answers, 0, false);                         //constructor(question,question's answers list, user's answerd id,marked)
    }

}
