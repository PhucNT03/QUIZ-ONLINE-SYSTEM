package bean;

/**
 * LessonType entity
 *
 */
public class LessonType {

    private int lessonTypeId;
    /*Lesson type id*/
    private String lessonTypeName;
    /*Lesson type name*/
    private boolean status;

    /*Lesson Status*/
    /**
     * Blank constructor
     */
    public LessonType() {
    }

    /**
     * Complete constructor
     *
     * @param lessonTypeId
     * @param lessonTypeName
     * @param status
     */
    public LessonType(int lessonTypeId, String lessonTypeName, boolean status) {
        this.lessonTypeId = lessonTypeId;
        this.lessonTypeName = lessonTypeName;
        this.status = status;
    }

    /**
     * Get lesson type Id
     *
     * @return
     */
    public int getLessonTypeId() {
        return lessonTypeId;
    }

    /**
     * Set lesson Type ID
     *
     * @return
     */
    public String getLessonTypeName() {
        return lessonTypeName;
    }

    /**
     * Get lesson type status
     *
     * @return
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set lesson type Id
     *
     * @param lessonTypeId
     */
    public void setLessonTypeId(int lessonTypeId) {
        this.lessonTypeId = lessonTypeId;
    }

    /**
     * Set lesson type name
     *
     * @param lessonTypeName
     */
    public void setLessonTypeName(String lessonTypeName) {
        this.lessonTypeName = lessonTypeName;
    }

    /**
     * Set lesson type status
     *
     * @param status
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

}
