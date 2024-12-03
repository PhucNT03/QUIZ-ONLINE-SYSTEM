<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
    <head
        <%-- CSS,JSTL--%>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/bootstrapp.min.css" rel="stylesheet">
        <c:set var="contextPath" value="${pageContext.request.contextPath}"/>

    </head>
    <body>
        <div class="container">
            <%--Slide starts here --%>	
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12 nopadding">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <%-- Indicators --%>  
                            <%-- Wrapper for slides --%>
                            <c:choose>
                                <%-- sliderList is empty --%>
                                <c:when test = "${empty sliderList}">
                                    <div class="row">
                                        <h5>No Slide available!</h5>
                                    </div>
                                </c:when>
                                <%-- sliderList not empty --%>
                                <c:otherwise>
                                    <div class="carousel-inner" role="listbox">
                                        <div class="item active">
                                            <c:forEach items = "${sliderList}" var="slider" begin = "0" end = "0">
                                                <a href=""><img style="width: 1500px; height: 800px; object-fit:cover" src="images/${slider.getImage()}" alt=""></a>
                                                <br>
                                            </c:forEach>   
                                        </div>
                                        <c:forEach items = "${sliderList}" var="slider" begin = "1" end = "${sliderList.size()-1}">
                                            <div class="item">
                                                <a href=""><img style="width: 1500px; height: 800px; object-fit:cover" src="images/${slider.getImage()}" alt=""></a>
                                                <br>
                                            </div>
                                        </c:forEach> 
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <%-- Controls --%>
                            <div class="control">
                                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                    <span class="" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                    <span class="" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>               
            <br><hr>
            <div>
                <%-- Print course list --%>
                <h1>Trending Courses</h1>
                <c:choose>
                    <%-- Case 1: subjectList is empty --%>
                    <c:when test = "${empty subjectList}">
                        <div class="row">
                            <h5>We currently don't have any course. Feels Knowledgeable? Contact us and add your own course!</h5>
                        </div>
                    </c:when>
                    <%-- Case 2: subjectList have subject number less than 4 --%>
                    <c:when test = "${subjectList.size()<4}">
                        <div class="row">
                            <%-- Print available subject --%>
                            <c:forEach items = "${subjectList}" var="subject" begin = "0" end = "${subjectList.size()-1}">
                                <div class="col-md-3">
                                    <div class="card h-100">
                                        <img src="images/${subject.getThumbnail()}"style="width: 100%; height: 80%" class="card-img-top" alt="${subject.getSubjectName()}">
                                        <div class="card-body" style="float: bottom">
                                            <h5 class="card-title"><a href="#"><c:out value = "${subject.getSubjectName()}"/></a></h5>
                                            <p class="card-text" style="overflow: hidden"><c:out value= "${subject.getDescription()}"/></p>
                                        </div>
                                        <div class="card-footer">
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <%-- Print Subject placeholder card --%>
                            <c:forEach begin = "${subjectList.size()}" end = "3">
                                <div class="col-md-3">
                                    <div class="card h-100" style="padding: auto">
                                        <div class="card-body">
                                            <h5 class="card-title">Currently Not Available</h5>
                                            <p class="card-text" style="overflow: hidden">Feels Knowledgeable? Contact us and add your own course!</p>
                                        </div>
                                        <div class="card-footer">
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <%-- Case 3: subjectList has 4 or more elements --%>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach items = "${subjectList}" var="subject" begin = "0" end = "${subjectList.size()-1}">
                                <div class="col-md-3">
                                    <div class="card h-100">
                                        <img src="images/${subject.getThumbnail()}" style="width: 100%; height: 80%" class="card-img-top" alt="${subject.getSubjectName()}">
                                        <div class="card-body">
                                            <h5 class="card-title"><a href="#"><c:out value = "${subject.getSubjectName()}"/></a></h5>
                                            <p class="card-text" style="overflow: hidden"><c:out value= "${subject.getDescription()}"/></p>
                                        </div>
                                        <div class="card-footer">
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>


                <div>
                    <form action="subjectList" method="POST">
                        <button type="submit" class="btn btn-default" style="margin: 50px;position: relative;left:43%;border:solid 2px;border-radius: 50px">
                            LOAD MORE</button>
                    </form>

                </div>
            </div>


        </div>
                
        <%--JS--%>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/bootstrapp.min.js"></script>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="https://kit.fontawesome.com/9650a62e47.js" crossorigin="anonymous"></script>
    </body>
</html>
