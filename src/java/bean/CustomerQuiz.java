package bean;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 */
public class CustomerQuiz {

    private int quizTakeId;
    /*Quiz take id(The attempt)*/
    private int quizId;
    /*Quiz Id(The real quiz)*/
    private int userId;
    /*User Id(Taken the quiz)*/
    private int score;
    /*Attempt Score*/
    private int time;
    /*Attempt time*/
    private Timestamp submitedAt;
    /*Time submitted*/
    private boolean status;
    /*Status*/
    private String quizName;
    /*Quiz's name*/
    private String subjectName;
    /*Subject;s name*/
    private String testTypeName;

    /*Test type's name*/

    /**
     * Blank constructor
     */
    public CustomerQuiz() {
    }

    /**
     * Complete constructor
     *
     * @param quizTakeId
     * @param quizId
     * @param userId
     * @param score
     * @param time
     * @param submitedAt
     * @param status
     */
    public CustomerQuiz(int quizTakeId, int quizId, int userId, int score, int time, Timestamp submitedAt, boolean status) {
        this.quizTakeId = quizTakeId;
        this.quizId = quizId;
        this.userId = userId;
        this.score = score;
        this.time = time;
        this.submitedAt = submitedAt;
        this.status = status;
    }

    /**
     * Set testTypeName
     *
     * @param testTypeName
     */
    public void setTestTypeName(String testTypeName) {
        this.testTypeName = testTypeName;
    }

    /**
     * Get testTypeName
     *
     * @return
     */
    public String getTestTypeName() {
        return testTypeName;
    }

    /**
     * Get quizName
     *
     * @return
     */
    public String getQuizName() {
        return quizName;
    }

    /**
     * Get subjectName
     *
     * @return
     */
    public String getSubjectName() {
        return subjectName;
    }

    /**
     * Set quizName
     *
     * @param quizName
     */
    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    /**
     * Set subjectName
     *
     * @param subjectName
     */
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    /**
     * Get quiz Time
     *
     * @return
     */
    public int getTime() {
        return time;
    }

    /**
     * Set quiz Time
     *
     * @param time
     */
    public void setTime(int time) {
        this.time = time;
    }

    /**
     * Get quiz Take Id
     *
     * @return
     */
    public int getQuizTakeId() {
        return quizTakeId;
    }

    /**
     * Set quizTakeId
     *
     * @param quizTakeId
     */
    public void setQuizTakeId(int quizTakeId) {
        this.quizTakeId = quizTakeId;
    }

    /**
     * Get QuizId
     *
     * @return
     */
    public int getQuizId() {
        return quizId;
    }

    /**
     * Set QuizId
     *
     * @param quizId
     */
    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    /**
     * Get UserId
     *
     * @return
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Set userId
     *
     * @param userId
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Get Score
     *
     * @return
     */
    public int getScore() {
        return score;
    }

    /**
     * Set Score
     *
     * @param score
     */
    public void setScore(int score) {
        this.score = score;
    }

    /**
     * Get time submitted
     *
     * @return
     */
    public Timestamp getSubmitedAt() {
        return submitedAt;
    }

    /**
     * Set time submitted
     *
     * @param submitedAt
     */
    public void setSubmitedAt(Timestamp submitedAt) {
        this.submitedAt = submitedAt;
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
     * Set status
     *
     * @param status
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

    /**
     * Get quiz taken date
     *
     * @return
     */
    public String getDateTaken() {
        Date date = new Date(submitedAt.getTime());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
        String dateTaken = simpleDateFormat.format(date);
        return dateTaken;
    }

    /**
     * Get duration in string
     *
     * @return
     */
    public String getDurationString() {
        String durationString = "";
        int minute = time / 60;
        int second = time % 60;
        durationString = minute + ":" + second;
        return durationString;
    }
}
