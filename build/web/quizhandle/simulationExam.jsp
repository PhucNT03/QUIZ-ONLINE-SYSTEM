<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Simulation Exam</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    </head>
    <jsp:include page="/jsp/header.jsp"/>
    <body>
        <div class="container" style="margin-bottom: 300px;">
            <div class="row functions" style="margin-top: 30px;">
                <div class="col-1">
                    <h5 style="float:right; margin-top: 6px;">Subject:</h5>
                </div>
                <div class="col-3">
                    <div class="dropdown show" style="">
                        <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <c:choose>
                                <c:when test="${subjectSearchName!=null}">
                                    ${subjectSearchName}
                                </c:when>
                                <c:otherwise>
                                    Search by subject
                                </c:otherwise>
                            </c:choose>
                        </a> 
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <a class="dropdown-item" href="${contextPath}/simulationExamController">All</a>
                            <c:forEach items="${subjectList}" var="subject">
                                <a class="dropdown-item" href="${contextPath}/simulationExamController?subjectSearchId=${subject.getSubjectId()}">${subject.getSubjectName()}</a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="input-group">
                        <form action="simulationExamController" method="GET">
                            <div style="display: flex;">
                                <h6 style="color:red;">${errorMess}</h6>
                                <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search"
                                       aria-describedby="search-addon" name="searchQuizName" value="${searchQuizName}" />
                                <input hidden name="subjectSearchId" value="${subjectSearchId}">
                                <input hidden name="service" value="simulationExam">    
                                <button onclick="submit()" type="button" class="btn btn-success">search</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="row table table-bordered table-striped" style="margin-top: 10px;">
                <table>
                    <tr class="" style="background-color: #F0D8D5;">
                        <th>Id</th>
                        <th>Subject</th>
                        <th>Simulation Exam</th>
                        <th>Level</th>
                        <th>#Question</th>
                        <th>Duration</th>
                        <th>Pass Rate</th>   
                        <th>Action</th>
                    </tr>
                    <c:choose>
                        <c:when test="${!empty simulationList}">
                            <c:forEach items="${simulationList}" var="quiz">
                                <tr>
                                    <td>${quiz.getQuizId()}</td>
                                    <td>${quiz.getSubject().getSubjectName()}</td>
                                    <td>${quiz.getQuizName()}</td>
                                    <td>${quiz.getQuizLevelName()}</td>
                                    <td>${quiz.getNumberQuestion()}</td>
                                    <td>${quiz.getQuizDuration()}</td>
                                    <td>${quiz.getPassRate()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${doingQuiz!=null&&currUser.getUserId()==doingQuiz.getUser().getUserId()}">
                                                <button style="" data-toggle="modal" data-target="#ModalCenter${quiz.getQuizId()}" ${doingQuiz.getQuiz().getQuizId()==quiz.getQuizId()?"":"disabled"}>${doingQuiz.getQuiz().getQuizId()==quiz.getQuizId()?"Continue":"Currently Taking Another Exam"}</button>   
                                            </c:when>
                                            <c:otherwise>
                                                <button style="" data-toggle="modal" data-target="#ModalCenter${quiz.getQuizId()}">Take Exam</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>

                            </c:forEach>
                            <style>
                                button{
                                    background-color: #4472c4;border: 1px white solid; color:white;
                                }
                                button:disabled,
                                button[disabled]{
                                    opacity: 0.5;
                                }
                            </style>
                        </c:when>
                        <c:otherwise>
                            <tr>
                            <text style="color:red;">There is no simulation exam</text>
                            </tr>
                        </c:otherwise>
                    </c:choose>

                </table>
                <c:forEach items="${simulationList}" var="quiz">
                    <div style="" class="modal fade" id="ModalCenter${quiz.getQuizId()}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content" style="background-color:white;">
                                <div class="modal-header" >
                                    <h5 class="modal-title" id="exampleModalLongTitle">${quiz.getQuizName()}</h5><h5 style="margin-top:9px; margin-left: 80px;"> ${quiz.getSubject().getSubjectName()}</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    ${quiz.getNumberQuestion()} questions &nbsp;&nbsp; Dimension:&nbsp; ${quiz.getDimensionTypeName()}
                                </div>

                                <div class="modal-footer">  
                                    <c:choose>
                                        <c:when test="${doingQuiz!=null&&currUser.getUserId()==doingQuiz.getUser().getUserId()}">
                                            <input type="submit" class="btn btn-primary" value="Continue Exam" form="${quiz.getQuizId()}">
                                        </c:when>
                                        <c:otherwise>
                                            <input onclick="resetTime()" type="submit" class="btn btn-primary" value="Take Exam" form="${quiz.getQuizId()}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <form id="${quiz.getQuizId()}" action="${contextPath}/quizHandleController?service=quizEntrance" method="POST">
                            <input hidden name="quizId" value="${quiz.getQuizId()}" class="btn">
                        </form>
                    </div>
                </c:forEach>


            </div>
        </div>
    </body>
    <script>
        function resetTime() {
            localStorage.clear();
        }

    </script>
    <jsp:include page="/jsp/footer.jsp"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/9650a62e47.js" crossorigin="anonymous"></script>

</html>
