
package bean;

/**
 *
 */
public class Answer {
    private int answerId;   /* Answer Id */
    private int questionId; /* Question's Id */
    private String answerContent;   /* Answer's Content */
    private boolean isCorrect;  /* If answer is correct */
    private boolean status; /* Answer's status */
    
    /**
     * Blank Constructor
     */
    public Answer() {
    }

    /**
     * Complete Constructor
     * @param answerId
     * @param questionId
     * @param answerContent
     * @param isCorrect
     * @param status 
     */
    public Answer(int answerId, int questionId, String answerContent, boolean isCorrect, boolean status) {
        this.answerId = answerId;
        this.questionId = questionId;
        this.answerContent = answerContent;
        this.isCorrect = isCorrect;
        this.status = status;
    }
    
    /**
     * 
     * @return answerId
     */
    public int getAnswerId() {
        return answerId;
    }

    /**
     * 
     * @return questionId
     */
    public int getQuestionId() {
        return questionId;
    }

    /**
     * 
     * @return answerContent
     */
    public String getAnswerContent() {
        return answerContent;
    }

    /**
     * 
     * @return isCorrect 
     */
    public boolean isIsCorrect() {
        return isCorrect;
    }

    /**
     * 
     * @return status
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set answerId
     * @param answerId 
     */
    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    /**
     * Set questionId
     * @param questionId 
     */
    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    /**
     * Set answer Content
     * @param answerContent 
     */
    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    /**
     * Set correct answer
     * @param isCorrect 
     */
    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    /**
     * Set Status
     * @param status 
     */
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}
