
package bean;

import java.util.ArrayList;

/**
 * question entity
 *
 */
public class Question {

    private int questionId; /*Question ID*/
    private int subjectId; /*Subject ID*/
    private int dimensionId; /*Dimension ID*/
    private int lessonId; /*Lesson ID*/
    private String content; /*Question Content*/
    private String media; /*Question Media*/
    private String explanation; /*Question Explanation*/
    private boolean status; /*Question Status*/
    private ArrayList<Answer> answers = new ArrayList<>(); /*Question answers*/
    
    /**
     * Blank constructor
     */
    public Question() {
    }

    /**
     * Complete constructor
     * @param questionId
     * @param subjectId
     * @param dimensionId
     * @param lessonId
     * @param content
     * @param media
     * @param explanation
     * @param status 
     */
    public Question(int questionId, int subjectId, int dimensionId, int lessonId, String content, String media, String explanation, boolean status) {
        this.questionId = questionId;
        this.subjectId = subjectId;
        this.dimensionId = dimensionId;
        this.lessonId = lessonId;
        this.content = content;
        this.media = media;
        this.explanation = explanation;
        this.status = status;
    }
    
    /**
     * Get Question Id
     * @return 
     */
    public int getQuestionId() {
        return questionId;
    }

    /**
     * Set QuestionId
     * @param questionId 
     */
    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    /**
     * Get SubjectId
     * @return 
     */
    public int getSubjectId() {
        return subjectId;
    }

    /**
     * Set SubjectId
     * @param subjectId 
     */
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    /**
     * Get DimensionId
     * @return 
     */
    public int getDimensionId() {
        return dimensionId;
    }

    /**
     * Set DimensionId
     * @param dimensionId 
     */
    public void setDimensionId(int dimensionId) {
        this.dimensionId = dimensionId;
    }

    /**
     * Get LessonId
     * @return 
     */
    public int getLessonId() {
        return lessonId;
    }

    /**
     * Set LessonId
     * @param lessonId 
     */
    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    /**
     * Get Content
     * @return 
     */
    public String getContent() {
        return content;
    }

    /**
     * Set Content
     * @param content 
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * Get Media
     * @return 
     */
    public String getMedia() {
        return media;
    }

    /**
     * Set Media
     * @param media 
     */
    public void setMedia(String media) {
        this.media = media;
    }

    /**
     * Get Explanation
     * @return 
     */
    public String getExplanation() {
        return explanation;
    }

    /**
     * Set Explanation
     * @param explanation 
     */
    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    /**
     * Get Status
     * @return 
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set Status
     * @param status 
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

    /**
     * Get answers
     * @return Array list of answers
     */
    public ArrayList<Answer> getAnswers() {
        return answers;
    }

    /**
     * Set answers
     * @param answers 
     */
    public void setAnswers(ArrayList<Answer> answers) {
        this.answers = answers;
    }
    
    

}
