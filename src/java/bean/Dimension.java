
package bean;

/**
 *  Hold the data of dimension entity
 */
public class Dimension {
    private int dimensionId; /*Dimension Id*/
    private int subjectId; /*Subject's Id*/
    private int dimensionTypeId; /*Dimension Type Id*/
    private String dimensionTypeName; /*Dimension Type Name*/
    private String dimensionName; /*Dimension Name*/
    private String description; /*Dimension Description*/
    private boolean status; /*Dimension Status*/

    /**
     * Blank constructor
     */
    public Dimension() {
    }

    /**
     * Complete constructor
     * @param dimensionId
     * @param subjectId
     * @param dimensionTypeId
     * @param dimensionTypeName
     * @param dimensionName
     * @param description
     * @param status 
     */
    public Dimension(int dimensionId, int subjectId, int dimensionTypeId, String dimensionTypeName, String dimensionName, String description, boolean status) {
        this.dimensionId = dimensionId;
        this.subjectId = subjectId;
        this.dimensionTypeId = dimensionTypeId;
        this.dimensionTypeName = dimensionTypeName;
        this.dimensionName = dimensionName;
        this.description = description;
        this.status = status;
    }

    /**
     * Get dimension Id
     * @return 
     */
    public int getDimensionId() {
        return dimensionId;
    }

    /**
     * Set Dimension ID
     * @param dimensionId 
     */
    public void setDimensionId(int dimensionId) {
        this.dimensionId = dimensionId;
    }

    /**
     * Get subject Id
     * @return 
     */
    public int getSubjectId() {
        return subjectId;
    }

    /**
     * Set Subject Id
     * @param subjectId 
     */
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    /**
     * Get dimension Type Id
     * @return 
     */
    public int getDimensionTypeId() {
        return dimensionTypeId;
    }
   
    /**
     * Set dimension Type Id
     * @param dimensionTypeId 
     */
    public void setDimensionTypeId(int dimensionTypeId) {
        this.dimensionTypeId = dimensionTypeId;
    }

    /**
     * Get dimension Type Id
     * @return 
     */
    public String getDimensionTypeName() {
        return dimensionTypeName;
    }

    /**
     * Set dimension type Name
     * @param dimensionTypeName 
     */
    public void setDimensionTypeName(String dimensionTypeName) {
        this.dimensionTypeName = dimensionTypeName;
    }

    /**
     * get Dimension Name
     * @return 
     */
    public String getDimensionName() {
        return dimensionName;
    }

    /**
     * Set dimension Name
     * @param dimensionName 
     */
    public void setDimensionName(String dimensionName) {
        this.dimensionName = dimensionName;
    }

    /**
     * Get dimension Description
     * @return 
     */
    public String getDescription() {
        return description;
    }

    /**
     * Set dimension description
     * @param description 
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Get dimension status
     * @return 
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set dimension status
     * @param status 
     */
    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}
