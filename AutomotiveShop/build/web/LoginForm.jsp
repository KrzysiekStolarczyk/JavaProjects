<%@page import="com.ensode.nbbook.controller.Cart"%>
<%@page import="com.ensode.nbbook.controller.Client"%>
<!DOCTYPE html>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<html>
     <title>Twój koszyk</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href ="<c:url value='resources/css/styles.css'/>">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <script src='http://code.jquery.com/jquery-1.7.1.min.js'></script>
    <style>
        form {
            border: 3px solid #f1f1f1;
        }

        input[type=text], input[type=password] {
            width: 40%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 40%;
        }

        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
        }

        .container {
            padding: 16px;
        }

        span.psw {
            float: right;
            padding-top: 16px;
        }

        @media screen and (max-width: 300px) {
            span.psw {
                display: block;
                float: none;
            }
        }
    </style>
    <body>
        <h2>Login Form</h2>

        <form action="MyCart.jsp" method="post">
            <div class="imgcontainer">
            </div>
            <div class="container">
                <label><b>Username</b></label>
                <p>
                    <input type="text" placeholder="Enter Username" name="uname" required>
                <p>
                    <label><b>Password</b></label>
                <p>
                    <input type="password" placeholder="Enter Password" name="psw" required>
                <p>    
                    <button type="submit" name="Log" value="login">Login</button>
            </div>

            <div class="container" style="background-color:#f1f1f1">
            </div>
        </form>
    </body>
</html>
