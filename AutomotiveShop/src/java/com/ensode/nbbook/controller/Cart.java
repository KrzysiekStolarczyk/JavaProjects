package com.ensode.nbbook.controller;

import java.util.ArrayList;

public class Cart {

    private int idProduct;
    private String ProductName;
    private String ProductImagePath;
    private float PriceProduct;
    private int QuntityProducts;
    private float SumCost;
    private ArrayList<Cart> CartList;

    public String getProductImagePath() {
        return ProductImagePath;
    }

    public void setProductImagePath(String productImagePath) {
        this.ProductImagePath = productImagePath;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String productName) {
        this.ProductName = productName;
    }

    public float getPriceProduct() {
        return PriceProduct;
    }

    public void setPriceProduct(float priceProduct) {
        this.PriceProduct = priceProduct;
    }

    public int getQuntityProducts() {
        return QuntityProducts;
    }

    public void setQuntityProducts(int quntityProducts) {
        this.QuntityProducts = quntityProducts;
    }

    public float getSumCost() {
        return SumCost;
    }

    public void setSumCost(float sumCost) {
        this.SumCost = sumCost;
    }

    public ArrayList<Cart> getCartList() {
        return CartList;
    }

    public void setCartList(Cart cartList) {
        if (this.CartList == null) {
            CartList = new ArrayList<>();
        }
        this.CartList.add(cartList);
    }

    void setAttribute(String cart, Cart cart0) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
