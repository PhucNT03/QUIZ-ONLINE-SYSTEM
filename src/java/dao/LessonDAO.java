package dao;

import bean.Lesson;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của LessonDAOImpl
 *
 *
 */
public interface LessonDAO {

    public ArrayList<Lesson> getAllLessons() throws Exception;

    public Lesson getLessonById(int lessonId) throws Exception;
    
    public ArrayList<Lesson> getAllLessonBySubjectId(int subjectId) throws Exception;
}
