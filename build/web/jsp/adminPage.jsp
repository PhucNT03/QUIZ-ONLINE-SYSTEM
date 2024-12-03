<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${contextPath}/css/adminPage.css"/>
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
        <%-- Include header page --%>
        <jsp:include page="/jsp/header.jsp"/>

        <div class="wrap text-center">
            <c:if test="${sessionScope.role.getUserRoleName().equalsIgnoreCase('Expert')}">
                <a href="${contextPath}/jsp/quizDetail.jsp" style="text-decoration: none;color:black" >
                    <div class="big-button">
                        <span class="fas fa-user-shield">Create quiz</span>  
                    </div>
                </a>
                <a href="${contextPath}/jsp/quizList.jsp" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Quiz List Page</span>  
                    </div> 
                </a>
                <a href="${contextPath}/courseContentList" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Course Content List</span>  
                    </div> 
                </a>
                <a href="${contextPath}/jsp/questionList.jsp" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Question List</span>  
                    </div> 
                </a>
            </c:if>
            <c:if test="${sessionScope.role.getUserRoleName().equalsIgnoreCase('admin')}">
                <a href="${contextPath}/userList" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">User List</span>  
                    </div>
                </a>      
                <a href="${contextPath}/jsp/settingList.jsp" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Setting List</span>  
                    </div>
                </a>
                <a href="${contextPath}/dashboard" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Dashboard</span>  
                    </div>
                </a>
            </c:if>

            <!--            <%--<c:if test="${ sessionScope.role.getUserRoleName().equalsIgnoreCase('admin') || sessionScope.role.getUserRoleName().equalsIgnoreCase('Marketing')}">--%>
                            <a href="${contextPath}/jsp/postDetail.jsp" style="text-decoration: none;color:black" >
                                <div class="text-center big-button">
                                    <span class="fas fa-user-shield">Create Post</span>  
                                </div>
                            </a>-->
            <%--</c:if>--%>

            <c:if test="${(role.getUserRoleName().equalsIgnoreCase('admin') || role.getUserRoleName().equalsIgnoreCase('sale'))}">
                <a href="${contextPath}/jsp/registrationList.jsp" style="text-decoration: none;color:black" >
                    <div class="text-center big-button">
                        <span class="fas fa-user-shield">Registration List</span>  
                    </div>
                </a>
            </c:if> 
        </div>
        <c:if test="${ !sessionScope.role.getUserRoleName().equalsIgnoreCase('admin') && !sessionScope.role.getUserRoleName().equalsIgnoreCase('Expert')}">
            <h2 style="text-align: center;">You don't have the right to access this page</h2>
        </c:if>
        <%-- Include footer page --%>
        <jsp:include page="/jsp/footer.jsp"/>
    </body>
</html>
