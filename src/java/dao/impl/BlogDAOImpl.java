package dao.impl;

import bean.Blog;
import bean.User;
import dao.BlogDAO;
import dao.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BlogDAOImpl extends DBConnection implements BlogDAO {

    /**
     * get blog's author
     *
     * @param blogId blog target. It is a <code>int</code> object
     * @return blog's author. It is a <code>User</code> object
     * @throws java.lang.Exception
     */
    @Override
    public User getAuthor(int blogId) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;/* Prepared statement for executing sql queries */

        String sql = "SELECT b.userId,b.userName,b.password,b.roleId,b.profilePic,b.userMail,b.gender,b.userMobile,b.status "
                + "FROM Blog as a right join [User] as b on a.author=b.userId WHERE a.blogId=" + blogId;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("password"),
                        rs.getInt("roleId"),
                        rs.getString("profilePic"),
                        rs.getString("userMail"),
                        rs.getBoolean("gender"),
                        rs.getString("userMobile"),
                        rs.getBoolean("status"));
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    /**
     * Get all blog from database
     *
     * @return a list of <code>Blog</code> objects. It is a
     * <code>java.util.ArrayList</code> object
     * @throws java.lang.Exception
     */
    @Override
    public ArrayList<Blog> getAllBlog() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;/* Prepared statement for executing sql queries */

        ArrayList<Blog> allBlog = new ArrayList();
        String sql = "SELECT * FROM [Blog] ORDER BY created DESC";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                BlogDAOImpl blogDAO = new BlogDAOImpl();
                User author = blogDAO.getAuthor(rs.getInt("blogId"));
                allBlog.add(new Blog(rs.getInt("blogId"),
                        rs.getString("blogTitle"),
                        rs.getDate("created"),
                        rs.getDate("lastEdited"),
                        author,
                        rs.getString("detail"),
                        rs.getString("thumbnail"),
                        rs.getBoolean("status")));
            }
            return allBlog;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

}
