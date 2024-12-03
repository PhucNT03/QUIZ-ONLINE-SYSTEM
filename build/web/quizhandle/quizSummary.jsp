<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Summary</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/quizhandle.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class="infomation" style="">
                <div class='info row' style='display:flex;'>
                    <div class='col-1'>
                        <a type="button" class="btn" href="${contextPath}/quizHandleController?service=quizHandle&quizId=${quizId}&questionNumber=1" style='border:1px solid #4472c4; color:#4472c4;
                           margin-left: 5px;'> Back</a>
                    </div>
                    <div class='col-11'>
                        .
                    </div>
                </div>
            </div>
            <div class="row infomation1" style="">
                .
            </div>
            <div class="container">
                <%-- Clock and  --%>
                <div class="row">
                    <div class="mainContent col-9" style="border-right: 1px solid black;">
                        <c:forEach items="${doingQuiz.getQuestions()}" var="question">
                            <a href="${contextPath}/quizHandleController?service=quizHandle&quizId=${doingQuiz.getQuiz().getQuizId()}&questionNumber=${doingQuiz.getQuestions().indexOf(question)+1}" class="btn allquestions ${question.getAnsweredId()!=0?"btn-secondary answered":"btn btn-light unanswered"}${question.isMarked()==true?" marked":" unmarked"} btn-lg active" id="${question.isMarked()==true?"marked":"unmarked"}" role="button">${doingQuiz.getQuestions().indexOf(question)+1}</a>
                        </c:forEach>   
                    </div>
                    <div class="col-3" style="display:flex;">
                        <div style='margin-top:1px;'>
                            <h4>Your time:&nbsp;</h4>
                        </div>
                        <div class="detail1">
                            <img id="clockImage" src="images/timer.png"> <label for="clockImage">
                                <h3><label id="hours">--</label>:<label id="minutes">--</label>:<label id="seconds">--</label></h3>
                            </label>
                        </div>
                    </div>
                </div>
                <div class='row'>
                    <div class='col-12'style="display:grid;">
                        <button type="button" class="btn scorereview" data-toggle="modal" data-target=".submitthis" style="background-color: #4472c4;border: 1px white solid; color:white;">Score Exam</button>  
                    </div>
                </div>        
            </div>
            <div class="modal fade submitthis" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <c:if test="${answeredNumber==doingQuiz.getQuestions().size() || (answeredNumber < doingQuiz.getQuestions().size() && answeredNumber !=0)}" > 
                                <h5 class="modal-title" id="exampleModalLabel" >Score Exam?</h5>
                            </c:if>
                            <c:if test="${answeredNumber == 0}">
                                <h5 class="modal-title" id="exampleModalLabel">Exit Exam?</h5>
                            </c:if>
                        </div>
                        <div class="modal-body">
                            <c:if test="${answeredNumber == doingQuiz.getQuestions().size()}">
                                By clicking on the [Score Exam] button below, you will complete your current exam and receive your score. You will not 
                                be able to change any answers after this point
                            </c:if>
                            <c:if test="${answeredNumber < doingQuiz.getQuestions().size() && answeredNumber > 0}"> 
                                <div style="display: flex;">
                                    <p style="color:red;" id="numberOfAnswer">${answeredNumber}</p><p style="color:red;">&nbsp;of ${doingQuiz.getQuestions().size()} Questions Answered</p>  
                                </div>
                                By clicking on the [Score Exam] button below, you will complete your current exam and receive your score. You will not 
                                be able to change any answers after this point
                            </c:if>
                            <c:if test="${answeredNumber==0}">
                                You have not answered any question.By clicking on the [Score Exam] button below, you will complete your current exam and receive your score. You will not 
                                be able to change any answers after this point
                            </c:if>
                        </div>
                        <form id='questionForm' action='quizHandleController' method="POST">
                            <input hidden id="time" name="time">  
                            <input hidden name="service" value="submit">
                        </form>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Back</button>
                            <c:choose>
                                <c:when test="${answeredNumber ==0}">
                                    <input onclick="resetTime()" id="reviewSubmit" style="border:1px solid white; color:white; background-color: #4472c4;" class="btn" type="submit" name="action" value="Exit" form="questionForm">
                                </c:when>
                                <c:otherwise>
                                    <input onclick="resetTime()" id="reviewSubmit" style="border:1px solid white; color:white; background-color: #4472c4;" class="btn" type="submit" name="action" value="Score Exam" form="questionForm">
                                </c:otherwise>
                            </c:choose>                         
                        </div>
                    </div>
                </div>
            </div>
            <style>
                #marked{
                    border: 3px solid red;
                }
            </style>
        </div>
    </body>
    <script>

        var minutesLabel = document.getElementById("minutes");
        var secondsLabel = document.getElementById("seconds");
        var hoursLabel = document.getElementById("hours");
        var totalSecond;
        var today = new Date();
        <c:choose>
            <c:when test="${quizType!=3}">
        var endMilisecond = localStorage.getItem("endMiliseconds");
        localStorage.setItem('endMiliseconds', endMilisecond);
        setInterval(setTime, 100);
        function setTime() {
            var today2 = new Date();
            var presentMilisecond = today2.getTime();
            totalSecond = (endMilisecond - presentMilisecond) / 1000;
            displayTime();

        }
        setInterval(autoSubmit, 1500);
        function autoSubmit() {
            if (totalSecond < 1.5) {
                resetTime();
                document.getElementById("questionForm").submit();
            }
        }
            </c:when>
            <c:otherwise>
        var startMilisecond = localStorage.getItem("startMiliseconds");
        localStorage.setItem('startMiliseconds', startMilisecond);
        setInterval(setTime, 100);
        function setTime() {
            var today2 = new Date();
            var presentMilisecond = today2.getTime();
            totalSecond = (presentMilisecond - startMilisecond) / 1000;
            displayTime();

        }
        setInterval(autoSubmit, 1000);
        function autoSubmit() {
            if (totalSecond > 7198) {
                resetTime();
                document.getElementById('questionForm').submit();
            }
        }
            </c:otherwise>
        </c:choose>

        function displayTime() {
            var totalMinute = (totalSecond / 60) % 60;
            var totalHour = totalSecond / 60 / 60;
            secondsLabel.innerHTML = pad(parseInt(totalSecond % 60));
            minutesLabel.innerHTML = pad(parseInt(totalMinute));
            hoursLabel.innerHTML = pad(parseInt(totalHour));
            document.getElementById("time").value = Math.round(totalSecond);
        }
        function resetTime() {
            localStorage.clear();
        }

        function pad(val) {
            var valString = val + "";
            if (valString.length < 2) {
                return "0" + valString;
            } else {
                return valString;
            }
        }
    </script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/9650a62e47.js" crossorigin="anonymous"></script>
</html>
