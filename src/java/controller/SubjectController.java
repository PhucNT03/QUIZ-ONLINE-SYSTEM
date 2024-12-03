/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import bean.Dimension;
import bean.DimensionType;
import bean.PricePackage;
import bean.Quiz;
import bean.Subject;
import bean.SubjectCate;
import bean.User;
import bean.UserRole;
import dao.DimensionDAO;
import dao.DimensionTypeDAO;
import dao.PricePackageDAO;
import dao.QuizDAO;
import dao.RegistrationDAO;
import dao.SubjectCateDAO;
import dao.impl.SubjectDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.SubjectDAO;
import dao.impl.DimensionDAOImpl;
import dao.impl.DimensionTypeDAOImpl;
import dao.impl.PricePackageDAOImpl;
import dao.impl.QuizDAOImpl;
import dao.impl.RegistrationDAOImpl;
import dao.impl.SubjectCateDAOImpl;

public class SubjectController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* Get service and initialise the subjectDAO */
            String service = request.getParameter("service");
            SubjectDAO subjectDAO = new SubjectDAOImpl();
            SubjectCateDAO subjectCateDAO = new SubjectCateDAOImpl();
            DimensionTypeDAO dimensionTypeDAO = new DimensionTypeDAOImpl();
            DimensionDAO dimensionDAO = new DimensionDAOImpl();
            PricePackageDAO pricePackageDAO = new PricePackageDAOImpl();
            RegistrationDAO registrationDAO = new RegistrationDAOImpl();
            QuizDAO quizDAO = new QuizDAOImpl();
            if (service.equalsIgnoreCase("addDimension")) {
                /* Get user and role on session scope */
                User currUser = (User) request.getSession().getAttribute("currUser");
                UserRole currRole = (UserRole) request.getSession().getAttribute("role");
                /* If user is not logged in, or not admin/expert, redirect to index */
                if ((currUser == null) || (currRole == null)
                        || ((!currRole.getUserRoleName().equalsIgnoreCase("admin"))
                        && (!currRole.getUserRoleName().equalsIgnoreCase("expert")))) {
                    sendDispatcher(request, response, "error.jsp");
                } else {
                    int subjectId = Integer.parseInt(request.getParameter("subjectId").trim());
                    String message = "";
                    String color = "red";
                    /* Get parameters from jsp */
                    int dimensionTypeId = Integer.parseInt(request.getParameter("dimensionType").trim());
                    String dimensionName = request.getParameter("dimensionName").trim();
                    String description = request.getParameter("description").trim();
                    /* Check boundaries */
                    if (dimensionName == null || dimensionName.length() == 0) {
                        message = "Dimension Name can not be empty";
                    } else if (dimensionName.length() > 255) {
                        message = "Dimension Name is too long";
                    } else if (description.length() > 511) {
                        message = "Dimension Description is too long";
                    } else {
                        /* Add new subject dimension */
                        Dimension updateDimension = new Dimension(0, subjectId, dimensionTypeId, "", dimensionName, description, true);
                        int check = dimensionDAO.addDimension(updateDimension);
                        if (check > 0) {
                            color = "green";
                            message = "Add dimension successfully.";
                        } else {
                            message = "Add dimension failed.";
                        }
                    }

                    /* Get the needed lists and redirect to the courseContentJsp */
                    Subject courseContent = subjectDAO.getSubjectbyId(subjectId);
                    request.setAttribute("subject", courseContent);
                    ArrayList<SubjectCate> categoryList = subjectCateDAO.getSubjectCateBySubject(subjectId);
                    request.setAttribute("categoryList", categoryList);
                    ArrayList<SubjectCate> categoryRemainList = subjectCateDAO.getRemainSubjectCateBySubject(subjectId);
                    request.setAttribute("categoryRemainList", categoryRemainList);
                    ArrayList<DimensionType> dimensionTypes = dimensionTypeDAO.getAllDimensionTypes();
                    request.setAttribute("dimensionTypes", dimensionTypes);
                    request.setAttribute("dimensionColor", color);
                    request.setAttribute("dimensionMessage", message);
                    request.setAttribute("displayTab", "dimension");
                    sendDispatcher(request, response, "jsp/courseContentDetail.jsp");
                }
            }

            /**
             * Service subject : subject detail
             */
            if (service.equalsIgnoreCase("subjectDetail")) {
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                Subject subject = subjectDAO.getSubjectbyId(subjectId);
                request.setAttribute("subject", subject);
                ArrayList<PricePackage> pricePackage = pricePackageDAO.getAllPricePackagesBySubject(subjectId);
                ArrayList<Quiz> quizBySubject = quizDAO.getQuizBySubject(subjectId);
                request.setAttribute("pricePackage", pricePackage);
                request.setAttribute("quizs", quizBySubject);
                request.getRequestDispatcher("jsp/subjectDetail.jsp").forward(request, response);
            }
            /**
             * Service subject : add subject
             */
            if (service.equalsIgnoreCase("addSubject")) {
                /* Get user and role on session scope */
                User currUser = (User) request.getSession().getAttribute("currUser");
                UserRole currRole = (UserRole) request.getSession().getAttribute("role");
                /* If user is not logged in, or not admin/expert, redirect to index */
                if ((currUser == null) || (currRole == null)
                        || ((!currRole.getUserRoleName().equalsIgnoreCase("admin"))
                        && (!currRole.getUserRoleName().equalsIgnoreCase("expert")))) {
                    sendDispatcher(request, response, "error.jsp");
                } else {
                    int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                    Subject subject = subjectDAO.getSubjectbyId(subjectId);
//                    ArrayList<SubjectCate> categoryList = subjectCateDAO.getSubjectCateBySubject(subjectId);
//                    request.setAttribute("categoryList", categoryList);
                    request.getRequestDispatcher("jsp/addSubject.jsp").forward(request, response);
                }
            }
            /**
             * Service subject : My Registration
             */
            if (service.equalsIgnoreCase("myRegistration")) {
                /* Get user and role on session scope */
                User currUser = (User) request.getSession().getAttribute("currUser");
                UserRole currRole = (UserRole) request.getSession().getAttribute("role");
                /* If user is not logged in, redirect to index */
                if ((currUser == null) || (currRole == null)) {
                    sendDispatcher(request, response, "index.jsp");
                } else {
                    ArrayList<Subject> registrationList = registrationDAO.getRegistedSubjectbyUserId(currUser.getUserId());
                    request.setAttribute("registrationList", registrationList);

                    request.getRequestDispatcher("jsp/myRegistration.jsp").forward(request, response);

                }
            }
        } catch (Exception ex) {
            Logger.getLogger(SubjectController.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMess", ex.toString());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    /* Forward the request to the destination, catch any unexpected exceptions and log it */
    public void sendDispatcher(HttpServletRequest request, HttpServletResponse response, String path) {
        try {
            RequestDispatcher rd = request.getRequestDispatcher(path);
            rd.forward(request, response);

        } catch (ServletException | IOException ex) {
            Logger.getLogger(SubjectController.class
                    .getName()).log(Level.SEVERE, null, ex);
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
