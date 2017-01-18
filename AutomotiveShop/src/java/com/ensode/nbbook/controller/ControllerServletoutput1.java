package com.ensode.nbbook.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Kuczma
 */
@WebServlet(name = "ControllerServletoutput", urlPatterns = {"/ControllerServletoutput"})
public class ControllerServletoutput1 extends HttpServlet {

    ArrayList<String> lista = new ArrayList();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        Cart cart = new Cart();
//        cart.setQuntityProducts(Integer.parseInt(request.getParameter("QuntityProductsCart")));
//        request.setAttribute("cart", cart);
        StoresAssortment allAssortment = new StoresAssortment();
        allAssortment.setStoresAssortmentList();
        request.setAttribute("assortment", allAssortment);
//        String[] a = request.getParameterValues("idP");
//         request.setAttribute("returnId", a);
     
         
//  String[] productName = request.getParameterValues("productName");
       // String h = a[0];
      //  int test = Integer.parseInt(h);
     //   lista.add(productName[test]);

    //    System.out.println(a);

        request.getRequestDispatcher("output.jsp").forward(request, response);

        // getServletContext().setAttribute("surveyData", surveyData);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
