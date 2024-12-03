<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Details</title>
        <%-- CSS,JS--%>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" ></script>
        <link rel="stylesheet" href="${contextPath}/css/questionDetails.css">
    </head>

    <body>
        <%-- Check If user is logged in or not, if not redirect to index --%>
        <c:if test="${sessionScope.currUser == null}">
            <c:redirect url="/index.jsp"/>
        </c:if>
        <%-- Include header page --%>
        <jsp:include page="/jsp/header.jsp"/>
        <c:if test="${ sessionScope.role.getUserRoleName().equalsIgnoreCase('admin')}">
            <%-- Check If user registedSubject is avaiable not, if not redirect to load information --%>
            <c:if test="${empty listUser || empty listPackage}">
                <c:redirect url="/registrationController?service=getInformationDetail"/>
            </c:if>        
            <div class="main">
                <%-- Login form --%>
                <div class="container" style="align-self: center; min-height: 50vh">
                    <%-- Start form --%>
                    <form action="${contextPath}/registrationController" method="POST">
                        <div class="row">
                            <%-- Bootstrap to center form --%>
                            <div class="col-md-3"></div>
                            <div class="col-md-6">
                                <h1>Registration Detail</h1>

                                <div class="form-group"><label class="label control-label">User</label>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </span>
                                    <select class="form-control" name="userId">
                                        <option value="0">Choose</option>
                                        <c:forEach items="${listUser}" var="user">
                                            <option value="${user.getUserId()}"><c:out value="${user.getUserName()}" /></option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group"><label class="label control-label">Package</label>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </span>
                                    <select class="form-control" name="packageId">
                                        <option value="0">Choose</option>
                                        <c:forEach items="${listPackage}" var="package">
                                            <option value="${package.getPackId()}"><c:out value="${package.getPackName()}" /></option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div style="width: 50%;float: left;padding-right: 10px;">
                                    <label class="label control-label">Valid From</label>
                                    <div class="form-group">
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-user"></span>
                                        </span>
                                        <input class="input-white" type="date" name="validFrom" required>
                                    </div>
                                </div>                               

                                <%-- Display messages, if any --%>
                                <div>
                                    <c:if test="${message != null}" >
                                        <h5 style="color:red"> <c:out value="${message}"/> </h5>
                                    </c:if>
                                </div>
                                <br>
                                <%-- Submit form --%>
                                <div class="input-group" >
                                    <button style="margin-left: auto; margin-right: auto; " type="submit" id="submit" class="btn btn-success">Submit</button>
                                    <input type="hidden" name="service" value="addRegistration">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

            </c:if>
            <c:if test="${ !sessionScope.role.getUserRoleName().equalsIgnoreCase('admin')}">
                <h2 style="text-align: center;">You don't have the right to access this page</h2>
            </c:if>
            <%-- Include footer page --%>
            <jsp:include page="/jsp/footer.jsp"/>
    </body>
</html>
