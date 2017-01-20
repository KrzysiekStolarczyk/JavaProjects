package com.ensode.nbbook.controller;

import java.sql.SQLException;
import java.util.ArrayList;

public class Filterss {

    private String Category;
    private int PriceFrom;
    private int PriceTo;
    private String SearchString;
    private boolean CheckedPrice;
    private boolean CheckedCategory;
    private boolean CheckedSearchString;

    public boolean isCheckedPrice() {
        return CheckedPrice;
    }

    public void setCheckedPrice(boolean checkedPrice) {
        this.CheckedPrice = checkedPrice;
    }

    public boolean isCheckedCategory() {
        return CheckedCategory;
    }

    public void setCheckedCategory(boolean checkedCategory) {
        this.CheckedCategory = checkedCategory;
    }

    public boolean isCheckedSearchString() {
        return CheckedSearchString;
    }

    public void setCheckedSearchString(boolean checkedSearchString) {
        this.CheckedSearchString = checkedSearchString;
    }

    public String getCategory() {
        return Category;
    }

    public void setCategory(String category) {
        this.Category = category;
    }

    public int getPriceFrom() {
        return PriceFrom;
    }

    public void setPriceFrom(int priceFrom) {
        this.PriceFrom = priceFrom;
    }

    public int getPriceTo() {
        return PriceTo;
    }

    public void setPriceTo(int priceTo) {
        this.PriceTo = priceTo;
    }

    public String getSearchString() {
        return SearchString;
    }

    public void setSearchString(String searchString) {
        this.SearchString = searchString;
    }
 
    
   

}
