package bean;

import java.util.ArrayList;

/**
 * QuestionQuizHandle entity
 *
 *
 */
public class QuestionQuizHandle {

    private Question question;
    /*Question entity*/
    private ArrayList<Answer> answerList;
    /*Arraylist Answer of Question*/
    private int answeredId;
    /*Answered answer id*/
    private boolean marked;

    /*Question Marked/Not*/

    /**
     * Blank Constructor
     */
    public QuestionQuizHandle() {
    }

    /**
     * Complete constructor
     *
     * @param question
     * @param answerList
     * @param answeredId
     * @param marked
     */
    public QuestionQuizHandle(Question question, ArrayList<Answer> answerList, int answeredId, boolean marked) {
        this.question = question;
        this.answerList = answerList;
        this.answeredId = answeredId;
        this.marked = marked;
    }

    /**
     * Get Marked
     *
     * @return
     */
    public boolean isMarked() {
        return marked;
    }

    /**
     * Set Marked
     *
     * @param marked
     */
    public void setMarked(boolean marked) {
        this.marked = marked;
    }

    /**
     * Get Answered ID
     *
     * @return
     */
    public int getAnsweredId() {
        return answeredId;
    }

    /**
     * Set answered Id
     *
     * @param answeredId
     */
    public void setAnsweredId(int answeredId) {
        this.answeredId = answeredId;
    }

    /**
     * Get question
     *
     * @return
     */
    public Question getQuestion() {
        return question;
    }

    /**
     * Set question
     *
     * @param question
     */
    public void setQuestion(Question question) {
        this.question = question;
    }

    /**
     * Get AnswerList
     *
     * @return
     */
    public ArrayList<Answer> getAnswerList() {
        return answerList;
    }

    /**
     * Set AnswerList
     *
     * @param answerList
     */
    public void setAnswerList(ArrayList<Answer> answerList) {
        this.answerList = answerList;
    }

}
