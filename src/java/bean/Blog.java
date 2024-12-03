
package bean;

import java.sql.Date;

/**
 *
 */
public class Blog {

    private int blogId; /* Blog's Id */
    private String blogTitle;   /* Blog Title */
    private Date created;   /* Blog created date */
    private Date lastEdited;    /* Blog last edited date */
    private User author;    /* Blog's author */
    private String detail;  /* Blog content */
    private String thumbnail; /* Blog thumbnail */
    private Boolean status; /* Blog status */

    
    /**
     * Blank constructor
     */
    public Blog() {
    }

    /**
     * Full constructor
     * @param blogId
     * @param blogTitle
     * @param created
     * @param lastEdited
     * @param author
     * @param detail
     * @param thumbnail
     * @param status 
     */
    public Blog(int blogId, String blogTitle, Date created, Date lastEdited, User author, String detail, String thumbnail, Boolean status) {
        this.blogId = blogId;
        this.blogTitle = blogTitle;
        this.created = created;
        this.lastEdited = lastEdited;
        this.author = author;
        this.detail = detail;
        this.thumbnail = thumbnail;
        this.status = status;
    }

    /**
     * Get blogId
     * @return 
     */
    public int getBlogId() {
        return blogId;
    }

    /**
     * Set blogId
     * @param blogId 
     */
    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    /**
     * Get Blog Author
     * @return 
     */
    public User getAuthor() {
        return author;
    }

    /**
     * Set Blog Author
     * @param author 
     */
    public void setAuthor(User author) {
        this.author = author;
    }

   /**
    * Get created date
    * @return 
    */
    public Date getCreated() {
        return created;
    }

    /**
     * Set Created Date
     * @param created 
     */
    public void setCreated(Date created) {
        this.created = created;
    }

    /**
     * Get lastEdited Date
     * @return 
     */
    public Date getLastEdited() {
        return lastEdited;
    }

    /**
     * Set lastEdited Date
     * @param lastEdited 
     */
    public void setLastEdited(Date lastEdited) {
        this.lastEdited = lastEdited;
    }

    /**
     * Get Blog Title
     * @return 
     */
    public String getBlogTitle() {
        return blogTitle;
    }

    /**
     * Set blog title
     * @param blogTitle 
     */
    public void setBlogTitle(String blogTitle) {
        this.blogTitle = blogTitle;
    }

    /**
     * Get blog content
     * @return 
     */
    public String getDetail() {
        return detail;
    }

    /**
     * Set blog content
     * @param detail 
     */
    public void setDetail(String detail) {
        this.detail = detail;
    }

    /**
     * Get blog thumbnail
     * @return 
     */
    public String getThumbnail() {
        return thumbnail;
    }

    /**
     * Set blog thumbnail
     * @param thumbnail 
     */
    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    /**
     * Get blog status
     * @return 
     */
    public Boolean getStatus() {
        return status;
    }

    /**
     * Set blog Status
     * @param status 
     */
    public void setStatus(Boolean status) {
        this.status = status;
    }

}
