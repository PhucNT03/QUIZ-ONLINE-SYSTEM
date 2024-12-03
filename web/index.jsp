
<%@page import="bean.Subject"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <script src="js/bootstrap.min.js"></script>
        <link href="css/font-awesome.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
       
    </head>
    <body>
        <%-- if subjectList is empty redirect to homeController--%>
        <c:if test = "${subjectList == null}">
            <c:redirect url="homeController"/>
        </c:if>
        <div class="wrap">
            <%-- Include header page--%>
            <jsp:include page="jsp/header.jsp"/>
            <div class="main">
                <%-- Include menu page--%>
                <jsp:include page="jsp/menu.jsp"/>
            </div>
            <%-- Include footer page--%>
            <jsp:include page="jsp/footer.jsp"/>
        </div>
    </body>
</html>
