package dao;

import bean.Registration;
import bean.RegistrationManage;
import bean.Subject;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của RegistrationDAOImpl
 *
 */
public interface RegistrationDAO {

     
    public int addRegistration(Registration newRegistration) throws Exception;
    
    
    public int editRegistration(int registrationId, Registration editedRegistration) throws Exception;

    
    public Registration getRegistrationById(int registrationId) throws Exception;

    
    public ArrayList<RegistrationManage> getFilterRegistration(int subjectId, int userId) throws Exception;
    
    public ArrayList<Subject> getRegistedSubject(int userId) throws Exception;
    
    public ArrayList<Subject> getRegistedSubjectbyUserId(int userId) throws Exception;

}
