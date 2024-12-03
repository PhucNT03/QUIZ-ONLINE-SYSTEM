package controller;

import bean.Quiz;
import bean.Subject;
import bean.User;
import bean.CustomerQuiz;
import bean.Dimension;
import bean.Question;
import dao.QuestionDAO;
import dao.SubjectDAO;
import dao.impl.QuestionDAOImpl;
import dao.impl.SubjectDAOImpl;
import bean.QuizQuizHandle;
import dao.CustomerQuizDAO;
import dao.DimensionDAO;
import dao.QuizDAO;
import dao.RegistrationDAO;
import dao.impl.CustomerQuizDAOImpl;
import dao.impl.DimensionDAOImpl;
import dao.impl.QuizDAOImpl;
import dao.impl.RegistrationDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class PracticeController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           
            String service = request.getParameter("service");

            //Get information to display in the practiceList
            if (service.equalsIgnoreCase("getPracticeListInformation")) {
                User currUser = (User) request.getSession().getAttribute("currUser");
                RegistrationDAO registrationDAO = new RegistrationDAOImpl();
                CustomerQuizDAO customerQuizDAO = new CustomerQuizDAOImpl();
                QuizDAO quizDAO = new QuizDAOImpl();
                ArrayList<Subject> registedSubject = registrationDAO.getRegistedSubject(currUser.getUserId());
                ArrayList<CustomerQuiz> customerQuizs = customerQuizDAO.getQuizByUser(currUser.getUserId());
                request.setAttribute("registedSubject", registedSubject);
                request.setAttribute("customerQuizs", customerQuizs);

                Object object = request.getSession().getAttribute("doingQuiz");
                if (object != null) {
                    QuizQuizHandle doingQuiz = (QuizQuizHandle) object;
                    Quiz doingQuizInfo = quizDAO.getQuizById(doingQuiz.getQuiz().getQuizId());
                    request.setAttribute("doingQuiz", doingQuizInfo);
                }

                request.getRequestDispatcher("jsp/practiceList.jsp").forward(request, response);
            }
            
            if (service.equalsIgnoreCase("getPracticeDetail")) {
                User currUser = (User) request.getSession().getAttribute("currUser");
                RegistrationDAO registrationDAO = new RegistrationDAOImpl();
                DimensionDAO dimensionDAO = new DimensionDAOImpl();
                //Get all subject that user have registed
                ArrayList<Subject> registedSubject = registrationDAO.getRegistedSubject(currUser.getUserId());
                ArrayList<Dimension> dimension = dimensionDAO.getAllDimension();
                request.getSession().setAttribute("registedSubject", registedSubject);
                request.getSession().setAttribute("dimensionTypes", dimension);
                request.getRequestDispatcher("jsp/practiceDetail.jsp").forward(request, response);
            }            
             //create quiz that meet user's requirement
            if (service.equalsIgnoreCase("createPractice")) {
                //Get user's input values
                int subjectId = Integer.parseInt(request.getParameter("subject"));
                int numberOfQuestion = Integer.parseInt(request.getParameter("numberOfQuestion"));
                int dimensionId = Integer.parseInt(request.getParameter("dimension"));
                int duration = Integer.parseInt(request.getParameter("duration"));
                QuestionDAO questionDAO = new QuestionDAOImpl();
                QuizDAO quizDAO = new QuizDAOImpl();
                SubjectDAO subjectDAO = new SubjectDAOImpl();
                //select question that meet user requirement
                ArrayList<Question> questionList = questionDAO.getQuestionForCreateQuiz(numberOfQuestion, subjectId, dimensionId);

                // if there isn't any question meet user requirement then display message
                if (questionList.size() == 0) {
                    String mess = "There isn't any question that meet your require!";
                    request.setAttribute("message", mess);
                    request.getRequestDispatcher("jsp/practiceDetail.jsp").forward(request, response);
                    return;
                }

                //setup quiz information to create new ppractice
                Quiz quiz = new Quiz();
                Subject subject = subjectDAO.getSubjectbyId(subjectId);
                quiz.setQuizName("Practice Quiz");
                quiz.setSubject(subject);
                quiz.setQuizDuration(duration * 60);
                quiz.setTestTypeId(3);
                quiz.setNumberQuestion(questionList.size());
                quiz.setDimensionTypeId(dimensionId);
                quiz.setStatus(true);
                quizDAO.addQuiz(quiz);// add practice
                // add practice questions
                Quiz practice = quizDAO.getQuizById(quizDAO.getQuizIdCreated(quiz));
                for (Question question : questionList) {
                    quizDAO.addQuizQuestion(practice.getQuizId(), question.getQuestionId());
                }
                response.sendRedirect("quizHandleController?service=quizEntrance&quizId=" + practice.getQuizId());
            }

        } catch (Exception ex) {
            Logger.getLogger(PracticeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    
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
