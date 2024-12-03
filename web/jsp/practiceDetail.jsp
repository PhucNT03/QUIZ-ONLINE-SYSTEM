<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>

    <body>
        <%-- Check If user is logged in or not, if not redirect to index --%>
        <c:if test="${sessionScope.currUser == null}">
            <c:redirect url="/index.jsp"/>
        </c:if>

        <c:if test="${sessionScope.doingQuiz != null}">
            <c:redirect url="${contextPath}/practiceController?service=getPracticeListInformation"/>
        </c:if>
        <%-- Check If user registedSubject is avaiable not, if not redirect to load information --%>
        <c:if test="${registedSubject == null}">
            <c:redirect url="/practiceController?service=getPracticeDetail"/>
        </c:if>        
        <%-- Include header page --%>
        <jsp:include page="/jsp/header.jsp"/>
        <div class="main">

            <%-- Login form --%>
            <div class="container" style="align-self: center; min-height: 50vh">
                <%-- Start form --%>
                <form action="${contextPath}/practiceController" method="POST">
                    <div class="row">
                        <%-- Bootstrap to center form --%>
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <h1>Practice Detail</h1>
                            <label class="label control-label">Subject</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <select class="form-control" name="subject">
                                    <c:forEach items="${registedSubject}" var="subject">
                                        <option value="${ subject.getSubjectId()}" onclick=""><c:out value="${subject.getSubjectName()}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                            <label class="label control-label">Number Of Question</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input class="form-control" type="number" name="numberOfQuestion" min="1" max="30" required="">
                            </div>
                            <label class="label control-label"> Dimension </label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <select class="form-control" name="dimension">
                                    <c:forEach items="${dimensionTypes}" var="dimensionType">
                                        <option value="${ dimensionType.getDimensionTypeId()}"><c:out value="${dimensionType.getDimensionTypeName()}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                            <label class="label control-label">Duration (in minute)</label>
                            <div class="form-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input class="form-control" type="number" name="duration" min="1" max="60" required="">
                            </div>
                            <%-- Display messages, if any --%>
                            <div>
                                <c:if test="${message != null}" >
                                    <h4 style="color:red"> <c:out value="${message}"/> </h4>
                                </c:if>
                            </div>
                            <br>
                            <%-- Submit form --%>
                            <div class="input-group" style="justify-content: center" >
                                <button onclick ="resetTime()" type="submit" id="submit" class="btn btn-success">Practice</button>
                                <input type="hidden" name="service" value="createPractice">
                            </div>
                        </div>
                    </div>
                </form> 
            </div>

        </div>
        <%-- Include footer page --%>
        <jsp:include page="/jsp/footer.jsp"/>
    </body>
    <script>
        function resetTime() {
            localStorage.clear();
        }
    </script>
</html>
