package dao;

import bean.Blog;
import bean.User;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của BlogDAOImpl
 *
 */
public interface BlogDAO {
     
    /**
     * get blog's author
     *
     * @param blogId blog target. It is a <code>int</code> object
     * @return blog's author. It is a <code>User</code> object
     * @throws java.lang.Exception
     */
    public User getAuthor(int blogId) throws Exception;
    /**
     * Get all blog from database
     *
     * @return a list of <code>Blog</code> objects. It is a
     * <code>java.util.ArrayList</code> object
     * @throws java.lang.Exception
     */
    public ArrayList<Blog> getAllBlog() throws Exception;
}
