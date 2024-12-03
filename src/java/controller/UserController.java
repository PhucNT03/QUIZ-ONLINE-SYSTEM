
package controller;

import bean.*;
import dao.impl.UserDAOImpl;
import dao.impl.UserRoleDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.UserDAO;
import dao.UserRoleDAO;

public class UserController extends HttpServlet {

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
            String service = request.getParameter("service");
            UserDAO userInterface = new UserDAOImpl();
            /*Log in*/
            if (service.equalsIgnoreCase("login")) {
                String userMail = request.getParameter("userMail");
                String mess = "";
                String password = request.getParameter("password");
                User log = null;

                UserRoleDAO userRoleDAO = new UserRoleDAOImpl();

                log = userInterface.getUserLogin(userMail, password);
                //validate user log in, if wrong, re-login
                if (log == null) {
                    mess = "Sorry, username and/or password are/is invalid!";
                    request.setAttribute("mess", mess);
                    sendDispatcher(request, response, "login/login.jsp");
                    return;
                    //if loged in, get user role and forward to homepage with their role    
                } else {
                    request.getSession().setAttribute("currUser", log);
                }
                out.print(mess);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            /* Log out */
            if (service.equalsIgnoreCase("logout")) {
                request.getSession().removeAttribute("currUser");
                sendDispatcher(request, response, "index.jsp");
            }

        } catch (Exception ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMess", ex.toString());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    public void sendDispatcher(HttpServletRequest request, HttpServletResponse response, String path) {
        try {
            RequestDispatcher rd = request.getRequestDispatcher(path);
            rd.forward(request, response);

        } catch (ServletException | IOException ex) {
            Logger.getLogger(UserController.class
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
