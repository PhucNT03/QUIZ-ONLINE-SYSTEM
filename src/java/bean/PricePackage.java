/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bean;

/**
 * PricePackage entity
 *
 * @author admin
 */
public class PricePackage {
    private int packId; /*Price package id*/
    private String packName; /*Price package name*/
    private int subjectId; /*Subject Id*/
    private int duration; /*Price package duration (months)*/
    private float listPrice; /*Price package original price*/
    private float salePrice; /*Price package sale price*/
    private boolean status; /*Price package status*/

    /**
     * Blank constructor
     */
    public PricePackage() {
    }

    /**
     * Complete constructor
     * @param packId
     * @param packName
     * @param subjectId
     * @param duration
     * @param listPrice
     * @param salePrice
     * @param status 
     */
    public PricePackage(int packId, String packName, int subjectId, int duration, float listPrice, float salePrice, boolean status) {
        this.packId = packId;
        this.packName = packName;
        this.subjectId = subjectId;
        this.duration = duration;
        this.listPrice = listPrice;
        this.salePrice = salePrice;
        this.status = status;
    }

    /**
     * Get price package id
     * @return 
     */
    public int getPackId() {
        return packId;
    }

    /**
     * Set price package id
     * @param packId 
     */
    public void setPackId(int packId) {
        this.packId = packId;
    }

    /**
     * Get price package name
     * @return 
     */
    public String getPackName() {
        return packName;
    }

    /**
     * Set price package name
     * @param packName 
     */
    public void setPackName(String packName) {
        this.packName = packName;
    }

    /**
     * Get subject id
     * @return 
     */
    public int getSubjectId() {
        return subjectId;
    }

    /**
     * Set subject Id
     * @param subjectId 
     */
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    /**
     * Get price package duration
     * @return 
     */
    public int getDuration() {
        return duration;
    }

    /**
     * Set price package duration
     * @param duration 
     */
    public void setDuration(int duration) {
        this.duration = duration;
    }

    /**
     * Get price package original price
     * @return 
     */
    public float getListPrice() {
        return listPrice;
    }

    /**
     * Set price package original price
     * @param listPrice 
     */
    public void setListPrice(float listPrice) {
        this.listPrice = listPrice;
    }

    /**
     * Get price package sale price
     * @return 
     */
    public float getSalePrice() {
        return salePrice;
    }

    /**
     * Set price package sale price
     * @param salePrice 
     */
    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    /**
     * Get price package status
     * @return 
     */
    public boolean isStatus() {
        return status;
    }

    /**
     * Set price package status
     * @param status 
     */
    public void setStatus(boolean status) {
        this.status = status;
    }
}
