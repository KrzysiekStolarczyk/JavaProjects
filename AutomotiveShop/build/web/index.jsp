
<%-- 
    Document   : index
    Created on : 2017-01-09, 21:35:31
    Author     : Kuczma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ackieta dla programistów</title>
    </head>
    <body>
        <h1>Zapraszamy do wypełnienia ankiety!</h1>
        <p>Podaj, które języki programowania znasz.</p>

        <form action="ControllerServlet" method=post">           
            <table border="0">
                <tbody>
                    <tr>
                        <td></td>
                        <td><input type="text" name="fullName" value="" /></td>
                            <%--  <td><input type="text" name="fullName" value="" /></td>--%>
                    </tr>
              
                     <tr>
                        <td>Java</td>
                        <td><input type="checkbox" name="progLang" value="Java" /></td>
                    </tr>                       
                    <tr>
                        <td>Groovy</td>
                        <td><input type="checkbox" name="progLang" value="Groovy" /></td>
                    </tr>
                    <tr>
                        <td>Scala</td>
                        <td><input type="checkbox" name="progLang" value="Scala" /></td>
                    </tr>
                    <tr>
                        <td>C#</td>
                        <td><input type="checkbox" name="progLang" value="C_Sharp" /></td>
                    </tr>
                    <tr>
                        <td>Ruby</td>
                        <td><input type="checkbox" name="progLang" value="Ruby" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Prześlij" /></td>
                    </tr>
                </tbody>
            </table>
        </form>

    </body>
</html>
