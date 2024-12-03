<%-- 
    Copyright(C) 2021, Group Tree - SWP391, SE1509, FA21
    Created on : Nov,3 2021, 11:46:32 PM
    Display subject list in cards
    Quiz practicing system

    Record of change:
    Date        Version     Author          Description
    3/10/21     1.0         TungBTHE150621  First Deploy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${subject.getSubjectName()}</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <style>


            /* Button used to open the contact form  */
            .open-button {
                background-color: #555;
                color: white;
                padding: 16px 20px;
                border: none;
                cursor: pointer;
                opacity: 0.8;
                position: center;

                right: 28px;
                width: 280px;
            }



            /* Add some hover effects to buttons */
            .form-container .btn:hover, .open-button:hover {
                opacity: 1;
            }
        </style>

    </head>
    <body>
        <jsp:include page="header.jsp"/>


        <div class="container-fluid" style="border-top: 1px black solid;">



            <div class="row">
                <div class="right col-9">
                    <c:set var="thisSubject" value="${subject}"/>

                    <div class="title row">
                        <h4>${subject.getSubjectName()}</h4>
                    </div>
                    <hr>
                    <div class="content row" style="text-align: justify;">

                        <p>${subject.getDescription()}</p>

                    </div>

                    <%--<div class="content row" style="text-align: justify;">
                        <c:forEach items = "${pricePackage}" var="pricePackage" begin = "0" end = "2">
                            <h3>${pricePackage.getAllPricePackagesBySubject()}</h3>
                            </c:forEach>


                    </div>--%>
                    <div class="content row" style="text-align: justify;">
                        <c:forEach items="${requestScope.quizs}" var="i">
                            <div class="col-3">
                                <a href="${contextPath}/practiceController?subject=${requestScope.subject.subjectId}&dimension=${requestScope.subject.subjectId}&service=createPractice&duration=${i.quizDuration}&numberOfQuestion=${i.numberQuestion}">${i.quizName}</a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

        </div>
    </div>

</body>
<jsp:include page="footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>
