package dao;

import bean.TestType;

/**
 * Lớp này chứa các interface của TestTypeDAOImpl
 *
 *
 */
public interface TestTypeDAO {

    public TestType getTestTypeById(int testTypeId) throws Exception;
}
