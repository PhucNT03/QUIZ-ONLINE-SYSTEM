package dao;

import bean.Slider;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của SliderDAOImpl
 *
 * @author NamDH
 */
public interface SliderDAO {

    /**
     * get all slider in database
     *
     * @return <code>ArrayList<Slider><code> object
     * @throws java.lang.Exception
     */
    public ArrayList<Slider> getSlider() throws Exception;

}
