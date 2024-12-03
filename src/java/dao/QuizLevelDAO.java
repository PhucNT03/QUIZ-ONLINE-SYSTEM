package dao;

import bean.QuizLevel;

/**
 * Lớp này chứa các interface của QuizLevelDAOImpl
 *
 */
public interface QuizLevelDAO {

    public QuizLevel getQuizLevelById(int quizLevelId) throws Exception;
}
