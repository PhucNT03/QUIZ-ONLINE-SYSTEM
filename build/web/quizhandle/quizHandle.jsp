<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Handle</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/quizhandle.css">
    </head>
    <body onbeforeunload="submitForm()">

        <div class="container-fluid">
            <!--start header-->
            <div class="infomation">
                <div class="info row" style="">
                    <div col-1>
                        <a href="${contextPath}/practiceController?service=getPracticeListInformation" class="goBack" type="button" class="btn" style=""> Go Back</a>
                    </div>
                    <div class="col-11">    
                        <div class="detail">
                            <%-- index of question --%>
                            <div class="detail1">
                                <img id="questionImage" src="images/question.png"> <label for="questionImage">
                                    <h3 style="">${questionNumber}/${doingQuiz.getQuestions().size()}</h3> </label>
                            </div>
                            <%-- Clock --%>
                            <div class="detail1">
                                <img id="clockImage" src="images/timer.png"> <label for="clockImage">
                                    <h3><label id="hours">--</label>:<label id="minutes">--</label>:<label id="seconds">--</label></h3>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row infomation1">
                <div class="col-1">
                    <h6 >${questionNumber})</h6>
                </div>
                <div class="col-11">
                    <h6 style=float:right;'>Question ID: ${questionQH.getQuestion().getQuestionId()}</h6>
                </div>
            </div>
            <!--end header-->

            <%-- Question and Answers --%>
            <div class="mainContent" style="display: flex; height:1000%;">
                <div class="col-1"></div>
                <div class="<c:choose>
                         <c:when test="${questionQH.getQuestion().getMedia()!=null}">
                             col-4
                         </c:when>
                         <c:otherwise>
                             col-10
                         </c:otherwise>
                     </c:choose>" style="">
                    <div class="row question" style="display: flex;">
                        <div class="col-1">

                        </div>
                        <div class="col-11" style="float:right;">

                            <h4>${questionQH.getQuestion().getContent()}</h4>
                        </div>
                    </div>

                    <div class="row answers" style="margin-top:10px;">
                        <div class="col-1"></div>
                        <div class="col-11">
                            <form id='questionForm' action='${contextPath}/quizHandleController?service=quizHandle&quizId=${quizId}&questionNumber=${questionNumber}' method='POST'>
                                <ul>

                                    <c:forEach items="${questionQH.getAnswerList()}" var="answer">
                                        <div class="checkbox-inline" style="display: -webkit-inline-box;">
                                            <label class="labelA" for="${answer.getAnswerId()}">
                                                <li style="margin-left: 30px;">
                                                    ${answer.getAnswerContent()} 
                                                </li>

                                                <input type="radio" name="answerTakenId" value="${answer.getAnswerId()}" id="${answer.getAnswerId()}" ${answer.getAnswerId()==questionQH.getAnsweredId()?"checked":""} class="radioAnswer">
                                                <span class="checkmark"></span>
                                            </label>

                                        </div>
                                        <br/>
                                    </c:forEach>
                                </ul>    
                                <%-- Neu he thong tu dong nop bai thi value = "yes" --%>
                                <input hidden id="autoSubmit" name="autoSubmit" form="questionForm">
                                <input hidden name="questionTakenNumber" value="${questionNumber}" form="questionForm">
                                <%-- Thoi gian lam bai --%>
                                <input hidden id="time" name="time" form="questionForm">
                            </form>    
                        </div>


                        <div class="col-1"></div>
                    </div>
                </div>
                <%-- Image or Video linked with the question--%>
                <c:if test="${questionQH.getQuestion().getMedia()!=null}">
                <div class="right col-7" style="">
                    
                        <div style="">
                            <c:if test="${mediaType==2}">
                                <iframe width="420" height="315" style="width:100%; height:400px;"
                                        src=${questionQH.getQuestion().getMedia()}>
                                </iframe>
                            </c:if>
                            <c:if test="${mediaType==1}">
                                <img src="${questionQH.getQuestion().getMedia()}" style="width:100%; height:400px;">
                            </c:if>
                        </div>
                   
                </div>
                 </c:if>
            </div>
            <!--                           end mainContent-->
            <!--            peek and mark question-->

            <div class="funtion fixed-bottom" style="margin-bottom: 70px; margin-left: 10px;"> 
                <div class='row'>
                    <div class="col-4">
                        <div style="float:left; display:flex;">

                            <form id="markForm" action="${contextPath}/quizHandleController?service=quizHandle&quizId=${quizId}&questionNumber=${questionNumber}" method="POST">
                                <button class="btn " onclick="this.form.submit()">Mark For Review</button>
                                <input hidden name="marked" value="yes">
                            </form>
                        </div>
                    </div>
                    <div class="col-5">
                        <div style="margin-left: 50px;display: flex;">                    
                            <c:if test="${questionNumber!=1}">
                                <input class="btn" type="submit" name='action' value='Previous Question' form='questionForm'>
                            </c:if>
                            <c:if test="${questionNumber!=quiz.size()}">
                                <input class="btn" type='submit' name='action' value='Next Question' form="questionForm">
                            </c:if>
                            <c:if test="${questionNumber==quiz.size()}">
                                <input type="submit" class="btn" name="action" value="Finish Exam" form="questionForm" >
                            </c:if>
                        </div>
                    </div>
                    <div class="col-3">

                    </div>
                </div>
            </div>
            <!--                        peek modal-->
            <div class="modal fade bd-example-modal-sm" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Peek At Answer</h5>                           
                        </div>
                        <div class="modal-body">
                            The correct Answer is: ${trueAnswer}<br/><br/>
                            Explanation: ${questionQH.getQuestion().getExplanation()}
                        </div>
                        <div class="modal-footer">
                            Source
                        </div>
                    </div>
                </div>
            </div>
            <!--                        end peek modal-->
            <div class="funtionBar fixed-bottom" style='height:70px; background-color: #4472c4;'>
                <div style="margin-left: 43%; margin-top:20px; <c:if test="${quizType==3}"> display:flex; margin-left: 31%;</c:if>">
                        <div>
                        <c:if test="${quizType==3}">                               
                            <button style="margin-right: 3px;border: 1px solid #4472c4;color:#4472c4;background:#ffffff;" type="button" class="btn" data-toggle="modal" data-target=".bd-example-modal-sm">Peek At Answer</button>
                        </c:if>
                    </div>
                    <div>
                        <button  type="button" class="btn" data-toggle="modal" data-target=".bd-example-modal-xl">Review Progress</button>                      
                    </div>
                </div>
            </div>
            <div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
                <style>

                </style>
                <%-- Review Progress modal --%>
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div>
                                <h5 class="modal-title" id="exampleModalLabel">Review Progress</h5>
                                <br/>
                                <h7>Review before score</h7>
                            </div>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>

                        </div>
                        <div class="modal-body">
                            <div>
                                <input type="image" id="unansweredbutton"  src="images/unanswered.png" alt="Submit Form" />
                                <input type="image" id="markedbutton" src="images/marked.png " alt="Submit Form" />
                                <input type="image" id="answeredbutton" src="images/answered.png" alt="Submit Form" />
                                <input type="image" id="allquestionsbutton" src="images/allquestions.png" alt="Submit Form" />
                                <input type="submit" class="btn scorereview" name='action' value='Finish Exam' style="float:right;background-color: #4472c4;border: 1px white solid; color:white" form='questionForm'>
                            </div>
                            <br/><br/>
                            <div class="holder" style='margin-left:20px'>
                                <c:forEach items="${requestScope.quiz}" var="question">
                                    <input type="submit" name="action" form="questionForm" class="btn allquestions ${question.getAnsweredId()!=0?"btn-secondary answered":"btn btn-light unanswered"}${question.isMarked()==true?" marked":" unmarked"} btn-lg active" id="${question.isMarked()==true?"marked":"unmarked"}" role="button" value="${quiz.indexOf(question)+1}">
                                </c:forEach>                             
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <script>
            var minutesLabel = document.getElementById("minutes");
            var secondsLabel = document.getElementById("seconds");
            var hoursLabel = document.getElementById("hours");
            var totalSecond;
            var today = new Date();
            <%-- countDown timer  --%>
            <c:choose>
                <c:when test="${quizType!=3}">
            var endMilisecond;
            if (localStorage.getItem("endMiliseconds") != null) {
                endMilisecond = localStorage.getItem("endMiliseconds");
            } else {
                endMilisecond = today.getTime() +${duration*1000};
            }
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
                    document.getElementById("autoSubmit").value = "yes";
                    document.getElementById("questionForm").submit();
                }
            }
                </c:when>
                <%--End countDown timer  --%>
                <c:otherwise>
                <%-- countUp timer  --%>
            var startMilisecond;
            if (localStorage.getItem("startMiliseconds") != null) {
                startMilisecond = localStorage.getItem("startMiliseconds");
            } else {
                startMilisecond = today.getTime();
            }
            localStorage.setItem('startMiliseconds', startMilisecond);
            setInterval(setTime, 100);
            function setTime() {
                var today2 = new Date();
                var presentMilisecond = today2.getTime();
                totalSecond = ((presentMilisecond - startMilisecond) / 1000);
                displayTime();
            }
            setInterval(autoSubmit, 1000);
            function autoSubmit() {
                if (totalSecond > 7198) {
                    document.getElementById("autoSubmit").value = "yes";
                    document.getElementById('questionForm').submit();
                }
            }
            <%--  End countUp timer  --%>
                </c:otherwise>
            </c:choose>
            function displayTime() {
                var totalMinute = (totalSecond / 60) % 60;
                var totalHour = totalSecond / 60 / 60;
                secondsLabel.innerHTML = pad(parseInt(totalSecond % 60));
                minutesLabel.innerHTML = pad(parseInt(totalMinute));
                hoursLabel.innerHTML = pad(parseInt(totalHour));
                document.getElementById('time').value = Math.round(totalSecond);
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
            <%-- filter Question  --%>
            const unanswered = document.getElementById('unansweredbutton');
            const marked = document.getElementById('markedbutton');
            const answered = document.getElementById('answeredbutton');
            const allquestions = document.getElementById('allquestionsbutton');
            unanswered.addEventListener("click", () => {
                var y = document.getElementsByClassName("allquestions");
                var i;
                for (i = 0; i < y.length; i++) {
                    y[i].style.display = 'inline-flex';
                }
                var x = document.getElementsByClassName("answered");
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = 'none';
                }
            });
            marked.addEventListener("click", () => {
                var y = document.getElementsByClassName("allquestions");
                var i;
                for (i = 0; i < y.length; i++) {
                    y[i].style.display = 'inline-flex';
                }
                var x = document.getElementsByClassName("unmarked");
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = 'none';
                }
            });
            answered.addEventListener("click", () => {
                var y = document.getElementsByClassName("allquestions");
                var i;
                for (i = 0; i < y.length; i++) {
                    y[i].style.display = 'inline-flex';
                }
                var x = document.getElementsByClassName("unanswered");
                for (i = 0; i < x.length; i++) {
                    x[i].style.display = 'none';
                }
            });
            allquestions.addEventListener("click", () => {
                var y = document.getElementsByClassName("allquestions");
                var i;
                for (i = 0; i < y.length; i++) {
                    y[i].style.display = 'inline-flex';
                }
            });
            
            function goBack(){
                history.back();
            }
            <%--  End filter question  --%>
        </script>


    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/9650a62e47.js" crossorigin="anonymous"></script>
</html>
