<%--
  Created by IntelliJ IDEA.
  User: Zlx
  Date: 2020/4/5
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<%
    String base = request.getContextPath()+"/";
    String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+base;
%>
<!doctype html>
<html lang="en">
<head>
    <base href="<%=url%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="css/main.css" />
    <title>ShareImage</title>
</head>
<body style="background-color:gainsboro;">

<!-- Nav bar -->
<jsp:include page="include/header.jsp"/>


<!-- Slide Section -->

<header>
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner" role="listbox">
            <!-- Fixme Adv pic or sth -->
            <!-- Slide One - Set the background image for this slide in the line below -->
            <div class="carousel-item active" style="background-image: url('images/index/welcome-1.jpg')">
                <div class="carousel-caption d-none d-md-block">
                    <h3 class="display-4">Uploading</h3>
                    <p class="lead">Be willing to share. The only riches that last are the ones that are given away.</p><small>David Khalil</small>
                </div>
            </div>
            <!-- Slide Two - Set the background image for this slide in the line below -->
            <div class="carousel-item" style="background-image: url('images/index/welcome-2.jpg')">
                <div class="carousel-caption d-none d-md-block">
                    <h3 class="display-4">Sharing</h3>
                    <p class="lead">Sharing empathy is one of the most wonderful aspects of the human experience.</p><small>Christine Rose Elle</small>
                </div>
            </div>
            <!-- Slide Three - Set the background image for this slide in the line below -->
            <div class="carousel-item" style="background-image: url('images/index/welcome-3.jpg')">
                <div class="carousel-caption d-none d-md-block">
                    <h3 class="display-4">Enjoying</h3>
                    <p class="lead">Life is beautiful live it to the full, Love is abundance share it with your friends.</p><small>Vanessa Nanthakumaran</small>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</header>

<!-- Page Content -->
<div class="container">

    <!-- Jumbotron Header -->
    <header class="jumbotron my-4" style="background-image: url('images/index/topN.jpg')">
        <!-- Fixme go to post page -->
        <h3 class="display-5 text-light">Explore more?</h3>
        <p class="lead"></p>
        <a href="v1/view/search" class="btn btn-primary btn-lg">Click here to view!</a>
    </header>

    <!-- Image Gallery -->
    <div class="row text-center" id="image-gallery">

        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card image-card" onclick="gotoImageViewPageWithImageId('4028d781717b23a101717b23e5b30001')" style="cursor: pointer">
                <img class="card-img-top imageGallery-ind" src="images/img/clouds-cold-evening-freezing-314860.jpg" alt="">
                <div class="card-footer bg-dark text-light">
                    <div align="left">
                        <span class="text-left" style="float:left">title</span>
                    </div>
                    <div align="right">
                        <span></span>
                        <i class="far fa-comment pr-2"></i>
                        <span>1,11</span>
                        <i class="far fa-eye"></i>
                    </div>
                </div>
            </div>
        </div>

    </div>


</div>

<div class="d-flex justify-content-center py-2">
    <a href="v1/view/search" class="btn btn-outline-danger btn-lg btn-block">Explorer more images</a>
</div>


<!-- Space for footer -->
<div class="container" style="height: 70px"></div>


<!-- Footer -->
<jsp:include page="include/footer.jsp"/>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/19a7b2457d.js" crossorigin="anonymous"></script>
<script src="js/toastr.min.js"></script>
<script src="js/main.js"></script>
<script type="application/javascript">
    initToastr();

    document.onreadystatechange = function () {
        if (document.readyState == "complete") {
            document.body.style.display = "block";
        } else {
            document.body.style.display = "none";
        };
    };

    initImageGallery();

    function initImageGallery() {
        displayImageInGallery("image-gallery", getInitGalleryData());


    }

    function getInitGalleryData() {
        var imagesData = "";
        $.ajax({
            async: false,
            type: 'GET',
            url: 'v1/image/all/0',
            dataType: 'json',
            success: function (result) {
                imagesData = result;
            },
            error: function (result) {
                alert("Error occure" + result);
            }
        });
        return imagesData;
    }
</script>



</body>
</html>