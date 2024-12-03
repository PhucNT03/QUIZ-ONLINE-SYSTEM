package bean;

/**
 *
 * Slider entity
 */
public class Slider {

    /**
     * Slider id
     */
    private int sliderId;
    /**
     * Slider title, image, link, note
     */
    private String sliderTitle, image, link, note;
    /**
     * Slider status
     */
    private boolean status;

    /**
     * Constructor
     */
    public Slider() {
    }

    /**
     * Constructor
     *
     * @param sliderId it is an int
     * @param sliderTitle it is a <code>java.lang.String</code>
     * @param image it is a <code>java.lang.String</code>
     * @param link it is a <code>java.lang.String</code>
     * @param note it is a <code>java.lang.String</code>
     * @param status it is a <code>java.lang.boolean</code>
     */
    public Slider(int sliderId, String sliderTitle, String image, String link, String note, boolean status) {
        this.sliderId = sliderId;
        this.sliderTitle = sliderTitle;
        this.image = image;
        this.link = link;
        this.note = note;
        this.status = status;
    }

    /**
     * Get value form sliderId attribute of Slider class. <br>
     *
     * @return sliderId it is an int
     */
    public int getSliderId() {
        return sliderId;
    }

    /**
     * Set value to sliderId attribute of Slider class <br>
     *
     * @param sliderId it is an int
     */
    public void setSliderId(int sliderId) {
        this.sliderId = sliderId;
    }

    /**
     * Get value from title attribute of Slider class. <br>
     *
     * @return title it is a <code>java.lang.String</code>
     */
    public String getSliderTitle() {
        return sliderTitle;
    }

    /**
     * Set value from sliderTitle attribute of Slider class. <br>
     *
     * @param sliderTitle it is a <code>java.lang.String</code>
     */
    public void setSliderTitle(String sliderTitle) {
        this.sliderTitle = sliderTitle;
    }

    /**
     * Get value from image attribute of Slider class. <br>
     *
     * @return image it is a <code>java.lang.String</code>
     */
    public String getImage() {
        return image;
    }

    /**
     * Set value from image attribute of Slider class. <br>
     *
     * @param image it is a <code>java.lang.String</code>
     */
    public void setImage(String image) {
        this.image = image;
    }

    /**
     * Get value from link attribute of Slider class. <br>
     *
     * @return link it is a <code>java.lang.String</code>
     */
    public String getLink() {
        return link;
    }

    /**
     * Set value from link attribute of Slider class. <br>
     *
     * @param link it is a <code>java.lang.String</code>
     */
    public void setLink(String link) {
        this.link = link;
    }

    /**
     * Get value from note attribute of Slider class. <br>
     *
     * @return note it is a <code>java.lang.String</code>
     */
    public String getNote() {
        return note;
    }

    /**
     * Set value from note attribute of Slider class. <br>
     *
     * @param note it is a <code>java.lang.String</code>
     */
    public void setNote(String note) {
        this.note = note;
    }

    /**
     * Check value from status attribute of Slider class. <br>
     *
     * @return status it is a <code>java.lang.boolean</code>
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set value from status attribute of Slider class. <br>
     *
     * @param status it is a <code>java.lang.String</code>
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

}
