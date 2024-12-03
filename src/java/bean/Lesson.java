package bean;

/**
 * Lesson entity
 *
 */
public class Lesson {

    private int lessonId;
    /*Lesson id*/
    private int subjectId;
    /*Subject Id*/
    private String lessonName;
    /*Lesson Name*/
    private int lessonOrder;
    /*Lesson order number*/
    private int lessonTypeId;
    /*Lesson type Id*/
    private String videoLink;
    /*Lesson video link*/
    private String content;
    /*Lesson content*/
    private boolean status;
    /*Lesson status*/
    private String lessonTypeName;

    /*Lesson type name*/

    /**
     * Blank Constructor
     */
    public Lesson() {
    }

    /**
     * Complete constructor
     *
     * @param lessonId
     * @param subjectId
     * @param lessonName
     * @param lessonOrder
     * @param lessonTypeId
     * @param videoLink
     * @param content
     * @param status
     * @param lessonTypeName
     */
    public Lesson(int lessonId, int subjectId, String lessonName, int lessonOrder, int lessonTypeId, String videoLink, String content, boolean status, String lessonTypeName) {
        this.lessonId = lessonId;
        this.subjectId = subjectId;
        this.lessonName = lessonName;
        this.lessonOrder = lessonOrder;
        this.lessonTypeId = lessonTypeId;
        this.videoLink = videoLink;
        this.content = content;
        this.status = status;
        this.lessonTypeName = lessonTypeName;
    }

    /**
     * Get lesson Id
     *
     * @return
     */
    public int getLessonId() {
        return lessonId;
    }

    /**
     * Set lesson Id
     *
     * @param lessonId
     */
    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    /**
     * Get subject ID
     *
     * @return
     */
    public int getSubjectId() {
        return subjectId;
    }

    /**
     * Set subject Id
     *
     * @param subjectId
     */
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    /**
     * Get lesson Name
     *
     * @return
     */
    public String getLessonName() {
        return lessonName;
    }

    /**
     * Set lesson Name
     *
     * @param lessonName
     */
    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    /**
     * Get lesson Order #
     *
     * @return
     */
    public int getLessonOrder() {
        return lessonOrder;
    }

    /**
     * Set lesson order #
     *
     * @param lessonOrder
     */
    public void setLessonOrder(int lessonOrder) {
        this.lessonOrder = lessonOrder;
    }

    /**
     * Get lesson type id
     *
     * @return
     */
    public int getLessonTypeId() {
        return lessonTypeId;
    }

    /**
     * Set lesson type ID
     *
     * @param lessonTypeId
     */
    public void setLessonTypeId(int lessonTypeId) {
        this.lessonTypeId = lessonTypeId;
    }

    /**
     * Get lesson video link
     *
     * @return
     */
    public String getVideoLink() {
        return videoLink;
    }

    /**
     * Set lesson video link
     *
     * @param videoLink
     */
    public void setVideoLink(String videoLink) {
        this.videoLink = videoLink;
    }

    /**
     * Get lesson content
     *
     * @return
     */
    public String getContent() {
        return content;
    }

    /**
     * Set lesson content
     *
     * @param content
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * Get lesson status
     *
     * @return
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set lesson status
     *
     * @param status
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

    /**
     * Get Lesson type name
     *
     * @return
     */
    public String getLessonTypeName() {
        return lessonTypeName;
    }

    /**
     * Set lesson type name
     *
     * @param lessonTypeName
     */
    public void setLessonTypeName(String lessonTypeName) {
        this.lessonTypeName = lessonTypeName;
    }

}
