package bean;

/**
 *
 *
 */
public class QuestionManage {

    private int questionId;
    /*Question ID*/
    private String subjectName;
    /*Subject Name*/
    private String dimensionName;
    /*Question Dimension Name*/
    private String lessonName;
    /*Question Lesson name*/
    private String content;
    /*Question content*/
    private String media;
    /*Question media*/
    private String explanation;
    /*Question Explaination*/
    private boolean status;

    /*Question status*/

    /**
     * Blank Constructor
     */
    public QuestionManage() {
    }

    /**
     * Complete constructor
     *
     * @param questionId
     * @param subjectName
     * @param dimensionName
     * @param lessonName
     * @param content
     * @param media
     * @param explanation
     * @param status
     */
    public QuestionManage(int questionId, String subjectName, String dimensionName, String lessonName, String content, String media, String explanation, boolean status) {
        this.questionId = questionId;
        this.subjectName = subjectName;
        this.dimensionName = dimensionName;
        this.lessonName = lessonName;
        this.content = content;
        this.media = media;
        this.explanation = explanation;
        this.status = status;
    }

    /**
     * Get QuestionId
     *
     * @return
     */
    public int getQuestionId() {
        return questionId;
    }

    /**
     * Set QuestionId
     *
     * @param questionId
     */
    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    /**
     * Get SubjectName
     *
     * @return
     */
    public String getSubjectName() {
        return subjectName;
    }

    /**
     * Set SubjectName
     *
     * @param subjectName
     */
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    /**
     * Get DimensionName
     *
     * @return
     */
    public String getDimensionName() {
        return dimensionName;
    }

    /**
     * Set DimensionName
     *
     * @param dimensionName
     */
    public void setDimensionName(String dimensionName) {
        this.dimensionName = dimensionName;
    }

    /**
     * Get LessonName
     *
     * @return
     */
    public String getLessonName() {
        return lessonName;
    }

    /**
     * Set LessonName
     *
     * @param lessonName
     */
    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    /**
     * Get Content
     *
     * @return
     */
    public String getContent() {
        return content;
    }

    /**
     * Set Content
     *
     * @param content
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * Get Media
     *
     * @return
     */
    public String getMedia() {
        return media;
    }

    /**
     * Set Media
     *
     * @param media
     */
    public void setMedia(String media) {
        this.media = media;
    }

    /**
     * Get Explanation
     *
     * @return
     */
    public String getExplanation() {
        return explanation;
    }

    /**
     * Set explanation
     *
     * @param explanation
     */
    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    /**
     * Get Status
     *
     * @return
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set Status
     *
     * @param status
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

}
