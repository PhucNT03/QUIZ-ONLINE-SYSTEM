<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="${contextPath}/css/stylelogin.css" media="screen">
        <link id="u-theme-google-font" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i|Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i">

    </head>
    <body class="u-body">
        <header class="u-align-left u-clearfix u-header u-header" id="sec-ad7d">
            <div class="u-clearfix u-sheet u-sheet-1">
                <img class="u-image u-image-default u-preserve-proportions u-image-1" src="${contextPath}/images/login/logologin2.png" alt="" data-image-width="210" data-image-height="92">
                <img class="u-image u-image-default u-image-2" src="${contextPath}/images/login/logo-login.png" alt="" data-image-width="492" data-image-height="93">
                <div class="u-form u-form-1">
                    <form action="${contextPath}/register" method="POST" class="u-clearfix u-form-spacing-15 u-form-vertical u-inner-form" style="padding: 15px;" source="custom" name="form">

                        <c:if test="${mess != null}">
                            <div class="u-form-group u-form-name">
                                <p style="color: red; font-weight: bold;">
                                    <c:out value="${mess}"/>
                                </p>
                            </div>
                        </c:if>
                        
                        <div class="u-form-group u-form-name">
                            <p>Enter your user name:</p>
                            <input type="text" placeholder="Username"  name="userName" class="u-border-1 u-border-grey-30 u-input u-input-rectangle" value="${param.userName}">
                        </div>
                        <div class="u-form-group u-form-name">
                            <p>Enter your password:</p>
                            <input type="password" placeholder="Password"  name="password" class="u-border-1 u-border-grey-30 u-input u-input-rectangle" required="" value="${param.password}">
                        </div>
                        <div class="u-form-group u-form-name">
                            <p>Confirm your password:</p>
                            <input type="password" placeholder="Confirm password"  name="confirmPass" class="u-border-1 u-border-grey-30 u-input u-input-rectangle" required="" value="${param.confirmPass}">
                        </div>
                        <div class="u-form-group u-form-name">
                            <p>Enter your email:</p>
                            <input type="email" placeholder="Email"  name="userMail" class="u-border-1 u-border-grey-30 u-input u-input-rectangle" required="" value="${param.userMail}">
                        </div>
                        <div class="u-form-group u-form-name">
                            <p>Enter your phone:</p>
                            <input type="text" placeholder="Phone"  name="userMobile" class="u-border-1 u-border-grey-30 u-input u-input-rectangle" required="" value="${param.userMobile}">
                        </div>
                        <div class="u-form-group u-form-name">
                            <p>Gender:</p>
                            <input type="radio" name="gender" value="Male" <c:if test="${param.gender.equalsIgnoreCase('Male')}">Checked</c:if> > Male
                            <br>
                            <input type="radio" name="gender" value="Female" <c:if test="${param.gender.equalsIgnoreCase('Female')}">Checked</c:if> > Female
                        </div>
                        
                        <div class="u-align-center u-form-group u-form-submit">
                            <button class="u-btn u-btn-submit u-button-style" type="submit">Register</button>
                        </div>
                        <div class="u-align-center u-form-group u-form-submit">
                            <button class="u-btn u-btn-submit u-button-style" >
                                <a href="${contextPath}/index.jsp" style="text-decoration: none;color: white;">Home Page</a>
                            </button>
                        </div>
                        <input type="hidden" name="service" value="register">
                    </form>
                </div>
            </div>
        </header>
    </body>
</html>
