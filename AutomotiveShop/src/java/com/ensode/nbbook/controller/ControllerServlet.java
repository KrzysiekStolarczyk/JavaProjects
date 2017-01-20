/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ensode.nbbook.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ControllerServlet", urlPatterns = {"/ControllerServlet"})
public class ControllerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        StoresAssortment allAssortment = new StoresAssortment();
        String fromRequest1 = request.getParameter("where");
        String fromRequest2 = request.getParameter("filterN");
        String fromRequest3 = request.getParameter("imageCart");
        int action = 0;

        if (fromRequest1 != null || fromRequest3 != null) {
            action = 1;
        } else if (fromRequest2 != null) {
            action = 2;
        }

        switch (action) {
            case 1:// Start aplikacji i zaladowanie całego assortymentu
                allAssortment.setStoresAssortmentList(allAssortment.getStoresAssortment());
                request.setAttribute("assortment", allAssortment);
                request.getRequestDispatcher("MainView.jsp").forward(request, response);
                break;
            case 2:// zaladowanie assortymentu z uwzglednieniem filtrow
                String CenaOd = request.getParameter("cenaOd");
                String CenaDo = request.getParameter("cenaDo");
                String Kategoria = request.getParameter("category");
                String SlowoSzukane = request.getParameter("slowo");
                String CheckCena = request.getParameter("checkedCena");
                String CheckKat = request.getParameter("checkedKat");
                String CheckSlowo = request.getParameter("checkedSlowo");

                int pozionm = 0;
                String zap = "SELECT [id],[ProductName],[Price],[Stock],[ImagePath] FROM [JSP].[dbo].[VStoresAssortment]";
                if ("on".equals(CheckCena)) {
                    if ("".equals(CenaOd)) {
                        CenaOd = "0";
                    }
                    if ("".equals(CenaDo)) {
                        zap = zap + " Where [Price] > " + CenaOd;
                    } else {
                        zap = zap + " Where [Price] between " + CenaOd + " and " + CenaDo;
                    }
                    pozionm = 1;
                }
                if ("on".equals(CheckKat)) {
                    if (pozionm == 1) {
                        zap = zap + " and ";
                    } else {
                        zap = zap + " where ";
                    }
                    zap = zap + " CategoryName=\'" + Kategoria + "\'";
                    pozionm = 2;
                }
                if ("on".equals(CheckSlowo)) {
                    if (pozionm == 2 || pozionm == 1) {
                        zap = zap + " and ";
                    } else {
                        zap = zap + "where";
                    }

                    zap = zap + " ProductName like \'%" + SlowoSzukane + "%\'";
                }
                allAssortment.setStoresAssortmentList(allAssortment.getStoresAssortmentAfterFilter(zap));
                request.setAttribute("assortment", allAssortment);
                request.getRequestDispatcher("MainView.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
