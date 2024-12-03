<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quiz Review</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/quizhandle.css">
    </head>
    <body>

        <div class="container-fluid">
            <%-- Start Header --%>
            <div class="infomation">
                <div class="info row" style="">
                    <div col-1>        
                        <a href="${contextPath}/practiceController?service=getPracticeListInformation" class="goBack" type="button" class="btn" style="" onclick=""> Go Back</a>
                    </div>
                    <%-- Cac thong tin: diem so, thoi gian lam, thoi gian nop --%>
                    <div class="col-6" style="display:flex;">    
                        <h6>Score: ${requestScope.score}/100</h6>

                        <h6 style="margin-left:30px;">Start: ${requestScope.startedAt}</h6>
                        <h6 style="margin-left:30px;">Submit: ${requestScope.submitedAt}</h6>
                    </div>
                    <div class="col-5">
                        <div class="detail">
                            <div class="detail1">
                                <img id="questionImage" src="images/question.png"> <label for="questionImage">
                                    <h3 style="">${questionNumber}/${quizSize}</h3> </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Thong tin cau hoi --%>
            <div class="row infomation1">
                <div class="col-1">
                    <h6 >${questionNumber})</h6>
                </div>
                <div class="col-11">
                    <h6 style=float:right;'>Question ID: ${questionId}</h6>
                </div>
            </div>
            <%-- End Header --%>
            <style>
                ul li::marker {
                    font-weight: bold;
                }
            </style>
            <%-- Question and Answers --%>
            <div class="mainContent" style="display: flex;">

                <div class="<c:choose>
                         <c:when test="${questionQH.getQuestion().getMedia()!=null}">
                             col-4
                         </c:when>
                         <c:otherwise>
                             col-10
                         </c:otherwise>
                     </c:choose> style="">
                    <div class="row question" style="display: flex;">
                        <div class="col-2">
                        </div>
                        <div class="col-10" style="float:right;">
                            <h4>${questionQH.getQuestion().getContent()}</h4>
                        </div>
                    </div>
                    <div class="row answers" style="margin-top:10px;">

                        <div class="col-12" >
                            <form id='questionForm' action='${contextPath}/quizHandleController?service=quizHandle&quizId=${quizId}&questionNumber=${questionNumber}' method='POST'>
                                <ul style=''>
                              
                                    <c:forEach items="${questionQH.getAnswerList()}" var="answer">
                                        <div class='row'>
                                            <div class='col-3' style="">
                                                <c:if test="${answer.getAnswerId()==answered}">
                                                    <div style="float:right;">
                                                    <img src="images/youranswer.png" style='width:80px;height: auto;'>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="col-9 ${answer.getAnswerId()==answered?"":"wrong"}" style="display: -webkit-inline-box;">
                                                <label class="labelA" for="${answer.getAnswerId()}">
                                                    <li style="margin-left: 30px;">
                                                        ${answer.getAnswerContent()} 
                                                    </li>
                                                    <input type="radio" name="answerTakenId" value="${answer.getAnswerId()}" id="${answer.getAnswerId()}" ${answer.getAnswerId()==questionQH.getAnsweredId()?"checked":""} ${answer.getAnswerId()==answered?"":"disabled"} class="radioAnswer">
                                                    <span class="checkmark"></span>
                                                </label>                                          
                                                <c:if test="${answer.isIsCorrect()}">
                                                    <img src="images/right.png" style='width:25px;height: 25px;'>
                                                </c:if>
                                                <c:if test="${!answer.isIsCorrect()}">
                                                    <img src="images/wrong.png" style='width:25px;height: 25px;'>
                                                </c:if>
                                            </div>
                                            <br/>
                                        </div>
                                    </c:forEach>
                                </ul>

                                <input hidden id="formAction" name="finalAction" form="questionForm">
                                <input hidden name="questionTakenNumber" value="${questionNumber}" form="questionForm">
                                <input hidden id="time" name="time" form="questionForm">
                            </form>    
                        </div>
                        <div class="col-1"></div>
                    </div>
                </div>
                <%-- Video or Image related with this question --%>
                <c:if test="${questionQH.getQuestion().getMedia()!=null}">
                    <div class="right col-8" style="">

                        <div style="">
                            <c:if test="${mediaType==2}">
                                <iframe width="420" height="315" style="width:100%; height:450px;"
                                        src=${questionQH.getQuestion().getMedia()}>
                                </iframe>
                            </c:if>
                            <c:if test="${mediaType==1}">
                                <img src="${questionQH.getQuestion().getMedia()}" style="width:100%; height:auto;">
                            </c:if>
                        </div>

                    </div>
                </c:if>
            </div>
            <%-- End main content --%>
            <%-- Function bar --%>
            <div class="modal fade eplain" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <%-- Explaination button --%>
                            <h5 class="modal-title" id="exampleModalLabel">Explanation</h5>                           
                        </div>
                        <div class="modal-body">
                            Explanation: ${explanation}
                        </div>
                        <div class="modal-footer">
                            Source
                        </div>
                    </div>
                </div>
            </div>
            <%-- Next,previous question --%>
            <div class="funtionBar fixed-bottom" style='height:70px; background-color: #4472c4;'>
                <div style="margin-top:20px;margin-right: 20px;">
                    <div style="float:right;">
                        <button type="button" class="btn" data-toggle="modal" data-target=".eplain" >Explanation</button>
                        <c:if test="${questionNumber!=1}">
                            <a class="btn" href="${contextPath}/quizHandleController?service=quizReview&quizTakeId=${quizTakeId}&questionNumber=${questionNumber-1}">Previous Question</a>
                        </c:if>
                        <c:if test="${questionNumber!=quizSize}">
                            <a class="btn" href="${contextPath}/quizHandleController?service=quizReview&quizTakeId=${quizTakeId}&questionNumber=${questionNumber+1}">Next Question</a>
                        </c:if>
                        <c:if test="${questionNumber==quizSize}">
                            <button type="button" class="btn" data-toggle="modal" data-target=".submit" >Finish Review</button>
                        </c:if>
                    </div>
                    <div >
                        <button  type="button" class="btn" data-toggle="modal" data-target=".bd-example-modal-xl">Review Results</button>                      
                    </div>
                </div>
            </div>
            <div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
                <style>

                </style>
                <%-- Review Results modal --%>
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div>
                                <h5 class="modal-title" id="exampleModalLabel">Review Results</h5>
                                <br/>
                                <h7>Review your quiz results</h7>
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

                                <button type="button" class="btn scorereview" data-toggle="modal" data-target=".submit" style="float:right;background-color: #4472c4;border: 1px white solid; color:white;">Finish Review</button>
                            </div>
                            <br/><br/>
                            <div class="holder" style='margin-left:20px'>
                                <c:forEach items="${requestScope.quizReview}" var="question">
                                    <a href="${contextPath}/quizHandleController?service=quizReview&quizTakeId=${quizTakeId}&questionNumber=${quizReview.indexOf(question)+1}" class="btn allquestions ${question.getAnsweredId()!=0?"btn-secondary answered":"btn btn-light unanswered"}${question.isMarked()==true?" marked":" unmarked"} btn-lg active" id="${question.isMarked()==true?"marked":"unmarked"}" role="button">${quizReview.indexOf(question)+1}</a>
                                </c:forEach>                             
                            </div>
                            <style>
                                #marked{
                                    border:red 3px solid;                                  
                                }
                                #reviewSubmit{
                                    background-color: #4472c4;border: 1px white solid; color:white;
                                }
                            </style>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Finish Review modal --%>
            <div class="modal fade submit" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">                   
                            <h5 class="modal-title" id="exampleModalLabel">Finish Review?</h5>        
                        </div>
                        <div class="modal-body">
                            By clicking on the [Finish Review] button below, you will complete your current review. You will
                            be taking back to the customer quiz screen
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Back</button>
                            <a href="homeController" id="reviewSubmit" class="btn">Finish Review</a>                              
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
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
                var i;
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
                var i;
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
                var i;
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
        </script>


    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/9650a62e47.js" crossorigin="anonymous"></script>
</html>
