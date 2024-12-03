package bean;

import java.util.Date;

/**
 * Registration entity
 *
 */
public class Registration {

    private int regId;
    /*Registration ID*/
    private int userId;
    /*ID User Registered*/
    private Date regTime;
    /*Registration Time*/
    private int lastUpdatedBy;
    /*Last updated by user(id)*/
    private String note;
    /*Update note*/
    private boolean status;

    /*Registration Status*/
    /**
     * Blank Constructor
     */
    public Registration() {
    }

    /**
     * Complete constructor
     *
     * @param regId
     * @param userId
     * @param regTime
     * @param lastUpdatedBy
     * @param note
     * @param status
     */
    public Registration(int regId, int userId, Date regTime, int lastUpdatedBy, String note, boolean status) {
        this.regId = regId;
        this.userId = userId;
        this.regTime = regTime;
        this.lastUpdatedBy = lastUpdatedBy;
        this.note = note;
        this.status = status;
    }

    /**
     * Get registration id
     *
     * @return
     */
    public int getRegId() {
        return regId;
    }

    /**
     * Set Registration ID
     *
     * @param regId
     */
    public void setRegId(int regId) {
        this.regId = regId;
    }

    /**
     * Get Registered user id
     *
     * @return
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Set Registered user id
     *
     * @param userId
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Get last update user
     *
     * @return
     */
    public int getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    /**
     * Set last update user
     *
     * @param lastUpdatedBy
     */
    public void setLastUpdatedBy(int lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    /**
     * Get registration time
     *
     * @return
     */
    public Date getRegTime() {
        return regTime;
    }

    /**
     * Set register time
     *
     * @param regTime
     */
    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }

    /**
     * Get note
     *
     * @return
     */
    public String getNote() {
        return note;
    }

    /**
     * Set note
     *
     * @param note
     */
    public void setNote(String note) {
        this.note = note;
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
     * Set Status
     *
     * @param status
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

}
