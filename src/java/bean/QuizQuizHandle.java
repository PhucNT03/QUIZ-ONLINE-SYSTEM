package bean;

import java.util.ArrayList;

/**
 * QuizQuizHandle Entity
 */
public class QuizQuizHandle {

    private Quiz quiz;
    /*Quiz entiry*/
    private ArrayList<QuestionQuizHandle> questions;
    /*List of question*/
    private User user;
    /*User Entity(taken the quiz)*/
    private int Time;

    /*Quiz time taken(in second)*/

    /**
     * Constructor with blank question list
     */
    public QuizQuizHandle() {
        questions = new ArrayList<>();
    }

    /**
     * Complete constructor
     *
     * @param quiz
     * @param questions
     * @param user
     * @param Time
     */
    public QuizQuizHandle(Quiz quiz, ArrayList<QuestionQuizHandle> questions, User user, int Time) {
        this.quiz = quiz;
        this.questions = questions;
        this.user = user;
        this.Time = Time;
    }

    /**
     * Constructor with question list
     *
     * @param questions
     */
    public QuizQuizHandle(ArrayList<QuestionQuizHandle> questions) {
        this.questions = questions;
    }

    /**
     * Get question
     *
     * @return
     */
    public ArrayList<QuestionQuizHandle> getQuestions() {
        return questions;
    }

    /**
     * Set question
     *
     * @param questions
     */
    public void setQuestions(ArrayList<QuestionQuizHandle> questions) {
        this.questions = questions;
    }

    /**
     * Get user
     *
     * @return
     */
    public User getUser() {
        return user;
    }

    /**
     * Set user
     *
     * @param user
     */
    public void setUser(User user) {
        this.user = user;
    }

    /**
     * Get quiz
     *
     * @return
     */
    public Quiz getQuiz() {
        return quiz;
    }

    /**
     * Set quiz
     *
     * @param quiz
     */
    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    /**
     * Get time taken
     *
     * @return
     */
    public int getTime() {
        return Time;
    }

    /**
     * Set time taken
     *
     * @param Time
     */
    public void setTime(int Time) {
        this.Time = Time;
    }

    /**
     * Get question by number of questions
     *
     * @param questionNumber
     * @return
     */
    public QuestionQuizHandle getQuestionByNumber(int questionNumber) {
        return questions.get(questionNumber - 1);
    }

    /**
     * Add question
     *
     * @param question
     */
    public void addQuestion(QuestionQuizHandle question) {
        questions.add(question);
    }

    /**
     * Remove question
     *
     * @param question
     */
    public void removeQuestion(QuestionQuizHandle question) {
        questions.remove(question);
    }

}
