package bean;

/**
 * Quiz entity
 *
 */
public class Quiz {

    private int quizId;
    /*Quiz ID*/
    private Lesson lesson;
    /*Lesson Entity*/
    private Subject subject;
    /*Subject Entity*/
    private String quizName;
    /*Quiz Name*/
    private int quizLevelId;
    /*Quiz Level ID*/
    private String quizLevelName;
    /*Quiz Level Name*/
    private int quizDuration;
    /*Quiz duration In second*/
    private int passRate;
    /*Quiz required passrate*/
    private int testTypeId;
    /*Test type ID*/
    private String testTypeName;
    /*Test Type Name*/
    private String description;
    /*Quiz Description*/
    private int numberQuestion;
    /*Quiz's number of question*/
    private int dimensionTypeId;
    /*Quiz Dimension Type ID*/
    private String dimensionTypeName;
    /*Quiz Dimension Type Name*/
    private Boolean status;

    /*Quiz Status*/

    /**
     * Complete Constructor
     *
     * @param quizId
     * @param lesson
     * @param subject
     * @param quizName
     * @param quizLevelId
     * @param quizLevelName
     * @param quizDuration
     * @param passRate
     * @param testTypeId
     * @param testTypeName
     * @param description
     * @param numberQuestion
     * @param dimensionTypeId
     * @param dimensionTypeName
     * @param status
     */
    public Quiz(int quizId, Lesson lesson, Subject subject, String quizName, int quizLevelId, String quizLevelName, int quizDuration, int passRate, int testTypeId, String testTypeName, String description, int numberQuestion, int dimensionTypeId, String dimensionTypeName, Boolean status) {
        this.quizId = quizId;
        this.lesson = lesson;
        this.subject = subject;
        this.quizName = quizName;
        this.quizLevelId = quizLevelId;
        this.quizLevelName = quizLevelName;
        this.quizDuration = quizDuration;
        this.passRate = passRate;
        this.testTypeId = testTypeId;
        this.testTypeName = testTypeName;
        this.description = description;
        this.numberQuestion = numberQuestion;
        this.dimensionTypeId = dimensionTypeId;
        this.dimensionTypeName = dimensionTypeName;
        this.status = status;
    }

    /**
     * Blank constructor
     */
    public Quiz() {
    }

    /**
     * Get Quiz ID
     *
     * @return
     */
    public int getQuizId() {
        return quizId;
    }

    /**
     * Set Quiz ID
     *
     * @param quizId
     */
    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    /**
     * Get Lesson
     *
     * @return
     */
    public Lesson getLesson() {
        return lesson;
    }

    /**
     * Set lesson
     *
     * @param lesson
     */
    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    /**
     * Get subject
     *
     * @return
     */
    public Subject getSubject() {
        return subject;
    }

    /**
     * Set subject
     *
     * @param subject
     */
    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    /**
     * Get quiz Name
     *
     * @return
     */
    public String getQuizName() {
        return quizName;
    }

    /**
     * Set quiz name
     *
     * @param quizName
     */
    public void setQuizName(String quizName) {
        this.quizName = quizName;
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
     * Get quiz level name
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
     * Get quiz duration
     *
     * @return
     */
    public int getQuizDuration() {
        return quizDuration;
    }

    /**
     * Set quiz duration
     *
     * @param quizDuration
     */
    public void setQuizDuration(int quizDuration) {
        this.quizDuration = quizDuration;
    }

    /**
     * Get passRate
     *
     * @return
     */
    public int getPassRate() {
        return passRate;
    }

    /**
     * Set passRate
     *
     * @param passRate
     */
    public void setPassRate(int passRate) {
        this.passRate = passRate;
    }

    /**
     * Get test type id
     *
     * @return
     */
    public int getTestTypeId() {
        return testTypeId;
    }

    /**
     * Set test type id
     *
     * @param testTypeId
     */
    public void setTestTypeId(int testTypeId) {
        this.testTypeId = testTypeId;
    }

    /**
     * Get test type name
     *
     * @return
     */
    public String getTestTypeName() {
        return testTypeName;
    }

    /**
     * Set test type name
     *
     * @param testTypeName
     */
    public void setTestTypeName(String testTypeName) {
        this.testTypeName = testTypeName;
    }

    /**
     * Get description
     *
     * @return
     */
    public String getDescription() {
        return description;
    }

    /**
     * Set description
     *
     * @param description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Get number of question
     *
     * @return
     */
    public int getNumberQuestion() {
        return numberQuestion;
    }

    /**
     * Set number of question
     *
     * @param numberQuestion
     */
    public void setNumberQuestion(int numberQuestion) {
        this.numberQuestion = numberQuestion;
    }

    /**
     * Get dimension type id
     *
     * @return
     */
    public int getDimensionTypeId() {
        return dimensionTypeId;
    }

    /**
     * Set dimension type id
     *
     * @param dimensionTypeId
     */
    public void setDimensionTypeId(int dimensionTypeId) {
        this.dimensionTypeId = dimensionTypeId;
    }

    /**
     * Get dimension Type name
     *
     * @return
     */
    public String getDimensionTypeName() {
        return dimensionTypeName;
    }

    /**
     * Set dimension Type Name
     *
     * @param dimensionTypeName
     */
    public void setDimensionTypeName(String dimensionTypeName) {
        this.dimensionTypeName = dimensionTypeName;
    }

    /**
     * Get Status
     *
     * @return
     */
    public Boolean getStatus() {
        return status;
    }

    /**
     * Set status
     *
     * @param status
     */
    public void setStatus(Boolean status) {
        this.status = status;
    }

    /**
     * Get quiz duration in string form
     *
     * @return
     */
    public String getDurationString() {
        String durationString = "";
        int minute = quizDuration / 60;
        int second = quizDuration % 60;
        durationString = minute + ":" + second;
        return durationString;
    }
}
