<%@page import="com.ensode.nbbook.controller.Cart"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="cart" class="com.ensode.nbbook.controller.Cart" scope="session" />
<html>
    <head>
        <title>Twój koszyk</title>
        <link rel="stylesheet" type="text/css" href ="<c:url value='resources/css/styles.css'/>">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <script src='http://code.jquery.com/jquery-1.7.1.min.js'></script>
    </head>
    <body>
        <%
            Cart fromOutputJsp = new Cart();
            int id;
            try {
                id = Integer.parseInt(request.getParameter("idP"));
            } catch (Exception e) {
                id = 0;
            }
            if (id > 0) {
                String[] idProduct = request.getParameterValues("idProduct");
                String[] productName = request.getParameterValues("ProductName");
                String[] imageProductPath = request.getParameterValues("imagePath");
                String[] price = request.getParameterValues("Price");
                String[] quantity = request.getParameterValues("QuntityProductsCart");

                fromOutputJsp.setIdProduct(Integer.parseInt(idProduct[id - 1]));
                fromOutputJsp.setProductName(productName[id - 1]);
                fromOutputJsp.setProductImagePath(imageProductPath[id - 1]);
                fromOutputJsp.setQuntityProducts(Integer.parseInt(quantity[id - 1]));
                fromOutputJsp.setPriceProduct(Float.parseFloat(price[id - 1]));
                fromOutputJsp.setSumCost(Integer.parseInt(quantity[id - 1]) * Float.parseFloat(price[id - 1]));

                cart.setCartList(fromOutputJsp);

            }
            pageContext.setAttribute("cartList", cart.getCartList());
        %>
        <%--<p>The length of the companies collection is : ${fn:length(cartList)}</p>--%>
        <c:set var="sizeCart" value="${fn:length(cartList)}"/>
        <c:if test="${sizeCart == 0}">
            <form action="ControllerServlet" method="post">
                <center><input type="image" class="midImg" src="http://www.technologyequipmentrental.com/images/empty-cart.jpg" alt="zdj" align="middle" title=${artListCart.productName} ></center>
            </form>
        </c:if>
        <table  class="table table-hover">   
             <td headers="prod"><b>Nazwa przedmiotu:</b></td>
            <td headers="cen"><b>Cena jednostkowa</b></td>
            <td headers="cen"><b>Cena za wszystkie sztuki</b></td>
            <td headers="cen"><b>Ilość sztuk zamówionych</b></td>
            <td headers="cen"><b>Zdjęcie</b></td>
            <c:forEach items="${cartList}" var="artListCart">
                <tr>               
                    <td><h2><p class="text-left">${artListCart.productName}</p></h2></td>   
                    <td><h2><strong>${artListCart.priceProduct}</strong></h2></td>
                    <td><h2><strong>${artListCart.sumCost}</strong></h2></td>
                    <td><input name="QuntityProductsCart"  type="text" style="height: 40px; width: 80px;" value ="${artListCart.quntityProducts}" size="5" class="form-control" placeholder="Wybierz Ilość" type="number" min="0" step="1" max="${artList.stock}"></input>

                    <td><img src=${artListCart.productImagePath} alt="zdj" title=${artListCart.productName} width="133" height="100"></td>
                    <td><button type="button" size="30" class="btn btn-danger" style="height: 80px; width: 200px;">Usuń Produkt z koszyka</button></td>
                </tr>
            </c:forEach>
        </table>

    </body></html>