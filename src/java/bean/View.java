package bean;

import java.util.Date;

/**
 *
 * View entity
 */
public class View {

    private Date date;
    private int view;

    /**
     * Blank constructor
     */
    public View() {
    }

    /**
     * Complete constructor
     *
     * @param date
     * @param view
     */
    public View(Date date, int view) {
        this.date = date;
        this.view = view;
    }

    /**
     * Get date
     *
     * @return
     */
    public Date getDate() {
        return date;
    }

    /**
     * Set date
     *
     * @param date
     */
    public void setDate(Date date) {
        this.date = date;
    }

    /**
     * Get view
     *
     * @return
     */
    public int getView() {
        return view;
    }

    /**
     * Get userRoleID
     *
     * @param view
     */
    public void setView(int view) {
        this.view = view;
    }

}
