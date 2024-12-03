package bean;

/**
 * PostCate entity
 *
 *
 */
public class PostCate {

    private int postCateId;
    /*Post category Id*/
    private String postCateName;
    /*Post category name*/
    private boolean status;

    /*Post category status*/

    /**
     * Blank constructor
     */
    public PostCate() {
    }

    /**
     * Complete constructor
     *
     * @param postCateId
     * @param postCateName
     * @param status
     */
    public PostCate(int postCateId, String postCateName, boolean status) {
        this.postCateId = postCateId;
        this.postCateName = postCateName;
        this.status = status;
    }

    /**
     * Get post category id
     *
     * @return
     */
    public int getPostCateId() {
        return postCateId;
    }

    /**
     * Get post category name
     *
     * @return
     */
    public String getPostCateName() {
        return postCateName;
    }

    /**
     * Get post category status
     *
     * @return
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set post category id
     *
     * @param postCateId
     */
    public void setPostCateId(int postCateId) {
        this.postCateId = postCateId;
    }

    /**
     * Set post category name
     *
     * @param postCateName
     */
    public void setPostCateName(String postCateName) {
        this.postCateName = postCateName;
    }

    /**
     * Set post category status
     *
     * @param status
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

}
