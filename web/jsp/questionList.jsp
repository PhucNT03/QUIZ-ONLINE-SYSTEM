<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question List</title>
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
      
            <jsp:include page="header.jsp"/>

            <div class="row" style="margin-top: 3rem">
                <div class="col-md-1"></div>
                <div class="col-md-2" id="form" style="height: 480px">
                    <h2 class="text-center">Filter</h2>
                    <div style="margin-bottom: 20px;">
                        <%-- Start search form --%>
                        <form action = "" class="navbar-form">
                            <div class="input-group">
                                <input  class="form-control" type="text" id="content" placeholder="Content... " name="content"  style="display: inline-block">
                                <span class="input-group-btn">
                                    <button type="submit" class="btn btn-primary"><span class="fas fa-search"></span></button>  
                                </span>
                                <input type="hidden" name="service" value="searchQuestionByContent">
                            </div>
                        </form>                     
                    </div>
                    <%-- Start filter form --%>
                    <form action="" method="POST">
                        <div class="form-group">
                            <h5>Filter by Subject</h5>
                            <%-- Choose Subject Filter --%>
                            <select class="form-control" name="subjectId">                                
                                <option value="0" selected="">Choose...</option>
                                <option value="">OOP with Java</option>
                                <option value="">Japanese 101</option>                        
                            </select>
                            <h5>Filter by Dimension</h5>
                            <%-- Choose Dimension Filter --%>
                            <select class="form-control" name="dimensionId">
                                <option value="0" selected="">Choose...</option>
                                <option value="">OOP with Java</option>
                                <option value="">Japanese 101</option>                         
                            </select>
                            <h5>Filter by Lesson</h5>
                            <%-- Choose Lesson Filter --%>
                            <select class="form-control" name="lessonId">
                                <option value="0" selected="">Choose...</option>
                                <option value="">OOP with Java</option>
                                <option value="">Japanese 101</option>                         
                            </select>
                        </div>
                        <div class="input-group">
                            <button type="submit" id="submit" class="btn btn-success" style="width: 100%">Filter</button>
                            <input type="hidden" name="service" value="filterQuestion">
                        </div>
                    </form>

                </div>

                <div class="col-md-8" id="form" style="min-height: 480px; min-width: 1000px">
                    <div class="container" >
                        <%-- Table Container --%>
                        <div class="form-group">                           
                            <%-- Select number of Rows show on table --%>
                            <select class="form-control" name="state" id="maxRows" style="width: 150px;float:left;">                               
                                <option value="5">5</option>
                                <option value="10">10</option>
                                <option value="20">20</option>
                            </select>
                            <a href=""><button class="btn btn-success" style="float:right;margin: 5px">Add new Question</button></a>
                            <a href=""><button class="btn btn-info" style="float: right; margin: 5px">Import Question</button></a>
                        </div>  

                        <%-- Table of QuestionList--%>
                        <table id="table-id" class="table table-bordered table-striped">
                            <thead>
                                <%-- Headers of Table--%>
                                <tr style="background-color: #F0D8D5;">
                                    <th>QuesId</th>
                                    <th>Content</th>
                                    <th>Subject</th>
                                    <th>Lesson</th>
                                    <th>Dimension</th>
                                    <th>Status</th>
                                    <th>Action</th></tr>
                            </thead> 
                            <tbody>
                                <tr>
                                    <td>11</td>
                                    <td>What is Object Oriented Programming?</td>
                                    <td>OOP with Java</td>
                                    <td>Introduction</td>
                                    <td>Java Programming</td>
                                    <td>Available</td>
                                    <td><a href=""><div class="btn btn-success">Edit</div></a></td>
                                </tr>
                            </tbody>
                        </table>
                   
                        <div class='pagination-container row'>

                            <nav>
                                <ul class="pagination" style="justify-content: center">
                                    <li data-page="prev" >
                                        <span> <button class="btn btn-light" style="border: solid 1px">Prev</button></span>
                                    </li>
                                 
                                    <li data-page="next" id="prev">
                                        <span> <button class="btn btn-light" style="border: solid 1px">Next</button><span class=""></span></span>
                                    </li>
                                </ul>
                            </nav>

                        </div>

                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
            <div class="space" style="min-height: 50vh;"></div>
            <%-- Include footer page --%>
            <jsp:include page="footer.jsp"/>
        </div>        
    </body>
</html>
