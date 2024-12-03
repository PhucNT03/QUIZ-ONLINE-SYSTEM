
package dao;

import bean.LessonType;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của LessonTypeDAOImpl
 *
 */
public interface LessonTypeDAO {
    public ArrayList<LessonType> getAllLessonType() throws Exception;
}
