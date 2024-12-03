package controller;

import bean.Answer;
import bean.CustomerQuiz;
import bean.Question;
import bean.QuestionQuizHandle;
import bean.QuizQuizHandle;
import bean.User;
import dao.CustomerQuizDAO;
import dao.QuestionDAO;
import dao.QuestionQuizHandleDAO;
import dao.QuizQuizHandleDAO;
import dao.impl.CustomerQuizDAOImpl;
import dao.impl.QuestionDAOImpl;
import dao.impl.QuestionQuizHandleDAOImpl;
import dao.impl.QuizQuizHandleDAOImpl;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * This class has the process request of quiz handle
 *
 * @author NamDH
 */
public class QuizHandleController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods. Function Quiz Handle: allow user to answer question, submit quiz
     * for scoring Quiz Review: allow user to review quiz after be taken
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    static final int IMAGE_MEDIA_TYPE = 1;
    static final int VIDEO_MEDIA_TYPE = 2;
    static final int EXAM_TYPE_ID = 1;
    static final int QUIZ_EXAM_TYPE_ID = 2;
    static final int PRACTICE_TYPE_ID = 3;
    static final int DEFAULT_PAGE = 1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            QuizQuizHandleDAO quizQHInterface = new QuizQuizHandleDAOImpl();
            QuestionQuizHandleDAO questionQHInterface = new QuestionQuizHandleDAOImpl();
            QuestionDAO questionInterface = new QuestionDAOImpl();
            String service = request.getParameter("service");

            /**
             * create session for taking quiz
             */
            if (service.equalsIgnoreCase("quizEntrance")) {
                HttpSession session = request.getSession();
                int quizId = Integer.parseInt(request.getParameter("quizId"));
                if (session.getAttribute("doingQuiz") == null) {
                    User user = (User) session.getAttribute("currUser");
                    ArrayList<Question> questionList = questionInterface.getQuestionByQuizId(quizId);
                    QuizQuizHandle doingQuiz = quizQHInterface.generateQuiz(questionList, quizId, user);
                    session.setAttribute("doingQuiz", doingQuiz);
                }
                response.sendRedirect("quizHandleController?service=quizHandle&quizId=" + quizId + "&questionNumber=1");
            }

            /**
             * Service quiz handle: handle with all situation happen in a quiz
             * taking session
             */
            if (service.equalsIgnoreCase("quizHandle")) {
                //get quiz from session or generate new quiz (not yet have userId)
                HttpSession session = request.getSession(true);
                Object object = session.getAttribute("doingQuiz");
                if (object != null) {
                    QuizQuizHandle doingQuiz = (QuizQuizHandle) object;
                    int quizId = doingQuiz.getQuiz().getQuizId();
                    request.setAttribute("quizId", quizId);
                    int quizType = doingQuiz.getQuiz().getTestTypeId();
                    request.setAttribute("quizType", quizType);

                    ArrayList<QuestionQuizHandle> quiz = doingQuiz.getQuestions();
                    request.setAttribute("quiz", quiz);

                    //get question id
                    int questionNumber;
                    if (request.getParameter("questionNumber") == null) {
                        questionNumber = DEFAULT_PAGE;
                    } else {
                        questionNumber = Integer.parseInt(request.getParameter("questionNumber"));
                    }
                    QuestionQuizHandle questionQH = doingQuiz.getQuestionByNumber(questionNumber);

                    String media = questionQH.getQuestion().getMedia();
                    if (media != null) {
                        int mediaType = VIDEO_MEDIA_TYPE;
                        String[] imageExtensions = {".jpg", ".gif", ".jpeg", ".jfif", ".pjpeg", ".png", ".pjps"};
                        for (String extension : imageExtensions) {
                            if (media.contains(extension)) {
                                mediaType = IMAGE_MEDIA_TYPE;
                            }
                        }
                        request.setAttribute("mediaType", mediaType);
                    }
                    //send being taking question's information
                    request.setAttribute("questionQH", questionQH);
                    //true answer of question
                    Answer trueAnswer = questionQHInterface.getRightAnswer(questionQH);
                    request.setAttribute("trueAnswer", trueAnswer.getAnswerContent());
                    //number of question in this quiz
                    request.setAttribute("questionNumber", questionNumber);

                    //Mark this question 
                    String marked = request.getParameter("marked");
                    if (marked != null && marked.equalsIgnoreCase("yes")) {
                        questionQHInterface.markQuestion(questionQH);
                    }

                    //send quiz infomation
                    //Number of answered question in quiz
                    int answeredQuestionNumber = quizQHInterface.getAnsweredQuestion(doingQuiz);
                    request.setAttribute("answeredNumber", answeredQuestionNumber);
                    //length of this quiz
                    request.setAttribute("duration", doingQuiz.getQuiz().getQuizDuration());
                    //Next quiz, Previous quiz, Score Exams handle
                    String action = request.getParameter("action");
                    String autoSubmit = request.getParameter("autoSubmit");
                    if (action != null) {
                        //information of recently submit question include questionNumber in this quiz and answer id in database
                        String answerTakenIdRaw = request.getParameter("answerTakenId");
                        String questionTakenNumberRaw = request.getParameter("questionTakenNumber");

                        //set answerId of this question
                        if (answerTakenIdRaw != null && questionTakenNumberRaw != null) {
                            int answerTakenId = Integer.parseInt(answerTakenIdRaw);
                            questionQH.setAnsweredId(answerTakenId);
                        }

                        //prepare for next action
                        //previous question
                        if (action.equalsIgnoreCase("Previous Question")) {
                            response.sendRedirect("quizHandleController?service=quizHandle&quizId=" + quizId + "&questionNumber=" + --questionNumber);

                            //next question    
                        } else if (action.equalsIgnoreCase("Next Question")) {
                            response.sendRedirect("quizHandleController?service=quizHandle&quizId=" + quizId + "&questionNumber=" + ++questionNumber);

                            //score exam
                        } else if ((action.charAt(0) != 'P') && (action.charAt(0) != 'N')
                                && (action.charAt(0) != 'S') && (action.charAt(0) != 'E') && (action.charAt(0) != 'F')) {

                            response.sendRedirect("quizHandleController?service=quizHandle&quizId=" + quizId + "&questionNumber=" + Integer.parseInt(action));
                        } else if (action.equalsIgnoreCase("Finish Exam")) {
                            int time = Integer.parseInt(request.getParameter("time"));
                            doingQuiz.setTime(time);
                            request.setAttribute("totalsecond", time);
                            response.sendRedirect("quizHandleController?service=quizSummary");
                        }
                        request.setAttribute("doingQuiz", doingQuiz);
                    } else if (autoSubmit != null) {
                        String answerTakenIdRaw = request.getParameter("answerTakenId");
                        String questionTakenNumberRaw = request.getParameter("questionTakenNumber");

                        //set answerId of this question
                        if (answerTakenIdRaw != null && questionTakenNumberRaw != null) {
                            int answerTakenId = Integer.parseInt(answerTakenIdRaw);
                            questionQH.setAnsweredId(answerTakenId);
                        }

                        if (autoSubmit.equalsIgnoreCase("yes")) {
                            doingQuiz = (QuizQuizHandle) object;
                            int time = Integer.parseInt(request.getParameter("time"));
                            doingQuiz.setTime(time);
                            session.removeAttribute("doingQuiz");
                            CustomerQuizDAO customerQuizInterface = new CustomerQuizDAOImpl();
                            int latestTakeQuizId = customerQuizInterface.getLastAddedCustomerQuiz().getQuizTakeId();
                            //redirect user to review quiz page  
                            response.sendRedirect("quizHandleController?service=quizReview&quizTakeId=" + latestTakeQuizId + "&questionNumber=1");
                            return;
                        }
                    } else {
                        request.getRequestDispatcher("quizhandle/quizHandle.jsp").forward(request, response);
                    }

                } else {
                    request.setAttribute("errorMess", "Co loi Co loi");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
            /**
             * Service quiz summary: review quiz progress while taking a quiz
             */

            if (service.equalsIgnoreCase("quizSummary")) {
                HttpSession session = request.getSession();
                QuizQuizHandle doingQuiz = null;
                Object object = session.getAttribute("doingQuiz");
                //co roi
                if (object != null) {
                    doingQuiz = (QuizQuizHandle) object;
                    request.setAttribute("doingQuiz", doingQuiz);
                    request.setAttribute("quizType", doingQuiz.getQuiz().getTestTypeId());
                    request.setAttribute("total", doingQuiz.getTime());
                    int answeredQuestionNumber = quizQHInterface.getAnsweredQuestion(doingQuiz);
                    request.setAttribute("answeredNumber", answeredQuestionNumber);
                    request.getRequestDispatcher("quizhandle/quizSummary.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMess", "Co loi Co loi");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }

            //handle submit quiz (manual) 
            if (service.equalsIgnoreCase("submit")) {
                HttpSession session = request.getSession(true);
                QuizQuizHandle doingQuiz = null;
                Object object = session.getAttribute("doingQuiz");
                int latestTakeQuizId = 0;
                if (object != null) {
                    doingQuiz = (QuizQuizHandle) object;
                    int time = Integer.parseInt(request.getParameter("time"));
                    doingQuiz.setTime(time);
                    session.removeAttribute("doingQuiz");
                    CustomerQuizDAO customerQuizInterface = new CustomerQuizDAOImpl();
                    latestTakeQuizId = customerQuizInterface.getLastAddedCustomerQuiz().getQuizTakeId();
                    //if quiz submitted by manual, redirect to the quiz review page  
                    response.sendRedirect("quizHandleController?service=quizReview&quizTakeId=" + latestTakeQuizId + "&questionNumber=1");
                    return;
                } else if (object == null) {
                    request.setAttribute("errorMess", "Co loi Co loi");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }

            }
            /**
             * Service quiz review: review the quiz after taking it
             */
            if (service.equalsIgnoreCase("quizReview")) {
                //prepare quiz information
                int quizTakeId = Integer.parseInt(request.getParameter("quizTakeId"));
                request.setAttribute("quizTakeId", quizTakeId);
                CustomerQuizDAO customerQuizInterface = new CustomerQuizDAOImpl();

                //get Quiz information(right,wrong answer, number of question)
                QuizQuizHandle doingQuiz = quizQHInterface.getReviewQuiz(quizTakeId);
                ArrayList<QuestionQuizHandle> quizReview = doingQuiz.getQuestions();
                request.setAttribute("quizReview", quizReview);
                request.setAttribute("quizSize", quizReview.size());

                //get Quiz result information(score, time)
                CustomerQuiz customerQuiz = customerQuizInterface.getQuizByTakeQuizId(quizTakeId);
                long startedAt = customerQuiz.getSubmitedAt().getTime() - customerQuiz.getTime() * 1000;;
                long submitedAt = customerQuiz.getSubmitedAt().getTime();
                Timestamp submitTime = new Timestamp(submitedAt);
                Timestamp startTime = new Timestamp(startedAt);
                String startedAtTime = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(startTime);
                String submitedAtTime = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(submitTime);
                request.setAttribute("submitedAt", submitedAtTime);
                request.setAttribute("startedAt", startedAtTime);
                request.setAttribute("score", customerQuiz.getScore());

                int questionNumber;
                if (request.getParameter("questionNumber") == null) {
                    questionNumber = DEFAULT_PAGE;
                } else {
                    questionNumber = Integer.parseInt(request.getParameter("questionNumber"));
                }
                QuestionQuizHandle questionQH = doingQuiz.getQuestionByNumber(questionNumber);
                String media = questionQH.getQuestion().getMedia();
                if (media != null) {
                    int mediaType = VIDEO_MEDIA_TYPE;
                    String[] imageExtensions = {".jpg", ".gif", ".jpeg", ".jfif", ".pjpeg", ".png", ".pjps"};
                    for (String extension : imageExtensions) {
                        if (media.contains(extension)) {
                            mediaType = IMAGE_MEDIA_TYPE;
                        }
                    }
                    request.setAttribute("mediaType", mediaType);
                }
                //send being reviewing question's information
                request.setAttribute("answered", questionQH.getAnsweredId());
                request.setAttribute("questionQH", questionQH);
                String questionContent = questionQH.getQuestion().getContent();
                request.setAttribute("questionContent", questionContent);
                //answer List of question
                ArrayList<Answer> answerList = questionQH.getAnswerList();
                request.setAttribute("answerList", answerList);
                //true answer of question
                Answer trueAnswer = questionQHInterface.getRightAnswer(questionQH);
                request.setAttribute("trueAnswer", trueAnswer.getAnswerContent());
                //number of question in this quiz
                request.setAttribute("questionNumber", questionNumber);
                //question id in database
                request.setAttribute("questionId", questionQH.getQuestion()
                        .getQuestionId());
                //explanation of this question
                request.setAttribute("explanation", questionQH.getQuestion()
                        .getExplanation());

                String action = request.getParameter("action");
                if (action != null) {
                    //prepare for next action
                    //previous question
                    if (action.equalsIgnoreCase("Previous Question")) {
                        response.sendRedirect("quizHandleController?service=quizReview&quizTakeId=" + quizTakeId + "&questionNumber=" + --questionNumber);

                        //next question    
                    } else if (action.equalsIgnoreCase("Next Question")) {
                        response.sendRedirect("quizHandleController?service=quizReview&quizTakeId=" + quizTakeId + "&questionNumber=" + ++questionNumber);

                        //score exam
                    } else if ((action.charAt(0) != 'P') && (action.charAt(0) != 'N')
                            && (action.charAt(0) != 'S')) {

                        response.sendRedirect("quizHandleController?service=quizReview&quizTakeId=" + quizTakeId + "&questionNumber=" + Integer.parseInt(action));
                    } else if (action.equalsIgnoreCase("Finish Review")) {
                        response.sendRedirect("homeController");
                    }
                } else {
                    request.getRequestDispatcher("quizhandle/quizReview.jsp").forward(request, response);
                }
            }

        } catch (Exception ex) {
            Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMess", ex.toString());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
