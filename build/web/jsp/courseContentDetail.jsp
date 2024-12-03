

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subject List</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="${contextPath}/css/courseContentDetail.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </head>
    <body>
        <%-- Check If user is logged in or not, if not redirect to error page --%>
        <c:if test="${sessionScope.currUser == null}">
            <c:set var = "errorMess" scope="session" value = "User not logged in"/>
            <c:redirect url="/error.jsp"/>
        </c:if>

        <%-- Check If subject is available or not, if not redirect to error page --%>
        <c:if test="${empty subject}">
            <c:set var = "errorMess" scope="session" value = "Subject not available"/>
            <c:redirect url="/error.jsp"/>
        </c:if>

        <%-- Include header page --%>
        <jsp:include page="header.jsp"/>
        <%-- Main page --%>
        <div class="row">

            <div class="col-md-2"></div>
            <c:if test="${empty displayTab}"><c:set var="displayTab" value="overview"/></c:if>
            <%-- Center form --%>
            <div class="col-md-8">
                <%-- Header nav tab --%>
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="tab col-md-8">
                        <button class="tablinks" onclick="openTab(event, 'tab1')" id="overview">Overview</button>
                        <button class="tablinks" onclick="openTab(event, 'tab2')" id="dimension">Dimension</button>
                        <button class="tablinks" onclick="openTab(event, 'tab3')" id="lesson">Lesson</button>
                        <button class="tablinks" onclick="openTab(event, 'tab4')" id="pricePackage">Price Package</button>
                    </div>
                    <div class="col-md-2"></div>
                </div>
                <%-- Main tab details --%>
                <div class="details">
                    <div id="tab1" class="tabcontent">
                        <h4 style="color: #565e64">Subject Overview/ Id <c:out value="${subject.getSubjectId()}"/></h4>
                        <%-- Form details: The whole tab is a form with the subject's details as set values --%>
                        <form style="padding: 5px;" action="courseContentDetail" method="POST">
                            <%-- First bootstrap form row: subject name, category, featured subject, status and thumbnail image --%>
                            <div class="form-row">
                                <div class="form-group col-md-7">
                                    <%-- Subject name --%>
                                    <br>
                                    <label for="subjectName">Subject Name</label>
                                    <input type="text" name="subjectName" class="form-control" value="${subject.getSubjectName()}" style="margin-bottom: 5px;" required>
                                    <%-- Category list --%>
                                    <label for="subjectCate">Category</label>
                                    <div class="dropdown">
                                        <button class="btn btn-default dropdown-toggle" type="button" 
                                                id="dropdownMenu1" data-toggle="dropdown" 
                                                aria-haspopup="true" aria-expanded="true"
                                                style="width: 100%; border: 1px solid #ced4da">
                                            <i class="fas fa-bars"></i>
                                            <span class="caret"></span>
                                        </button>
                                        <%-- Dropdown for category --%>
                                        <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenu1">
                                            <c:if test="${!empty categoryList}">
                                                <c:forEach items = "${categoryList}" var="category" begin = "0" end = "${categoryList.size()-1}">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" checked name="subjectCategory" value="${category.getSubjectCateId()}"> <c:out value="${category.getSubjectCateName()}"/>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${!empty categoryRemainList}">
                                                <c:forEach items = "${categoryRemainList}" var="category" begin = "0" end = "${categoryRemainList.size()-1}">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="subjectCategory" value="${category.getSubjectCateId()}"> <c:out value="${category.getSubjectCateName()}"/>
                                                        </label>
                                                    </li>
                                                </c:forEach>
                                            </c:if>
                                        </ul>
                                    </div>

                                    <br>
                                    <div class="form-row">
                                        <div class="form-group col-md-5">
                                            <%-- Featured subject --%>
                                            <div class="form-check">
                                                <c:choose>
                                                    <c:when test="${subject.isFeaturedSubject()}">
                                                        <input class="form-check-input" type="checkbox" checked id="gridCheck" name="isFeaturedSubject">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input class="form-check-input" type="checkbox" id="gridCheck" name="isFeaturedSubject">
                                                    </c:otherwise>
                                                </c:choose>
                                                <label class="form-check-label" for="gridCheck">
                                                    Featured Subject
                                                </label>
                                            </div>
                                        </div>
                                        <%-- Status --%>
                                        <div class="form-group col-md-2">
                                            <label for="status">Status</label>
                                        </div>
                                        <div class="form-group col-md-5" >
                                            <select id="inputState" class="form-control" style="border: 1px solid #ced4da" name="subjectStatus">
                                                <c:choose>
                                                    <c:when test="${subject.isStatus()}">
                                                        <option selected value="1">Available</option>
                                                        <option value="0">Disabled</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option  value="1">Available</option>
                                                        <option selected value="0">Disabled</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group col-md-1"></div>
                                <%-- Thumbnail image --%>
                                <div class="form-group col-md-4">
                                    <img src="${contextPath}/images/${subject.getThumbnail()}" style="height: 100%; width: 100%;">
                                    <input type="hidden" name="subjectThumbnail" value="${subject.getThumbnail()}">
                                </div>
                            </div>
                            <%-- Description --%>
                            <div class="form-group">
                                <label for="subjectDescription">Description</label>
                                <textarea class="form-control" style="min-height: 4em; overflow: scroll;" name="subjectDescription" required><c:out value="${subject.getDescription()}"/></textarea>
                            </div>
                            <%-- Submit --%>
                            <div class="form-row">
                                <div class="form-group" style="margin-right: 1em; margin-left: 1em;">
                                    <input type="hidden" name="service" value="updateSubject">
                                    <input type="hidden" name="subjectId" value="${subject.getSubjectId()}">
                                    <input type="hidden" name="sujectDimension" value="${subject.getDimensions()}">
                                    <button type="submit" id="submit" class="btn btn-primary">Submit</button>
                                </div>
                                <div class="form-group">
                                    <a href="${contextPath}/index.jsp" class="btn btn-primary">Back</a>
                                </div>
                            </div>
                        </form>
                        <%-- Display message if available --%>
                        <c:if test="${!empty detailMessage}">
                            <h6 style="color: ${detailColor}"><c:out value="${detailMessage}"/></h6>
                        </c:if>

                    </div>

                    <%-- Subject dimension --%>
                    <div id="tab2" class="tabcontent">
                        <h4 style="color: #565e64">Subject Dimension/ Id <c:out value="${subject.getSubjectId()}"/></h4>
                        <%-- Display message if available --%>
                        <c:if test="${!empty dimensionMessage}">
                            <h6 style="color: ${dimensionColor}"><c:out value="${dimensionMessage}"/></h6>
                        </c:if>
                        <%-- Dimension table: each row is a form that allows admin/expert to edit/delete the dimension --%>
                        <table class="table table-striped table-bordered table-hover">
                            <%-- Table head --%>
                            <thead class="thead-light" style="background-color: #F0D8D5;">
                                <tr style="background-color: #F0D8D5;">
                                    <th scope="col" style="background-color: #F0D8D5;">Id</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Type</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Dimension</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Description</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Action</th>
                                </tr>
                            </thead>
                            <%-- Table body --%>
                            <tbody>
                                <%-- For each dimension, print a row --%>
                                <c:forEach items = "${subject.getDimensions()}" var="dimension" begin = "0" end = "${subject.getDimensions().size()-1}">
                                    <tr>
                                <form action="courseContentDetail">
                                    <input type="hidden" name="subjectId" value="${subject.getSubjectId()}">
                                    <input type="hidden" name="dimensionId" value="${dimension.getDimensionId()}">
                                    <input type="hidden" name="service" value="updateDimension">
                                    <th scope="row"><c:out value="${dimension.getDimensionId()}"/></th>
                                    <td>
                                        <%-- Print the dimension type select box with the selected value of dimension on top --%>
                                        <select id="inputState" class="inputBorderless" name="dimensionType">
                                            <option selected value="${dimension.getDimensionTypeId()}"><c:out value="${dimension.getDimensionTypeName()}"/></option>
                                            <c:if test = "${!empty dimensionTypes}">
                                                <c:forEach items = "${dimensionTypes}" var="dimensionTypes" begin = "0" end = "${dimensionTypes.size()-1}">
                                                    <c:if test="${dimensionTypes.getDimensionTypeId() != dimension.getDimensionId()}">
                                                        <option value="${dimensionTypes.getDimensionTypeId()}"><c:out value="${dimensionTypes.getDimensionTypeName()}"/></option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                    </td>
                                    <td><input class="inputBorderless" type="text" name="dimensionName" value="${dimension.getDimensionName()}" required></td>
                                    <td><input class="inputBorderless" type="text" name="description" value="${dimension.getDescription()}" placeholder="Description"></td>
                                    <td><input type="submit" class="btn btn-success" name="subService" value="Update" />
                                        <input type="submit" class="btn btn-danger" name="subService" value="Delete" />
                                    </td>
                                </form>
                                </tr>
                            </c:forEach>
                            <%-- Form to create a new dimension --%>
                            <tr>
                            <form action="subjectController">
                                <input type="hidden" name="service" value="addDimension">
                                <input type="hidden" name="subjectId" value="${subject.getSubjectId()}">
                                <th scope="row">New</th>
                                <td>
                                    <select id="inputState" class="inputBorderless" name="dimensionType">
                                        <c:forEach items = "${dimensionTypes}" var="dimensionTypes" begin = "0" end = "${dimensionTypes.size()-1}">
                                            <option value="${dimensionTypes.getDimensionTypeId()}"><c:out value="${dimensionTypes.getDimensionTypeName()}"/></option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input class="inputBorderless" type="text" name="dimensionName" placeholder="Dimension Name" required></td>
                                <td><input class="inputBorderless" type="text" name="description" placeholder="Description"></td>
                                <td><button type="submit" id="submit" class="btn btn-success">Submit</button>
                                </td>
                            </form>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div id="tab3" class="tabcontent">
                        <h4 style="color: #565e64">Subject Lessons/ Id <c:out value="${subject.getSubjectId()}"/></h4>
                        <%-- Display message if available --%>
                        <c:if test="${!empty lessonnMessage}">
                            <h6 style="color: ${lessonColor}"><c:out value="${lessonMessage}"/></h6>
                        </c:if>
                        <%-- Lesson table: each row is a form that allows admin/expert to edit the Lesson --%>
                        <table class="table table-striped table-bordered table-hover">
                            <%-- Table head --%>
                            <thead class="thead-light" style="background-color: #F0D8D5;">
                                <tr style="background-color: #F0D8D5;">
                                    <th scope="col" style="background-color: #F0D8D5;">Id</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Lesson</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Order</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Type</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Status</th>
                                    <th scope="col" style="background-color: #F0D8D5;">Action</th>
                                </tr>
                            </thead>
                            <%-- Table body --%>
                            <tbody>
                                <c:forEach items="${listLesson}" var="lessonList" >
                                    <tr>
                                        <td><c:out value="${lessonList.getLessonId()}"/></td>
                                        <td><c:out value="${lessonList.getLessonName()}"/></td>
                                        <td><c:out value="${lessonList.getLessonOrder()}"/></td>
                                        <td><c:out value="${lessonList.getLessonTypeName()}"/></td>
                                        <td><c:if test="${lessonList.isStatus()}">
                                                Active
                                            </c:if>
                                            <c:if test="${!lessonList.isStatus()}">
                                                Inactive
                                            </c:if>
                                        </td>
                                        <td><a href="lessonController?subjectId=${subject.getSubjectId()}&service=updateLesson&type=update&lessonId=${lessonList.getLessonId()}"><div class="btn btn-success">Edit</div></a></td>
                                    </tr>
                                </c:forEach> 
                                <%-- Form to create a new dimension --%>
                                <tr>
                            <form action="lessonController">
                                <input type="hidden" name="service" value="addLesson">
                                <input type="hidden" name="subjectId" value="${subject.getSubjectId()}">
                                <th scope="row">New</th>
                                <td><input class="inputBorderless" type="text" name="lessonName" placeholder="Lesson Name" required></td>
                                <td><input class="inputBorderless" type="text" name="lessonOrder" placeholder="Lesson Order" required</td>
                                <td>
                                    <select id="inputState" class="inputBorderless" name="lessonTypeId">
                                        <c:forEach items = "${lessonTypes}" var="lessonType">
                                            <option value="${lessonType.getLessonTypeId()}"><c:out value="${lessonType.getLessonTypeName()}"/></option>
                                        </c:forEach>
                                    </select>
                                </td>   
                                <td>
                                    <select id="inputState" class="inputBorderless" name="lessonStatus">
                                        <c:choose>
                                            <c:when test="${lessonList.isStatus()}">
                                                <option selected value="1">Active</option>
                                                <option value="0">Inactive</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option  value="1">Active</option>
                                                <option selected value="0">Inactive</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </td>
                                <td><button type="submit" id="submit" class="btn btn-success">Submit</button>
                                </td>
                            </form>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="tab4" class="tabcontent"></div>
                </div>
            </div>

            <div class="col-md-2"></div>
        </div>



        <%-- Include footer page --%>
        <jsp:include page="footer.jsp"/>
    </body>
    <script>
        <%-- Javascript for tabs opening --%>
        function openTab(evt, tabName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }
        <%-- JS to activate sellect element --%>
        $(".checkbox-menu").on("change", "input[type='checkbox']", function () {
            $(this).closest("li").toggleClass("active", this.checked);
        });

        $(document).on('click', '.allow-focus', function (e) {
            e.stopPropagation();
        });

        <%-- JS to click on (display) proper tab --%>
        window.onload = function () {
            document.getElementById("${displayTab}").click();
        };
    </script>
</html>
