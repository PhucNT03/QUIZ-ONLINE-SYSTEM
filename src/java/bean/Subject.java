
package bean;

import java.util.ArrayList;

/**
 *  Subject entity: Hold all the data of the subject
 */
public class Subject {
    private int subjectId;  /* Subject's id */
    private String subjectName; /* Subject's Name */
    private String description; /* Subject's Description */
    private String thumbnail;   /* Subject's Thumbnail */
    private boolean featuredSubject;    /* Is featuredSubject or not */
    private boolean status; /* Subject's Status */
    private ArrayList<Dimension> dimensions;    /* Subject's dimensions */
    private ArrayList<SubjectCate> categories;  /* Subject's categories */

    
    /**
     * Blank constructor
     */
    public Subject() {
    }
    
    /**
     * Constructor without array lists
     * @param subjectId
     * @param subjectName
     * @param description
     * @param thumbnail
     * @param featuredSubject
     * @param status 
     */
    public Subject(int subjectId, String subjectName, String description, String thumbnail, boolean featuredSubject, boolean status) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.description = description;
        this.thumbnail = thumbnail;
        this.featuredSubject = featuredSubject;
        this.status = status;
    }

    /**
     * Complete constructor
     * @param subjectId
     * @param subjectName
     * @param description
     * @param thumbnail
     * @param featuredSubject
     * @param status
     * @param dimensions
     * @param categories 
     */
    public Subject(int subjectId, String subjectName, String description, String thumbnail, boolean featuredSubject, boolean status, ArrayList<Dimension> dimensions,  ArrayList<SubjectCate> categories) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.description = description;
        this.thumbnail = thumbnail;
        this.featuredSubject = featuredSubject;
        this.status = status;
        this.dimensions = dimensions;
        this.categories = categories;
    }

    /**
     * Get category list
     * @return 
     */
    public ArrayList<SubjectCate> getCategories() {
        return categories;
    }

    /**
     * Set category list
     * @param categories 
     */
    public void setCategories(ArrayList<SubjectCate> categories) {
        this.categories = categories;
    }

    /**
     * Get dimension list
     * @return 
     */
    public ArrayList<Dimension> getDimensions() {
        return dimensions;
    }
    
    /**
     * Set dimension list
     * @param dimensions 
     */
    public void setDimensions(ArrayList<Dimension> dimensions) {
        this.dimensions = dimensions;
    }

    /**
     * Get subject id
     * @return 
     */
    public int getSubjectId() {
        return subjectId;
    }

    /**
     * Set subject id
     * @param subjectId 
     */
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    /**
     * Get featured subject
     * @return 
     */
    public boolean isFeaturedSubject() {
        return featuredSubject;
    }

    /**
     * Set featured subject
     * @param featuredSubject 
     */
    public void setFeaturedSubject(boolean featuredSubject) {
        this.featuredSubject = featuredSubject;
    }

    /**
     * Get status
     * @return 
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set status
     * @param status 
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

    /**
     * Get subject name
     * @return 
     */
    public String getSubjectName() {
        return subjectName;
    }

    /**
     * Set subject name
     * @param subjectName 
     */
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    /**
     * Get description
     * @return 
     */
    public String getDescription() {
        return description;
    }

    /**
     * Set description
     * @param description 
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Get thumbnail
     * @return 
     */
    public String getThumbnail() {
        return thumbnail;
    }

    /**
     * Set thumbnail
     * @param thumbnail 
     */
    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
    
    /**
     * Get subject in string form
     * @return 
     */
    @Override
    public String toString(){
        return ("Id: " + this.subjectId +
                "\nName: " + this.subjectName +
                "\nDescription: " + this.description + 
                "\nThumbnail: " + this.thumbnail + 
                "\nFeatured: " + featuredSubject + 
                "\nStatus: " + status +
                "\nCategory: " + categories.size() +
                "\nDimension: " + dimensions.size());
    }
    
}
