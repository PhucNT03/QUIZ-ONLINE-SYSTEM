package bean;

/**
 * this entity hold statistics data (name, value, date)
 *
 */
public class ItemDashboard {

    private String Name; //name of data 
    private double value; //value of data
    private long date; //date of data

    public ItemDashboard() {
    }

    public ItemDashboard(String Name, double value, long date) {
        this.Name = Name;
        this.value = value;
        this.date = date;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public long getDate() {
        return date;
    }

    public void setDate(long date) {
        this.date = date;
    }

}
