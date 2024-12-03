<%@page import="bean.User"%>


<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="${contextPath}/css/stylelogin.css" media="screen">
        <link id="u-theme-google-font" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i|Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i">

    </head>
    <body class="u-body"><header class="u-align-left u-clearfix u-header u-header" id="sec-ad7d"><div class="u-clearfix u-sheet u-sheet-1">

                <img class="u-image u-image-default u-preserve-proportions u-image-1" src="${contextPath}/images/login/logologin2.png" alt="" data-image-width="210" data-image-height="92">
                <img class="u-image u-image-default u-image-2" src="${contextPath}/images/login/logo-login.png" alt="" data-image-width="492" data-image-height="93">

                <%--Log in form--%>
                <form action="${contextPath}/userController" method="POST" class="u-clearfix u-form-spacing-15 u-form-vertical u-inner-form" style="padding: 15px;" source="custom" name="form">
                    <%--Message when log in failed--%>
                    <c:if test="${mess != null}">
                        <div class="u-form-group u-form-name">
                            <p style="color: red; font-weight: bold;">
                                <c:out value="${mess}"/>
                            </p>
                        </div>
                    </c:if>
                    <div class="u-form-group u-form-name">
                        <p>Enter your user mail:</p>
                        <input type="email" placeholder="User Mail"  name="userMail" class="u-border-1 u-border-grey-30 u-input u-input-rectangle" required="">
                    </div>

                    <div class="u-form-group u-form-name">
                        <p>Enter your password:</p>
                        <input type="password" placeholder="Password"  name="password" class="u-border-1 u-border-grey-30 u-input u-input-rectangle" required="">
                    </div>
                    <div class="u-align-center u-form-group u-form-submit">

                        <input type="hidden" name="service" value="login">

                        <button class="u-btn u-btn-submit u-button-style" type="submit">Login</button>
                    </div>
                </form>
            </div>


            <%--Register--%>
            <a href="${contextPath}/login/register.jsp" class="u-active-none u-border-2 u-border-palette-1-base u-btn u-btn-rectangle u-button-style u-hover-none u-none u-btn-2">Register</a>
            <%--Forgot password--%>
            <a href="${contextPath}/login/resetPass.jsp" class="u-active-none u-border-2 u-border-palette-1-base u-btn u-btn-rectangle u-button-style u-hover-none u-none u-btn-3">Reset your password</a>
    </body>
</html>

