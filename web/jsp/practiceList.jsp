<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Practice List</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" ></script>
        <link rel="stylesheet" href="${contextPath}/css/questionList.css">
        <script src="${contextPath}/js/questionList.js"></script>
    </head>
    <body>
        <div class="wrap">
            <%-- Check If user is logged in or not, if not redirect to index --%>
            <c:if test="${sessionScope.currUser == null}">
                <c:redirect url="/index.jsp"/>
            </c:if>
            <%-- Check If user registedSubject is avaiable not, if not redirect to load information --%>
            <c:if test="${registedSubject == null}">
                <c:redirect url="/practiceController?service=getPracticeListInformation"/>
            </c:if>   
            <%-- Include header page --%>
            <jsp:include page="header.jsp"/>

            <%-- Check If listFilterSubject,listFilterDimension,listFilterLesson is avaiable not, if not redirect to load information --%>
            <div class="row" style="margin-top: 3rem">
                <div class="col-md-1"></div>
                <div class="col-md-10" >
                    <div class="col-md-12">
                        <h1>Practice List</h1>
                        <form action="${contextPath}/practiceController?service=filterPracticeListInformation" method="get">
                            <select class="form-control" name="subjectId" style="width: 30%;float: left;">                                
                                <option value="0" selected="">Choose...</option>
                                <c:forEach items="${registedSubject}" var="subject">
                                    <option value="${subject.getSubjectId()}"><c:out value="${subject.getSubjectName()}" /></option>                          
                                </c:forEach>                          
                            </select>
                            <input type="hidden" name="service" value="filterPracticeListInformation">
                            <button type="submit" id="submit" class="btn btn-success" style="float: left;">Search</button>
                        </form>
                        <c:if test="${doingQuiz==null}"><a href="${contextPath}/jsp/practiceDetail.jsp"><button class="btn btn-success" style="float: right;margin: 10px;">New Practice</button></a></c:if>
                        <c:if test="${doingQuiz!=null}"><a href="${contextPath}/jsp/practiceDetail.jsp"><button class="btn btn-success" disabled style="float: right;margin: 10px;">Currently taking another quiz</button></a></c:if>
                        <a href="${contextPath}/simulationExamController"><button class="btn btn-success" style="float: right;margin: 10px;">Simulation Exam</button></a>
                    </div>
                    <div class="col-md-12" style="clear: both;">
                        <div class="container">
                            <%-- Table Container --%>
                            <div class="form-group">
                                <h5>Select Number of Rows</h5>
                                <%-- Select number of Rows show on table --%>
                                <select class  ="form-control" name="state" id="maxRows" style="width: 150px;">
                                    <option value="5000">Show All</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                    <option value="50">50</option>
                                    <option value="70">70</option>
                                    <option value="100">100</option>
                                </select>
                            </div>
                            <%-- Table of QuestionList--%>
                            <table id="table-id" class="table table-bordered table-striped">
                                <thead>
                                    <%-- Headers of Table--%>
                                    <tr style="background-color: #F0D8D5;">
                                        <th>Brief Information</th>
                                        <th>Test type</th>
                                        <th>Date taken</th>
                                        <th>Duration</th>
                                        <th>Score</th>
                                        <th>Detail</th>
                                </thead>
                                <tbody>
                                    <%-- Check if listQuestionManage not null then display listQuestionManage --%>
                                    <c:if test="${doingQuiz!=null}">
                                        <tr>
                                            <td>
                                                Subject name: <c:out value="${doingQuiz.getSubject().getSubjectName()}"/>
                                                <br>
                                                Exam name: 
                                                <c:if test="${doingQuiz.getQuizName() == null}">
                                                    None
                                                </c:if>
                                                <c:if test="${doingQuiz.getQuizName() != null}">
                                                    <c:out value="${doingQuiz.getQuizName()}"/>
                                                </c:if>
                                            </td>
                                            <td>${doingQuiz.getTestTypeName()}</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td><a href="${contextPath}/quizHandleController?service=quizHandle"> Continue </a></td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${empty customerQuizs}">
                                        <tr style="color: red"><td colspan="6">No Taken Test Found</td></tr>
                                    </c:if>
                                    <c:if test="${!empty customerQuizs}">
                                        <c:forEach items="${customerQuizs}" var="quiz">
                                            <tr>
                                                <td>
                                                    Subject name: <c:out value="${quiz.getSubjectName()}"/>
                                                    <br>
                                                    Exam name: 
                                                    <c:if test="${quiz.getQuizName() == null}">
                                                        None
                                                    </c:if>
                                                    <c:if test="${quiz.getQuizName() != null}">
                                                        <c:out value="${quiz.getQuizName()}"/>
                                                    </c:if>
                                                </td>
                                                <td><c:out value="${quiz.getTestTypeName()}"/></td>
                                                <td><c:out value="${quiz.getDateTaken()}"/></td>
                                                <td><c:out value="${quiz.getDurationString()}"/></td>
                                                <td><c:out value="${quiz.getScore()}"/></td>
                                                <td><a href="${contextPath}/quizHandleController?service=quizReview&quizTakeId=${quiz.getQuizTakeId()}&questionNumber=1"> Detail </a></td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </tbody>
                            </table>
                            <%--Start Pagination --%>
                            <div class='pagination-container'>
                                <nav>
                                    <ul class="pagination" style="justify-content: center">
                                        <li data-page="prev" >
                                            <span>  <button class="btn btn-info">Prev</button></span>
                                        </li>
                                        <%--Here the JS Function Will Add the Rows --%>
                                        <li data-page="next" id="prev">
                                            <span> <button class="btn btn-info">Next</button><span class=""></span></span>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
            <div class="space" style="min-height: 50vh;"></div>
            <%-- Include footer page --%>
            <jsp:include page="footer.jsp"/>
        </div>
        <script>
            getPagination('#table-id');
            function getPagination(table) {
                var lastPage = 1;

                $('#maxRows')
                        .on('change', function (evt) {
                            lastPage = 1;
                            $('.pagination')
                                    .find('li')
                                    .slice(1, -1)
                                    .remove();
                            var trnum = 0; // reset tr counter
                            var maxRows = parseInt($(this).val()); // get Max Rows from select option

                            if (maxRows == 5000) {
                                $('.pagination').hide();
                            } else {
                                $('.pagination').show();
                            }

                            var totalRows = $(table + ' tbody tr').length; // numbers of rows
                            $(table + ' tr:gt(0)').each(function () {
                                // each TR in  table and not the header
                                trnum++; // Start Counter
                                if (trnum > maxRows) {
                                    // if tr number gt maxRows

                                    $(this).hide(); // fade it out
                                }
                                if (trnum <= maxRows) {
                                    $(this).show();
                                } // else fade in Important in case if it ..
                            }); //  was fade out to fade it in
                            if (totalRows > maxRows) {
                                // if tr total rows gt max rows option
                                var pagenum = Math.ceil(totalRows / maxRows); // ceil total(rows/maxrows) to get ..
                                //	numbers of pages
                                for (var i = 1; i <= pagenum; ) {
                                    // for each page append pagination li
                                    $('.pagination #prev')
                                            .before(
                                                    '<li class="btn btn-info" data-page="' +
                                                    i +
                                                    '">\
                                                                  <div>' +
                                                    i++ +
                                                    '<div></div></div>\
                                                                </li>'
                                                    )
                                            .show();
                                } // end for i
                            } // end if row count > max rows
                            $('.pagination [data-page="1"]').addClass('active'); // add active class to the first li
                            $('.pagination li').on('click', function (evt) {
                                // on click each page
                                evt.stopImmediatePropagation();
                                evt.preventDefault();
                                var pageNum = $(this).attr('data-page'); // get it's number

                                var maxRows = parseInt($('#maxRows').val()); // get Max Rows from select option

                                if (pageNum == 'prev') {
                                    if (lastPage == 1) {
                                        return;
                                    }
                                    pageNum = --lastPage;
                                }
                                if (pageNum == 'next') {
                                    if (lastPage == $('.pagination li').length - 2) {
                                        return;
                                    }
                                    pageNum = ++lastPage;
                                }

                                lastPage = pageNum;
                                var trIndex = 0; // reset tr counter
                                $('.pagination li').removeClass('active'); // remove active class from all li
                                $('.pagination [data-page="' + lastPage + '"]').addClass('active'); // add active class to the clicked
                                // $(this).addClass('active');					// add active class to the clicked
                                limitPagging();
                                $(table + ' tr:gt(0)').each(function () {
                                    // each tr in table not the header
                                    trIndex++; // tr index counter
                                    // if tr index gt maxRows*pageNum or lt maxRows*pageNum-maxRows fade if out
                                    if (
                                            trIndex > maxRows * pageNum ||
                                            trIndex <= maxRows * pageNum - maxRows
                                            ) {
                                        $(this).hide();
                                    } else {
                                        $(this).show();
                                    } //else fade in
                                }); // end of for each tr in table
                            }); // end of on click pagination list
                            limitPagging();
                        })
                        .val(5)
                        .change();
            }

            function limitPagging() {
                // alert($('.pagination li').length)

                if ($('.pagination li').length > 7) {
                    if ($('.pagination li.active').attr('data-page') <= 3) {
                        $('.pagination li:gt(5)').hide();
                        $('.pagination li:lt(5)').show();
                        $('.pagination [data-page="next"]').show();
                    }
                    if ($('.pagination li.active').attr('data-page') > 3) {
                        $('.pagination li:gt(0)').hide();
                        $('.pagination [data-page="next"]').show();
                        for (let i = (parseInt($('.pagination li.active').attr('data-page')) - 2); i <= (parseInt($('.pagination li.active').attr('data-page')) + 2); i++) {
                            $('.pagination [data-page="' + i + '"]').show();

                        }

                    }
                }
            }

        </script>
    </body>
</html>

