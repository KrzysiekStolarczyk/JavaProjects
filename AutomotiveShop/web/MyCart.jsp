<%@page import="com.ensode.nbbook.controller.Client"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href ="<c:url value='resources/css/styles.css'/>">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <script src='http://code.jquery.com/jquery-1.7.1.min.js'></script>
    </head>
    <body>
        <%
            //kasowanie z koszyka
            String idKasowanegoProduktuZKoszyka = request.getParameter("idOnList");
            if (idKasowanegoProduktuZKoszyka != null) {
                cart.removeItemFromList(Integer.parseInt(idKasowanegoProduktuZKoszyka));
            }

            //ogarniecie koszyka
            String ifLogin = request.getParameter("Log");
            if (ifLogin != null) {
                Client klient = new Client();
                String login = request.getParameter("uname");
                String haslo = request.getParameter("psw");
                int Result = klient.CheckPasswordClient(login, haslo);

                if (Result == 1) {
                    cart.submitOrder();
                } else {
                    pageContext.setAttribute("HasloOk", Result);
                    pageContext.setAttribute("cartList", cart.getCartList());
                }

            }

            //Dodawanie do koszyka          
            String idFromList = request.getParameter("idP");
            String buttonCart = request.getParameter("buttonCart");
            if (idFromList != null) {
                Cart fromOutputJsp = new Cart();
                int id = Integer.parseInt(request.getParameter("idP"));
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

                ArrayList<Cart> temp = cart.getCartList();

                if (temp == null) {
                    cart.setCartList(fromOutputJsp);
                } else {
                    int petla = temp.size();
                    int test = 0;
                    for (int i = 0; i < petla; i++) {
                        if (temp.get(i).getIdProduct() == id) {
                            temp.get(i).setQuntityProducts(temp.get(i).getQuntityProducts() + Integer.parseInt(quantity[id - 1]));
                            temp.get(i).setSumCost(temp.get(i).getSumCost() + (Integer.parseInt(quantity[id - 1]) * Float.parseFloat(price[id - 1])));
                            test = 1;
                        }
                    }
                    if (test == 0) {
                        cart.setCartList(fromOutputJsp);
                    }
                }
                pageContext.setAttribute("cartList", cart.getCartList());
            } else if (buttonCart != null) {
                pageContext.setAttribute("cartList", cart.getCartList());
            }

            String idFromList2 = request.getParameter("imageCart");
            if (idFromList2 != null) {
                pageContext.setAttribute("cartList", cart.getCartList());
            }
        %>
        <%--<p>The length of the companies collection is : ${fn:length(cartList)}</p>--%>

        <!--Koszyk Empty ikona-->
        <c:set var="sizeCart" value="${fn:length(cartList)}"/>
        <c:if test="${sizeCart == 0}">
            <form action="ControllerServlet" method="post">
                <center><input name="imageCart" value="returnFromcart" type="image" class="midImg" src="http://www.technologyequipmentrental.com/images/empty-cart.jpg" alt="zdj" align="middle" title=${artListCart.productName} ></center>
            </form>
        </c:if>

        <!--Button jesli haslo zle--> 
        <c:set var="HasloIfOk" value="${HasloOk}"/>  
        <c:if test="${HasloIfOk == 0}">
            <form action="MyCart.jsp" method="post">
                <center><input name="imageCart" type="submit" class="btn btn-danger" value="Błędne hasło"  class="midImg"  align="middle" ></center>
            </form>
        </c:if>

        <!--Ładowanie Koszyka--> 
        <c:if test="${sizeCart > 0 }">
            <form action="ControllerServlet" method="post" >           
                <td><input type="image" value="Wejdz" class="midImg"  name="where" src="http://previews.123rf.com/images/myvector/myvector1201/myvector120102487/12129505-Vector-illustration-of-single-isolated-back-home-icon-Stock-Vector.jpg" /></td>
            </form>
            <form action="MyCart.jsp" method="post" >  
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
                            <td><input type="hidden" name="delete" value="Delete">
                            <td><button name="idOnList" value="${artListCart.idProduct}" type="submit" size="30" class="btn btn-danger" style="height: 80px; width: 200px;">Usuń Produkt z koszyka</button></td>
                        </tr>
                    </c:forEach>
                </table>
            </form>  
            <br>
            <!--Button zamówienia-->
            <form action="LoginForm.jsp" method="post">
                <td><input type="image" align="right" value="zamow" name="buttonZamow" src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxQQEhQUEhQSFBUWFhcXGRgXFRUZHBcdGxgcFhsYGiIZICogHBolHBgYIzEhJSorLi4uGR8zODMsNygtLisBCgoKDg0OGxAQGzQkICQyLCw0LDctLDQsNC8sNC0sLCwsNCw3LC0sLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLP/AABEIAGABHQMBEQACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAwQCBQYBB//EAEQQAAEDAQQECwQHBgcBAAAAAAEAAgMRBAUSIQYTMVEUFUFSU2FxkZOx0iKBodEHMjM0QnKSFiRDc7LBI1RigoPC4WP/xAAaAQEAAwEBAQAAAAAAAAAAAAAAAQIDBAUG/8QAOBEAAgECAgcFBwQCAgMAAAAAAAECAxEEEhMhMVFSkZIUMkFx0QUiM2GBobE0QsHwI3IV8SRDgv/aAAwDAQACEQMRAD8A+4oAgCAIAgCAIAgCAIAgCAqW+84YBWaWOPKvtOAJ7BtPuWkKU591XM6lWFPvOxTF/B5pDDaJdntCMsbQ8odJhBHZVadna78kvrr+1zPtCfci39NX3t9jIPtj/wANngGe0vmd1GgwD4lRajHxb+3qL15bl9/Qliu+TLWTyPNPwhrG9tAK95Kq6kf2xX5LRpy/dK/2X9+pdijDRQV95J81m3c1SSVkZqCQgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAIAgCAICvbbdHA3FK9jG73ECvUN56grwpym7RVyk6kYK8nY13HEkv3eB7xz5axM7RUYnDlybQ71roYx+JK3yWt+n3MdPKXw43+b1L1+1vmR8VWmb7xai0cyzt1Y7C51XEdlD1q2mpQ7kPq9f21IjQ1Z/En9ErffWy1d9wWeA4mRNx7S91XPJ3lzqmqzqYipNWb1bvA0p4enDWlr3+JslibEU0GLLG8flNPJWUreBVxv4kL7vaQAXSmn/wBHivbQqyqtbLckVdJPbfmyF9yxOdiJl2UprpadtMVKqyryStq5Ir2eN76+bMm3PEOR/vlkP/ZQ60/6kSqMV/2yudGrOcWUntU/jS5fl9rL3K/aqmrZyRR4Wnr26/myN2i8P4X2hv5bRL2V+ttU9rn4pckVeDh4Nr/6ZWn0Qa6mG1W5hAplOTU7yCPKgWkca1thF/QpLBJrvy5mR0cmGTLfaQMNBiEbji3kkZjZll2qO003tpr7/wB/uwdlqLu1Ha3yev8Avh9xJdtva0CO2Me7lMkLRUe6pqiq4dv3oW8mTosQlqnfzRELVecX1obNaGgD7N5jc79VRl2citlwk9knHz1ormxcNqUvszxul7mfeLFa4qfWcGGRjevE3ajwafw6if1syFjZL4lNr7rmbGwaUWSagZPHU09lxwnPko6lT2LGeFrQ2xNoYujPZJG3BXOdJ6gCAIAgCAIAgCAIDnr9vB5k1MbsADQ57x9bPY1u4mhzXXRpxUNJJX3L1ODE1ZyqaKDtqu3469iRreBN583jS+pa6aW5ckY6CG+XVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1HAm86bxpfUmmluXShoIb31S9SGS54XOD3B7nClHGR5IpmKEmoV1iaiVla3kiksHRk8zvf8A2fqTcCbzpvGl9Spppbl0ovoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbz5vGl9SaaW5dKGghvfVL1Kkmj9mcSXMqTtJc41+K0WLrLY/sjJ4HDvW0+b9SxFdsbAGtMrQNgEsgA7AHKjrzbu7ckaRw1OKsm+qXqZ8CbzpvGl9SjTS3LpROghvfVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1HAm86bxpfUmmluXShoIb31S9RwJvOm8aX1Jppbl0oaCG99UvUcCbzpvGl9SaaW5dKGghvfVL1GN9n9uJ73AZuY9xeHDloXZgqVlq+7NLzWoq89H36bbttTd789aZ1ljtIlY142OAI94qvPlFxbT8D1YSU4qS2PWcpej6WqbrbH5OXfTV6MfN/weXWdsTPyj/JFr0ykZxr0yjONemUZz0TJlJzkrI3u2MeexpVW4rxLJSexE7rFIAC4BoIrVzgKdtVTSQNNFU3FN04qQHNdTlaaj3HlV461cym8rsyUMedjH/pKe7vJtLcNXJzH/AKSl47xae58iHXq2UpnGvTKM416ZRnGvTKM416ZRnGvTKM5cu2zmYnOgAqSs6klBG1KLqMputLSXYCXNBoHUpi6x1K0dauylRqLsmNerZSmca9MozjXplGcyY8uNACTuAqoaS2kqTepEmrk5j/0lReO8tae58gWPGZY/9JT3d4tLcQ69WylM416ZRnGvTKM416ZRnGvTKM416ZRnGvTKM5nGXO+q1x7AT5KHZbSybexGLpaGhyISxDlbaea9TlIzmE03su7D5KYx95FZz91nRaM/dovyM/pC5MR8Wfm/yejhP09P/WP4RzWkdqay1SAmhws8iu6hBujHzZ5eMqKOIknuX8lNtoB2EH3q2Uyzpm3xRMkiZqi7WCM4jIRTEaGgG41XNeo72ew7rUo5U1e9vEibeJE2ARQNaJcBq1znUD8O0nI06kUJShmuHVhGpkUVtMLbecwkkaJMIa9wAa1goAcs6VU06MZRTZFbEyhNxR5edpeWWer3mrH19o5kOG2naohTjnasKtaWjjK+0ivUCsIIrSBpzzzLnb+xWpRWaRWvNqEPIriVb5Tlzm/s+k7vZY2GpyaPb28m5ccsM9bbPRhjY6opG7vO8BBCXv20oGg1q47Gj3rnjHM7I7JzUY3Zyt03PLLG1wLQN5O2mR2da7ZVYw1M8uFCdX3lsMrwuqWFuJ1C3lIOztUwqwk7Crh6lNXewxiuyV0esABbQkZ5nsG9S6sFLKysaFSUcyJZ7lmZGXmmQqQDmAqqtBuxd4Woo5j2C5JnsxUA5QCaE/L3pKtBOwjhako3NbEHOdhaCXVpTlqtXZK/gc6UnLKlrN5xRadUYw6NrXfWAriPVXZ1LklOnKV3c9CFKtGGVWNZY7uke5zGgAs2gmlF0SqQikzkjRqTk4+KI2wPMuqGb8WHblXarZo5c3gUySz5PE9t1mfC4MfTERUUNeWiiE4z1ompTnTaUiS32CSBodJhFTQZ51pVRCpGTsi1SjUpxzSMLtvLUPx4cRoQBWm3lU1ablGyK0KypyuzrLnvIzxl5bgoSNtdgquGpTyOx61GqqkcyOftuk7pY3sEeHE1zQ7FsrlWlFtHDPUzlqY2OuNjyx3HNI0HJo5MRzPuWsq0IuxhDDVJq+wrWuwyRPaxwzd9Ug5HkV41IyV0ZzpThJRfiSzXTM1zW4QS6tKGuzlPIAqqtBl5YaqmlY9s11SyOe0YfYIDjXIGgNOvajrQSuI4apJtbiS1XHNG0u9lwGZoc/iqxrwbsWnhakVfaV7Bd8k7S5lKA0zNFedSMHZmVKjOorxLPEE+5v6lTT0zXslU2ein2bz/AKyK9gWOId2rHTg01F33nKC0Yi53Oc53e4lddONoo8+tO82e61XymWYxfLkexSo6yJS1HZaOfd4/yt8l5tf4svN/k9vC/Ah5L8HAafyYbY78rfJevglegvNnz3tV2xL8l/JzgtPWurKefnOqF9tis9jkdC2UkvjLjI9uDA4Obk3I1Dic9y82VGTrTjF28T2oYiEcPTnON/DbssZX1pEyG1TM4LG7BJ9YzSAnY7FQCg27FFChUnTTUvsWxWLpUqzjKF3vue39pDHFapozZWOwvzdrZAXVANaAUG1MPQqTppqVvoMZiqVOs4yhf53JrfpBC2CyvdZgRIJ8I1j/AGMDmg5jbWvwURoVNLKKlr1Fp4qiqEJuGp31XIdIbyjE4FcNIYsszSrcVK+9Ww1OTTfzM8dWhGUVs1Iott7D+NveunJLccelhvO00Xu4Rs18tBlVtfwt5x7fJediat3kR7OCoZVpJfQ5++r24VLiB/w25MHm49Z8lth6OVXe05sXic8sq2G2sN2WuRjf8QwxgeyAaE8tTTPvKyqTpKTdrs3o08Q4JJ2Rtr4Do7DIHuxuEZbi3k5A/ELnjZ1FY7J3jReZ31EdstTrNYWllA/CwCorQmmfmrWz1bFM2ioJ7kS3Zb3mxmaQ4nNbI6pAFcNaVAy5FFWCjUyomhVc6OeXzItErwlnY90rg6jhT2QKVFSMuTtU16ahaxXC1pVU2yHRWIEzzHlkeB2A1Pn8FNaTyxiRh4JznP52KFw3xLNagS8lj8Xs/hDQCRQb8hmtJ0YxpX8TGlipzr5fDWbpjgLe4D8UDSe0PcK93ksP/X9Tq1Kv5oqWGEMtNqmfk2M7e1ocffTzV5S/xqKM4wtWlN+BLedl1trsx5MLnHsaQR8SFFOeWEi1annqQ5ml0vtuO0Bg2RCn+52Z7hT4rfCQ1Zjkx9XWoI0uNdtjzbnZ3S7VWAv/ANEjvOnwAXmV9dW3ke3hfdw9/NnPaLWXWzMBzDRiPu2fEhddeWSnqPPwsNJW1+Gs6a97vtEsrXRyhjG0o0Eip5SabexcVOUEveVz1K0KsmsjsiW948UtlHLrSe5hcfIKsHZPyLVY3cfMp6R3++zyNZG1hJbiJdXLOlKDsWlGjpDLE4nQ2VjWXdZ7VaA5zH6pkj3PJGWI7KDloNi1mqULKWto56Uq9W8o6kzpLBC+GFwkk1lMRqeQU2Zrmm4t+6rHdSjKMbTdzh7hvaV5bDZpaYiTQNY6m9xJacqLvqUYqOeZ5FHEzdTR034nQ6UaSCwxtjxmSd7cjRtQOV7gKADcFyUaDqy1bD0MTio4eF5PWRXPbRFdck2dAyV2fLSo8wrV4f5snkimFqXw+k82fPxfLqAAAZdZXrqgkj52WKbewjferz+KnYAr6KJR4iT8SF1sJ2kn3qygkzOVRtbT67ot91h/ls/pC+fxPxp+b/J9hhP09P8A1j+EfPPpJNLYfyt8l7GA+AvNnz3tZf8AkvyX8nK412Hm2OiuN0klnMfAnWuNspeCHyNwuwBpFWbcuTrXDiElUUlPK7Hq4PNKi4OnmV77fE2VtilmkdJJdDnPeauOunFTSmwZbAFzweRZY1VbyR1VYaWWadBt+bFsilme6SS6HOe7MnXTitBTYMtgSDyK0aqt5IVYaWWadBt+bPZopXsjY66HFsWPANdP7OMgu2ZmpA2onaTkqqu/kiXC8FB0HZfNmk00k/fZgBTCI203UjaKLpwPw7/M4fanxrbkifQW622q1BsmbGDGRvoRQHqqrYyq6dO62sp7Ow0a1b3ti1n0vSq5pLZEIWSiJhPt+zUuA2N2igrtXi0ZxhLNJXPpcRSlUhki7HG2vQ3gZhkknxM18LC3CRUOkDTnXZSq9FY7OnFR8H+Dx/8Ai9E1Jzurr8nR6dXVabS2JtnkDGAuMlXlnIKEkbWj2qjsXFhp04yvUVz08bTrVIpUnYi03JhsMUTXe06SGMEcuYr5KcPaVW/myMVeNDLfciv9J9sMNmhYw0LpAOTY1pPyV8FHPV1mXtKbhh7LyJL2tDoLmrX2zEwVy2vIB+BKrZTxNvmWu6eD+djLQe0Fl3yTPzzlfsAyY2n/AFKtjUtNlXyK+zbrD5peLbI/o2vDhFkexxGsDnVpuc0Ud31HuTGU8k0/CxPs6rpKck9t2TaL3DLZHOltT4qMaQC2tKcrjXZlyJXrxnFRgiMLhJ0puc2vkajR3SThV6uLaat4cxmRqWtbUH3kE+9aTw+TDXe0yp4rSY2y2WaNl9JN68GgbHHQPnfU9bWgFx+DQscHS0lTXsR0e0K2ipO21nRyWxkVn4Q/YyHET1YcR8lzuLzZVvOtSShme4+Mvv6V5L3YauJcct5qvep4eMYpHylbFTnNyMDfEm8dy00UTLTTPpWk1odZ7oyNH6uFnJtc5od8C4rxYJTxH1PpardLCfNJHN/R1fP71gld9owtbkB7QIIGW8Arux1L/HePgeX7LrvTZZPajd6S6MWyW0Pkgnox+E4TI9uCjQ00oMxlX3rkw9ajGNqkdZ6GKw2JnPNSnZbj24bmfZ7dEySaSV4gkkdVzi1pLmsaGg9Rdn1KKtWEqbyxtrRNChOnVjnm27N/LwOS+kG2l14TAE0Y2Nm3/QH+byu72fD/AB3PM9rTbrW3I+gX/d0s1gZFY3BpIjzDsNWACoBGyuXaK715kJR0t6h7VSnJ0MtHcrFV9mNhuiVpcHObFIS4EkFziaUJzO0CvUplKNSt7qstREISo4a0nd2est6H6Pix2cEYTM9gLnHZWlQ3fhCnE13VlbwRXBYVUIX/AHPacfpJofPGye12i0Me4AvdRrs+QNbuGwALrw2KpxtCMTgxmAqTvUlIX1cVqs1hLn2r/ADWViA5zhRv6nJGtRqVu7r3ieGxFLDtZ9VtljjMa9U8GwxoLHrH5jtRbQ0fbNFvusP8tn9IXzeJ+NPzf5Ps8J+np/6x/CPnH0mn98/2jyC9jAfAXmzwPan6l+S/k5LEus4LGz0dszrRPHAJHRh7syHEclTkDmaCiwxGWMHNq9jqwinKoqcZWubvTq4jd5iMc8zhJiFHSOqC2hqKHMZ+73rjwlSFVtSijvx1KpQSlGb5nLcLf0kviP8Amu7QU+FHm9orcT5n0v6N7qims5lkJleXOaQ9znBgGwUJoCdteteTjXlqZYqyPc9nLPSzSd3+DitNbFHZ7bLHETh9l1CS7CXCpbU59+9ehgpuVLWeX7SpKFbV4mrslvkhJMUkkZIoSxzmkjdkuipTjUVpK5y0qs6TvB2LHH9q/wA1avGk+ay7JR4Tft2I4iK1XpPKMMs88jag0fI9wqNhoTtVoYenF3SKTxVaayylqJbVf1plZq32iVzObi29RIzcO0lVWFpKWaxZ42u45cxHaL2nkLTJPM/C4ObikecLhscKnIjerRw9OLukVniq01aUiO13hLNTWyyyYa0xvc6ldtKnJTCjCDvFWK1cRVqq03cytN6TSNwSTTPZl7LpHFuWzImmShUKalmS1kyxNaUcjlqAvOYR6oTTCMgtLBI4NIdWooDShqa9qmVCnKWZrWRDE1YQyRlqMLHbpIXB0T3RuHK0kHs6x1K06cZq0kUp1J05ZoOzLF435abQMM08sjeaSA09oaAD71lDC0oO6RvUxteorNlWz2p0bg6NzmOFaOaS0iooaEbMiVtKKksrWo54TlCWaLszK1W2SYgyySSECgL3udQbhU5KtOjCn3VYvVr1KvfdySe9Jns1b55nR0AwGR5bQbBStKZBV7PTzZray3aq2XJm1FXEtjnsMSCxZtV6TStwyTTPbUHC6R5blsyJosY0KcZZktZ0TxVaccspaisH0Wz1nOtTujbM0ptjW4RapgO0E95BPxXK8HRbvY7Y+0MQlbMU471na5z2zzh7snPEj8TgOQmtadS07PStlymfa62bNm1leWZz3Fz3Oc5xqXOJJJ3knMrSEIwVooxqTlUlmk7sux39aWx6ptolbHSmEOpluB2gdQKylhqUpZmtZvDGVoQyKWogkvKZ0YiM0xjAAwGR+GjaUFK0oKDuUrD01LMlrKvFVnHK5aixx/av81afGk+aq8LR4S6xuIX7iK03vPK0sktE72mlWuleQaGoqCaHMBTHDUou6RE8XXmsspajy1XrPK3DJPO9tQcLpHluRqMiaZFTHD04vMlrIniq045ZS1FXEtjmsMSCx7G7MdoUohrUfc9Fvu0X8tn9IXzeJ+NPzf5Pr8J+np/6x/CPm30on98/2jyC9fA/AXmzwvaX6l+S/k47Eus4bGTJC0ggkEZgg0IO8URpNWZKbTuiS2W2SZwdLJJI4CgL3l1BuFdizp0oQ7qNalapU77uQ4loY2LNjvKWCuplkjrtwPLa9tFnUpQqd5GtKtUpdx2KxcSSSSSTUkkkk7yTmSrxioqyKTlKbvJjEpK2GJBYYkFhiQWGJBYYkFhiQWGJBYYkFhiQWGJBYYkFhiQWGJBYYkFhiQWGJBYYkFhiQWGJBYYkFhiQWGJBYYkFhiQWGJBYYkFjKN2Y7QpW0hrUfeNFvu0X8tn9IXzmJ+NPzf5PrMJ+np/6x/COY+kbRl87hNEKuAoR5UXbgcTGC0c9W5nn+0cHOctLTV/Br0PnJuafo39xXp54cS5o8nJPhfSzziafo39xTPHiXNDJLhfSxxNP0b+4pnjxLmhknwvpY4mn6N/cUzx4lzQyT4X0scTT9G/uKZ48S5oZJ8L6WOJp+jf3FM8eJc0MkuF9LHE0/Rv7imePEuaGSfC+ljiafo39xTPHiXNDJPhfSyOa75GfXbh/MQPNSmnsa5orL3e8mvozCOxvcaNo47gQfJS1ba/uQpJ6knyZY4mn6N/cVXPHiXNF8k+F9LPOJp+jf3FM8eJc0MkuF9LHE0/Rv7imePEuaGSXC+ljiafo39xTPHiXNDJPhfSxxNP0b+4pnjxLmhklwvpY4mn6N/cUzx4lzQyT4X0scTT9G/uKZ48S5oZJ8L6WOJp+jf3FM8eJc0Mk+F9LHE0/Rv7imePEuaGSXC+ljiafo39xTPHiXNDJPhfSxxNP0b+4pnjxLmhklwvpY4mn6N/cUzx4lzQyS4X0scTT9G/uKZ48S5oZJcL6WYS3ZKwVcwtG92XmpUovY1zREk47YvkyJtmcchhJ6nN+atYopp+D5MscTz9G/uKpnjxLmjTJLhfSxxNP0b+4pnjxLmhknwvpY4mn6N/cUzx4lzQyS4X0scTT9G/uKZ48S5oZJ8L6WOJp+jf3FM8eJc0Mk+F9LHE0/Rv7imePEuaGSfC+ljiafo39xTPHiXNDJLhfSxxNP0b+4pnjxLmhklwvpZsbl0YmlkFWloBzJCyq4mnSV27vcjSlhKtZ5VFpeLasfarqsurja0bAAO4UXgSk5NyfifUQioRUVsWotuaDtVSxAbCw8gQHnAGbggHAGbggHAGbggHAGbggHAGbggHAGbggHAGbggMJLricKOY1wPIQCPipTa2ENJ7TSW7QGxS5iLVnfGcPwGS6IYurHxuc08HSl4W8jX/sNND92tsoHI2UYx/53LVYqlL4lNfQxeEqx+HUf11/3kecEvOHbHZZwNxLSfJLYSWxtEp4yO1Jht9Whn212y9sbg74UTstKXdqL6kdrrRXvUn9D39sLK37Wz2qLfji/wDa/BOwTfdkn9R/yMF3otfQlj0yu0/xCO2N/wAlV4CuvD7l17QoPx+zLTNJLvP8aP3gj+yo8HW4S6xtB/uJBf139PD3qOyVuFlu10ONGLtIbvH8eL3Zp2Stwkdso8SIJNKrub/FB7GOPkFdYGu/2lHj6C/cVnaZ2DYwSyHcyM/3orr2fV8bL6lH7So+F39DH9pcf2N32t/5mhg78wnYku9UQ7dJ92mxr7wl+zsUUXXI+vl8k0WGjtm39BpcVLZBL6j9mrwm+1tUUIO0RMqe80p3ppcNHuwv5kaHFT700vJE1n+jiz1rPJNOeXG8/wBvmqyxktkUkXjgYbZtv6m+sWjtmg+yhjZ1hor37VzTqTn3nc6YUoQ7qsW+AM3BUNBwBm4IBwBm4IBwBm4IBwBm4IBwBm4IBwBm4IBwBm4IDOOyNbsCAnQBAEAQBAEAQBAEAQBAEAQBAEAQEUlmY76zGu7Wg+alSa2Mq4xe1EDrpgO2CE/8bPkr6WpxPmV0NPhXIwNyWb/L2fwmfJNNU4nzY0NPhXJHrbms42WeAf8AEz5JpqnE+Y0NPhXJEsd3xN+rFGOxjR/ZQ6kntZKpwWxIsNFNmSoXPUAQBAEAQBAEAQBAEAQBAEAQBAf/2Q==" /></td>
            </form>
        </c:if>
    </body>
</html>