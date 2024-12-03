
package controller;

import bean.Registration;
import bean.RegistrationManage;
import bean.Subject;
import bean.User;
import bean.UserRole;
import dao.RegistrationDAO;
import dao.SubjectDAO;
import dao.UserDAO;
import dao.impl.RegistrationDAOImpl;
import dao.impl.SubjectDAOImpl;
import dao.impl.UserDAOImpl;
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


public class RegistrationController extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("service");
            RegistrationDAO registrationInterface = new RegistrationDAOImpl();
            UserDAO userDAO = new UserDAOImpl();
            SubjectDAO subjectDAO = new SubjectDAOImpl();
            /**
             * Service: get Filter Information
             */
            if (service.equalsIgnoreCase("getFilterInformation")) {
                String message = (String) request.getAttribute("message");
                ArrayList<Subject> listSubject = subjectDAO.getAllSubjects();
                request.setAttribute("listFilterSubject", listSubject);
                ArrayList<User> listUser = userDAO.getUserAllUser();
                request.setAttribute("listFilterUser", listUser);
                request.getRequestDispatcher("jsp/registrationList.jsp").forward(request, response);
                if (message != null) {
                    request.setAttribute("message", message);
                }
            }
            /**
             * Service: get Registration Information Detail
             */
            if (service.equalsIgnoreCase("getInformationDetail")) {
                String message = (String) request.getAttribute("message");
                ArrayList<User> listUser = userDAO.getUserAllUser();
                request.setAttribute("listUser", listUser);
                request.getRequestDispatcher("jsp/registrationDetail.jsp").forward(request, response);
                if (message != null) {
                    request.setAttribute("message", message);
                }
            }

            /**
             * Service: filter Registration by subjectId, userId
             */
            if (service.equalsIgnoreCase("filterRegistration")) {
                /* Get user and role on session scope */
                User currUser = (User) request.getSession().getAttribute("currUser");
                UserRole currRole = (UserRole) request.getSession().getAttribute("role");
                /* If user is not logged in, or not admin/expert, redirect to index */
                if ((currUser == null) || (currRole == null)
                        || ((!currRole.getUserRoleName().equalsIgnoreCase("admin"))
                        && (!currRole.getUserRoleName().equalsIgnoreCase("sale")))) {
                    sendDispatcher(request, response, "error.jsp");
                } else {
                    int subjectId = Integer.parseInt(request.getParameter("subjectId"));
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    ArrayList<Subject> listSubject = subjectDAO.getAllSubjects();
                    request.setAttribute("listFilterSubject", listSubject);
                    ArrayList<User> listUser = userDAO.getUserAllUser();
                    request.setAttribute("listFilterUser", listUser);
                    ArrayList<RegistrationManage> listRegistrationManage = registrationInterface.getFilterRegistration(subjectId, userId);
                    request.setAttribute("listRegistrationManage", listRegistrationManage);
                    request.getRequestDispatcher("jsp/registrationList.jsp").forward(request, response);
                }
            }

            /**
             * Service: add new registration
             */
            if (service.equalsIgnoreCase("addRegistration")) {
                /* Get user and role on session scope */
                User currUser = (User) request.getSession().getAttribute("currUser");
                UserRole currRole = (UserRole) request.getSession().getAttribute("role");
                /* If user is not logged in, or not admin/expert, redirect to index */
                if ((currUser == null) || (currRole == null)
                        || ((!currRole.getUserRoleName().equalsIgnoreCase("admin"))
                        && (!currRole.getUserRoleName().equalsIgnoreCase("sale")))) {
                    sendDispatcher(request, response, "error.jsp");
                } else {
                    String message = "";
                    /* Get parameters from jsp */
                    int userId = Integer.parseInt(request.getParameter("userId").trim());
                    int lastUpdateBy = currUser.getUserId();
                    String note = null;
                    if (request.getParameter("note") == null) {
                        note = "";
                    } else {
                        note = note.trim();
                    }
                    boolean status = request.getParameter("status").equals("1");
                    /* Check boundaries */
                    if (userId == 0) {
                        message = "User can not be empty";
                    } else {
                        /* Add new registration */
                        Registration updateRegistration = new Registration(0, userId, null, lastUpdateBy, note, status);
                        int check = registrationInterface.addRegistration(updateRegistration);
                        if (check > 0) {
                            message = "Add registration successfully.";
                        } else {
                            message = "Add registration failed.";
                        }
                    }

                    /* Get the needed lists and redirect to the courseContentJsp */
                    ArrayList<User> listUser = userDAO.getUserAllUser();
                    request.setAttribute("listUser", listUser);
                    request.setAttribute("message", message);
                    sendDispatcher(request, response, "jsp/registrationList.jsp");
                }
            }

            /**
             * Service: get update registration information
             */
            if (service.equalsIgnoreCase("updateRegistration")) {
                /* Get user and role on session scope */
                User currUser = (User) request.getSession().getAttribute("currUser");
                UserRole currRole = (UserRole) request.getSession().getAttribute("role");
                /* If user is not logged in, or not admin/expert, redirect to index */
                if ((currUser == null) || (currRole == null)
                        || ((!currRole.getUserRoleName().equalsIgnoreCase("admin"))
                        )) {
                    sendDispatcher(request, response, "error.jsp");
                } else {
                    int registrationId = Integer.parseInt(request.getParameter("registrationId"));
                    String type = request.getParameter("type");
                    if (type.equalsIgnoreCase("update")) {
                        Registration updateRegistration = registrationInterface.getRegistrationById(registrationId);
                        User user = userDAO.getUserById(updateRegistration.getUserId());
                        request.setAttribute("user", user);
                        request.setAttribute("updateRegistration", updateRegistration);
                        request.getRequestDispatcher("jsp/updateRegistration.jsp").forward(request, response);
                    }

                }
            }

            /**
             * Service: update registration information
             */
            if (service.equalsIgnoreCase("updateRegistrationInformation")) {
                /* Get user and role on session scope */
                User currUser = (User) request.getSession().getAttribute("currUser");
                UserRole currRole = (UserRole) request.getSession().getAttribute("role");
                /* If user is not logged in, or not admin/expert, redirect to index */
                if ((currUser == null) || (currRole == null)
                        || ((!currRole.getUserRoleName().equalsIgnoreCase("admin"))
                       )) {
                    sendDispatcher(request, response, "error.jsp");
                } else {
                    int updateRegId = Integer.parseInt(request.getParameter("updateRegId"));
                    boolean status = request.getParameter("status").equals("1");
                    String note = (String) request.getParameter("note").trim();
                    int lastUpdateBy = currUser.getUserId();
                    String message = "";
                    String color = "red";
                    Registration updatedRegistration = registrationInterface.getRegistrationById(updateRegId);
                    if (note == null) {
                        note = "";
                    }
                    /* Perform the updates on subject lesson */
                    updatedRegistration.setNote(note);
                    updatedRegistration.setLastUpdatedBy(lastUpdateBy);
                    updatedRegistration.setStatus(status);
                    registrationInterface.editRegistration(updatedRegistration.getRegId(), updatedRegistration);
                    Registration updateRegistration = registrationInterface.getRegistrationById(updatedRegistration.getRegId());
                    request.setAttribute("updateRegistration", updateRegistration);
                    request.setAttribute("message", "Update successfully!!");
                    request.getRequestDispatcher("registrationController?service=getFilterInformation")
                            .forward(request, response);

                }
            }
        } catch (Exception ex) {
            Logger.getLogger(RegistrationController.class.getName()).log(Level.SEVERE, null, ex);
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
