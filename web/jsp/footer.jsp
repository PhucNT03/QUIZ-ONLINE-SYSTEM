<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Footer Page</title>
        <%-- CSS,JS --%>
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="https://kit.fontawesome.com/9650a62e47.js" crossorigin="anonymous"></script>
        <style>
            p{
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%-- Footer --%>
        <footer class="page-footer font-small mdb-color pt-4 " style="background-color:#EDF0F4" >
            
            <div class="row text-center text-md-left mt-3 pb-3" >
                <%-- Grid column --%>
                <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                    <h6 class="text-uppercase mb-4 font-weight-bold">GROUP TREE</h6>
                    <img src="/QuizPracticingSystem/images/FPT.jpg" style="width:60%">
                </div>
                <%-- Grid column --%>
                <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                    <h6 class="text-uppercase mb-4 font-weight-bold">More Information</h6>
                    <%-- Links --%>
                    <p>
                        <a href="https://uni.fpt.edu.vn"><i class="fas fa-university"></i> WEB</a>
                    </p>
                    <p>
                        <a href="https://www.facebook.com/uni.fpt.edu.vn"><i class="fa fa-facebook"></i> FB</a></p>
                    <p>
                        <a href="https://www.youtube.com/c/FPTUniversityChanel/featured"><i class="fa fa-youtube"></i> YouTube</a>
                    </p>
                    <p>
                        <a href="https://www.instagram.com/fpt_university/"><i class="fa fa-instagram"></i> Instagram</a>
                    </p>
                </div>

                <%-- Grid column --%>
                <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                    <h6 class="text-uppercase mb-4 font-weight-bold">Contact</h6>
                    <p>
                        <i class="fas fa-home mr-3"></i> Km29, ĐCT08, Thạch Hoà, Thạch Thất, Hà Nội</p>
                    <p>
                        <i class="fas fa-envelope mr-3"></i> nani@fpt.edu.vn</p>
                    <p>
                        <i class="fas fa-phone mr-3"></i> +84 ...</p>
                    <p>
                        <i class="fas fa-print mr-3"></i> +84 ...</p>
                </div>
                <%-- Grid column --%>

            </div>
            <%-- Footer links --%>

        </footer>
            <%-- Footer --%>
    </body>
</html>
