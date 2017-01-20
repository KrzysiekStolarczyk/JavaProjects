<%-- 
    Document   : output
    Created on : 2017-01-09, 23:04:25
    Author     : Kuczma
--%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.ensode.nbbook.controller.StoresAssortment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="assortment" scope="request" class="com.ensode.nbbook.controller.StoresAssortment" />
<!DOCTYPE html>
<html>
    <head>
        <title>Asortyment</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href ="<c:url value='resources/css/styles.css'/>">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <script src='http://code.jquery.com/jquery-1.7.1.min.js'></script>
    </head>
    <body>
        <!--FILTROWANIE-->
        <div id="left">
            <form action="ControllerServlet" method="post">           
                <br>
                <input  value="filter" name="filterN" class="text-center" type="image" src="http://www.freeiconspng.com/uploads/filter-icon-9.png" width="330" height="250">
                <br><br>
                <table class="table table-hover">
                    <tr align="center">
                        <td headers="cenaO"><p class="text-center"><b>Cena od</b></td>
                        <td headers="cenaD"><p class="text-center"><b>Cena do</b></td>
                        <td headers="check"><b>Filtr</b></td>
                    </tr>
                    <tr align="center">
                        <td><input name="cenaOd" size="1" class="form-control" placeholder="Cena od" type="number" min="0" step="50" max="2000" ></td>
                        <td><input name="cenaDo" size="1" class="form-control" placeholder="Cena od" type="number" min="0" step="50" max="2001"></td>
                        <td><input name="checkedCena" class="checkbox" type="checkbox" ></td>       
                    </tr>
                    <tr align="center">
                        <td colspan="3"> <p class="text-center"><b>Wybierz kategorię</b></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <select name="category" class="form-control">
                                <option>Silnik</option>
                                <option>Karoseria</option>
                            </select>
                        </td>
                        <td><input name="checkedKat" class="checkbox" type="checkbox"></td>     
                    </tr>
                    <tr align="center">
                        <td colspan="3"> <p class="text-center"><b>Wpisz słowo kluczowe</b></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2"><input name="slowo" size="1" class="form-control" placeholder="wpisz frazę jaką chcesz wyszukać" type="text"></td>
                        <td><input name="checkedSlowo" class="checkbox" type="checkbox" ></td>   
                    </tr>
                    <!--                    <tr align="center">
                                            <td colspan="3"><button type="submit" class="btn btn-primary">Filtruj</button></td>
                                        </tr>-->
                </table>
            </form>
        </div> 
        <div id="content"> 
            <br>
            <%
                ArrayList<StoresAssortment> AssortList = assortment.getStoresAssortmentList();
                pageContext.setAttribute("windows", AssortList);
            %>   
            <!--KOSZYK-->
            <form action="MyCart.jsp" method="post">
                <div align="right">    
                    <table width="300">
                        <tr>
                            <td rowspan="2"><input type="image" value="buttonCartValue" name="buttonCart"  src="http://www.szal-art.pl/templates/pt_wide/img/menu_top_koszyk.jpg" ></td>
                            <td headers="email"><b>Ilość przedmiotów:</b></td>
                            <td headers="phone"><b>Wartość:</b></td>
                        </tr>
                        <tr align="center">
                            <td><b><p id="ilosc">${param.QuntityProductsCart}</p></b></td>
                            <td><b><p id="wartosc">${artList.price}</p></b></td>
                        </tr>
                    </table>
                </div>
            </form>
            <br>
            <!--MAINVIEW-->
            <form  action="MyCart.jsp" method="post" >
                <table class="table table-hover">
                    <c:forEach items="${windows}" var="artList">
                        <tr>
                            <td><h2><p class="text-center"><input type="hidden" name="idProduct" value="${artList.id}">${artList.id}</p></h2></td>
                            <td><h2><p class="text-left"><input type="hidden" name="ProductName" value="${artList.productName}"> ${artList.productName}</p></h2></td>              
                            <td><h2><strong><input type="hidden" name="Price" value="${artList.price}">${artList.price} zł</strong></h2></td>
                            <td><h2><strong>${artList.stock}</strong></h2></td>
                            <td><input type="hidden" name="imagePath" value="${artList.imagePath}"></td>
                            <td><input name="QuntityProductsCart" size="5" class="form-control" placeholder="Wybierz Ilość" type="number" min="0" step="1" max="${artList.stock}">
                                <button name="idP" class="btn btn-success" value="${artList.id}">Dodaj do koszyka</button></td>
                            <td><img src=${artList.imagePath} alt="zdj" title=${artList.productName} width="133" height="100"></td>
                        </tr>
                    </c:forEach>
                </table>
            </form>  
        </div>
    </body>
</html>
