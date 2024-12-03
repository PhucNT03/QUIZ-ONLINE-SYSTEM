
package bean;

/**
 *  Hold the data of the user entity
 */
public class User {
    private int userId; /*User ID*/
    private String userName; /*User Name*/
    private String password; /*User password*/
    private int roleId; /*User Role ID*/
    private String profilePic; /*User profile picture*/
    private String  userMail; /*User Mail*/
    private boolean gender; /*User gender*/
    private String userMobile; /*User mobile*/
    private boolean status; /*User status*/
    private UserRole userRole; /*User Role Entity*/

    /**
     * Blank constructor
     */
    public User() {
    }

    /**
     * Complete constructor
     * @param userId
     * @param userName
     * @param password
     * @param roleId
     * @param profilePic
     * @param userMail
     * @param gender
     * @param userMobile
     * @param status 
     */
    public User(int userId, String userName, String password, int roleId, String profilePic, String userMail, boolean gender, String userMobile, boolean status) {
        this.userId = userId;
        this.userName = userName;
        this.password = password;
        this.roleId = roleId;
        this.profilePic = profilePic;
        this.userMail = userMail;
        this.gender = gender;
        this.userMobile = userMobile;
        this.status = status;
    }

    /**
     * Get userId
     * @return 
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Set userId
     * @param userId 
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * Get roleID
     * @return 
     */
    public int getRoleId() {
        return roleId;
    }

    /**
     * Set roleId
     * @param roleId 
     */
    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    /**
     * Get user gender
     * @return 
     */
    public boolean isGender() {
        return gender;
    }

    /**
     * Set user gender
     * @param gender 
     */
    public void setGender(boolean gender) {
        this.gender = gender;
    }

    /**
     * Get user status
     * @return 
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set user status
     * @param status 
     */
    public void setStatus(boolean status) {
        this.status = status;
    }

    /**
     * Get user name
     * @return 
     */
    public String getUserName() {
        return userName;
    }

    /**
     * Set userName
     * @param userName 
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * Get user Password
     * @return 
     */
    public String getPassword() {
        return password;
    }

    /**
     * Set user Password
     * @param password 
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Get user profile picture
     * @return 
     */
    public String getProfilePic() {
        return profilePic;
    }

    /**
     * Set profile picture
     * @param profilePic 
     */
    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    /**
     * Get user Mail
     * @return 
     */
    public String getUserMail() {
        return userMail;
    }

    /**
     * Set user mail
     * @param userMail 
     */
    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    /**
     * Get user mobile
     * @return 
     */
    public String getUserMobile() {
        return userMobile;
    }

    /**
     * Set user mobile
     * @param userMobile 
     */
    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    /**
     * Get user role
     * @return User role entity
     */
    public UserRole getUserRole() {
        return userRole;
    }

    /**
     * Set user Role entity
     * @param userRole 
     */
    public void setUserRole(UserRole userRole) {
        this.userRole = userRole;
    }
    
    
}
