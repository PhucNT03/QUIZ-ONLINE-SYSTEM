package dao;

import bean.SubjectCate;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của SubjectCateDAOImpl
 *
 *
 */
public interface SubjectCateDAO {
  /**
     * Get subject categories of a specified subject
     *
     * @param subjectId
     * @return
     * @throws Exception
     */
    public ArrayList<SubjectCate> getSubjectCateBySubject(int subjectId) throws Exception;

    public ArrayList<SubjectCate> getRemainSubjectCateBySubject(int subjectId) throws Exception;
    
    public String[] getSubjectCateIdBySubject(int subjectId) throws Exception;
    
    public int addCategorySubject(int subjectId, int categoryId) throws Exception;
    
    public int deteleCategorySubject(int subjectId, int categoryId) throws Exception;
}
