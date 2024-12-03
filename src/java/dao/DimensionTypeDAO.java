package dao;

import bean.DimensionType;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của DimensionTypeDAOImpl
 *
 */
public interface DimensionTypeDAO {
    public ArrayList<DimensionType> getAllDimensionTypes() throws Exception;
    
    public DimensionType getDimensionTypeById(int dimensionTypeId) throws Exception;
}
