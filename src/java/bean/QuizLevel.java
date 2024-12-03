package bean;

/**
 * QuizLevel entity
 */
public class QuizLevel {

    private int quizLevelId;
    /*Quiz Level Id*/
    private String quizLevelName;
    /*Quiz Level Name*/
    private boolean status;

    /*Quiz Status*/

    /**
     * Blank constructor
     */
    public QuizLevel() {
    }

    /**
     * Complete constructor
     *
     * @param quizLevelId
     * @param quizLevelName
     * @param status
     */
    public QuizLevel(int quizLevelId, String quizLevelName, boolean status) {
        this.quizLevelId = quizLevelId;
        this.quizLevelName = quizLevelName;
        this.status = status;
    }

    /**
     * Get quiz level id
     *
     * @return
     */
    public int getQuizLevelId() {
        return quizLevelId;
    }

    /**
     * Set quiz level id
     *
     * @param quizLevelId
     */
    public void setQuizLevelId(int quizLevelId) {
        this.quizLevelId = quizLevelId;
    }

    /**
     * Get quiz level Name
     *
     * @return
     */
    public String getQuizLevelName() {
        return quizLevelName;
    }

    /**
     * Set quiz level name
     *
     * @param quizLevelName
     */
    public void setQuizLevelName(String quizLevelName) {
        this.quizLevelName = quizLevelName;
    }

    /**
     * Get status
     *
     * @return
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Get status
     *
     * @param status
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

}
