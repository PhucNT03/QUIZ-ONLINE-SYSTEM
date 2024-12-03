/**
 *  Copyright(C) 2021, Group Tree - SWP391, SE1509, FA21
 *  Created on : Sep 23, 2021
 *  PricePackageDAO Interface
 *  Quiz practicing system
 *
 *  Record of change:
 *  Date        Version     Author              Description
 *  23/9/21     1.0         ChucNVHE150618      First Deploy
 *  18/10/21    1.0         NamDHHE150519       Add comment
*/
package dao;

import bean.PricePackage;
import java.util.ArrayList;

/**
 * Lớp này chứa các interface của PricePackageDAOImpl
 *
 * @author NamDH
 */
public interface PricePackageDAO {
    /**
     * get all price package where status = 1
     * @return
     * @throws Exception 
     */
    public ArrayList<PricePackage> getAllPricePackage() throws Exception;
    
    /**
     * get all price package by subjectId
     * @param subjectId
     * @return
     * @throws Exception 
     */
    public ArrayList<PricePackage> getAllPricePackagesBySubject(int subjectId) throws Exception;
    
    /**
     * get price package by packageId
     * @param packId
     * @return
     * @throws Exception 
     */
    public PricePackage getPricePackageById(int ppId) throws Exception;
    
    /**
     * 
     * @param newPricePackage
     * @return
     * @throws Exception 
     */
    public int addPricePackage(PricePackage newPricePackage) throws Exception;
    
    /**
     * 
     * @param updatedPricePackage
     * @return
     * @throws Exception 
     */
    public int updatePricePackage(PricePackage updatedPricePackage) throws Exception;
    
    /**
     * delete price package with package Id
     * @param ppId
     * @return
     * @throws Exception 
     */
    public int deletePricePackage(int ppId) throws Exception;
}
