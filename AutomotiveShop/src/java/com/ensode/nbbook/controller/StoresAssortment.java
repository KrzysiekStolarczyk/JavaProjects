package com.ensode.nbbook.controller;

import java.sql.SQLException;
import java.util.ArrayList;

public class StoresAssortment {

    private int Id;
    private String ProductName;
    private String ImagePath;
    private float Price;
    private int Stock;
    private ArrayList<StoresAssortment> StoresAssortmentList;

    
     public String getImagePath() {
        return ImagePath;
    }

    public void setImagePath(String imagePath) {
        this.ImagePath = imagePath;
    }
    
    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String productName) {
        this.ProductName = productName;
    }

    public float getPrice() {
        return Price;
    }

    public void setPrice(float price) {
        this.Price = price;
    }

    public int getStock() {
        return Stock;
    }

    public void setStock(int stock) {
        this.Stock = stock;
    }

    public StoresAssortment() {

    }

    public ArrayList<StoresAssortment> getStoresAssortment() {

        ArrayList<StoresAssortment> ResultList = new ArrayList<StoresAssortment>();
        Database database = new Database();
        try {
//            ResultList = database.ExecuteQuert("SELECT top 7 CategoryID, CategoryName FROM dbo.test");
            ResultList = database.ExecuteQuert("SELECT [id],[ProductName],[Price],[Stock], [ImagePath] FROM [JSP].[dbo].[Assortment]");

        } catch (SQLException e) {
            System.out.println(e.toString());
            e.printStackTrace();
        }
        return ResultList;
    }

    public ArrayList<StoresAssortment> getStoresAssortmentList() {
        return StoresAssortmentList;
    }

    public void setStoresAssortmentList() {
        this.StoresAssortmentList = getStoresAssortment();
    }

}
