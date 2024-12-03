
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subject List</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <style>
            .subjectCard {
                margin: auto;
                height: 40vh;
                border: 3px solid #73AD21;
                overflow: hidden;
                margin-top: 1vh;
                margin-bottom: 1vh;
                background-color: #FCFFF2;
            }

            .cardThumbnail {
                height: 100%;
            }

            .cardBody {
                display: inline-block;
                padding-top: 10vh;
                text-align: center;
            }

            .thumbNailImg{
                width: 100%;
                height: 100%;
            }
        </style>
    </head>
    <body>
        <div class="wrap">
            <%-- Include header page --%>
            <jsp:include page="header.jsp"/>
            <div class="main">
                <c:choose>
                    <%-- Case 1: subjectList is empty --%>
                    <c:when test = "${empty subjectList}">
                        <div class="row" style="height: 55vh">
                            <h5 style="margin: auto; text-align: center">We currently don't have any course. 
                                <br> Feels Knowledgeable? Contact us and add your own course!</h5>
                        </div>
                    </c:when>
                    <%-- Case 2: subjectList is not empty --%>
                    <c:otherwise>
                        <%--If page is null, set default is 1--%>
                        <c:if test="${empty page}"><c:set var="page" value="1"/></c:if>
                        <%--If max page is null, redirect to servlet subjectList--%>
                        <c:if test="${empty maxPage}"><c:redirect url="${contextPath}/subjectList"/></c:if>
                        <div class="row" style="min-height: 50vh; margin-top: 5vh;">
                            <div class="col-md-2"></div>
                            <div class="col-md-8">
                                <%-- Print available subject --%>
                                <c:forEach items = "${subjectList}" var="subject" begin = "0" end = "${subjectList.size()-1}">
                                    <div class="row subjectCard">
                                        <div class="col-md-5 cardThumbnail">
                                            <%-- Image part of the card --%>
                                            <image class="thumbNailImg" src="${contextPath}/images/${subject.getThumbnail()}" alt="${subject.getThumbnail()}">
                                        </div>
                                        <div class="col-md-1"></div>
                                        <div class="col-md-6 cardBody">
                                            <%-- Body part of the card --%>
                                            <h5>${subject.getSubjectName()}</h5>
                                            <p style="overflow: hidden">${subject.getDescription()}</p>
                                            <a href="subjectController?service=subjectDetail&subjectId=${subject.getSubjectId()}" class="btn btn-primary">Read More</a>
                                        </div>
                                    </div>
                                </c:forEach>
                                <%-- Print Subject placeholder card, same as subject card but the content is default --%>
                                <div class="row subjectCard">
                                    <div class="col-md-5 cardThumbnail">
                                        <image class="thumbNailImg" src="${contextPath}/images/logo.png" alt="logo.png">
                                    </div>
                                    <div class="col-md-1"></div>
                                    <div class="col-md-6 cardBody">
                                        <h5>We need you!</h5>
                                        <p style="overflow: hidden">Feels Knowledgeable? Contact us and add your own course!</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <%--Previous Page--%>
                                <c:choose>
                                    <c:when test="${page > 1}">
                                        <li class="page-item" id="previousPage">
                                            <a class="page-link" href="${contextPath}/subjectList?page=${page-1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item disabled">
                                            <a class="page-link" href="${contextPath}/subjectList?page=${page-1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                                <%--2 buttons before active page--%>
                                <c:forEach var="pageNumber" begin="1" end="${page-1}">
                                    <li class="page-item" id="page${page-pageNumber}"><a class="page-link" href="${contextPath}/subjectList?page=${page-pageNumber}">${page-pageNumber}</a></li>
                                </c:forEach>
                                <%--Active page--%>
                                <li class="page-item active" id="page${page}"><a class="page-link" href="#">${page}</a></li>
                                <%--2 buttons after active page--%>
                                <c:choose>
                                    <c:when test="${maxPape-page >= 2}">
                                        <c:forEach var="pageNumber" begin="1" end="2">
                                            <li class="page-item" id="page${page+pageNumber}"><a class="page-link" href="${contextPath}/subjectList?page=${page+pageNumber}">${page+pageNumber}</a></li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="pageNumber" begin="1" end="${maxPage - page}">
                                            <li class="page-item" id="page${page+pageNumber}"><a class="page-link" href="${contextPath}/subjectList?page=${page+pageNumber}">${page+pageNumber}</a></li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                                
                                <%--Next Page--%>
                                <c:choose>
                                    <c:when test="${page == maxPage}">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="${contextPath}/subjectList?page=${page+1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="${contextPath}/subjectList?page=${page+1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </nav>
                    </c:otherwise>
                </c:choose>
            </div>
            <%-- Include footer page --%>
            <jsp:include page="footer.jsp"/>
        </div>
    </body>
    <script>
        
        <%-- JS to active and inactive button on load --%>
        window.onload{
            if (%{page == 1}){
                document.getElementById("previousPage").className += " disabled";
            }
            if (%{page == maxPage}){
                document.getElementById("nextPage").className += " disabled";
            }
        }
            
    </script>
</html>

