package com.ensode.nbbook.controller;

import java.sql.SQLException;
import java.util.ArrayList;

public class Assortment {

    private int CategoryId;
    private String CategoryName;
    private ArrayList<Assortment> AssortmentList;

    public Assortment() {

    }

    public ArrayList<Assortment> getAssortment() {

        ArrayList<Assortment> ResultList = new ArrayList<Assortment>();
        Database database = new Database();
        try {
            ResultList = database.ExecuteQuert("SELECT top 7 CategoryID, CategoryName FROM dbo.test");

        } catch (SQLException e) {
            System.out.println(e.toString());
            e.printStackTrace();
        }
        return ResultList;
    }

    /**
     *
     * @return
     */
    public int getCategoryId() {
        return CategoryId;
    }

    /**
     *
     * @param CategoryId
     */
    public void setCategoryId(int categoryId) {
        this.CategoryId = categoryId;
    }

    /**
     *
     * @return
     */
    public ArrayList<Assortment> getAssortmentList() {
        return AssortmentList;
    }

    /**
     *
     */
    public void setAssortmentList() {
        this.AssortmentList = getAssortment();
    }

    /**
     *
     * @return
     */
    public String getCategoryName() {
        return CategoryName;
    }

    /**
     *
     * @param CategoryName
     */
    public void setCategoryName(String categoryName) {
        this.CategoryName = categoryName;
    }

}
