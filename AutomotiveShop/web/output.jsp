<%-- 
    Document   : output
    Created on : 2017-01-09, 23:04:25
    Author     : Kuczma
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ensode.nbbook.controller.Assortment"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="surveyData" scope="request" class="com.ensode.nbbook.controller.SurveyData" />
<jsp:useBean id="assortment" scope="request" class="com.ensode.nbbook.controller.Assortment" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href ="<c:url value='resources/css/styles.css'/>"/>
        <title>Dziękujemy!</title>
        
       
    </head>
    <body>
        <h2>Dziekujemy za udzial w ankiecie.</h2>
        <%
            //  String[] windows = new String[]{"Windows XP", "Windows 7", "Windows 8", "Windows mobile"};
            ArrayList<Assortment> test121 = assortment.getAssortmentList();
            pageContext.setAttribute("windows", test121);
        %>

        <p>
            <jsp:getProperty name="surveyData" property="fullName" />
            poinformował, że zna nastepujące języki programowania:</p>
        <ul>
            <% String[] selectedLanguages = surveyData.getProgLangList();
                if (selectedLanguages != null) {
                    for (int i = 0; i < selectedLanguages.length; i++) {
            %>   
            <li> 
                <%=selectedLanguages[i]%>
            </li>
            <%}
                }
            %>
        </ul>
                <ul>
            <% ArrayList<Assortment> test1 = assortment.getAssortmentList();
                if (test1 != null) {
                    for (Assortment a : test1) {
            %>   
            <li> 
                <%=a.getCategoryId()%>
            </li>
            <li> 
                <%=a.getCategoryName()%>

            </li>
            <%}
                }
            %>
        </ul>
   <%--        
    <c:forEach var="i" begin="1" end="5">
        Item <c:out value="${i}"/><p>
    </c:forEach>

    <c:forTokens items="Zara,nuha,roshy" delims="," var="name">
        <c:out value="${name}"/><p>
    </c:forTokens>
  --%>  
       
        <table border="6">
            <tr>
                <th>Id</th>
                <th>Name</th>
            </tr>
                <c:forEach items="${windows}" var="artList">
            <tr>
                <td bgcolor="#426B9C">${artList.categoryId}</td>
                <td>${artList.categoryName}</td>
                <td><img src="obrazki/Halogenlewy1.jpg" alt="zdj" title="800x600" width="133" height="100"/> </a></td>


            </tr>
           
           </c:forEach>

        </table>


</body>
</html>
