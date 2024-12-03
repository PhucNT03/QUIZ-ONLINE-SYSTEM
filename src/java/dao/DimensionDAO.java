package dao;

import bean.Dimension;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của DimensionDAOImpl
 *
 */
public interface DimensionDAO {
    /**
     * Get dimensions of a subject
     * @param subjectId
     * @return
     * @throws Exception 
     */
    public ArrayList<Dimension> getAllDimension() throws Exception;
    
    public ArrayList<Dimension> getDimensionBySubject(int subjectId) throws Exception;
    
    public int addDimension(Dimension dimension) throws Exception;
    
    public int deleteDimension(int dimensionId) throws Exception;
     
    public int editDimension(int dimensionId, Dimension dimension) throws Exception;
}
