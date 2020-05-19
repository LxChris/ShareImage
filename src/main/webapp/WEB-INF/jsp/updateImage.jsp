<%--
  Created by IntelliJ IDEA.
  User: Zlx
  Date: 2020/4/7
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<%
    String base = request.getContextPath()+"/";
    String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+base;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=url%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500&display=swap" rel="stylesheet">

    <!-- Main css -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="css/main.css" />
    <title>Update Image | ShareImage</title>
</head>
<body>

<!-- Nav bar -->
<jsp:include page="include/header.jsp"/>


<!-- Page Content -->
<div class="container-v1">
    <div class="container py-5">
        <div class="text-white text-center">
            <h1 class="display-4">Update your image</h1>
            <!--                <p class="lead mb-2">Upload your image to ShareImage</p>-->
            <!--                <img src="images/image_pxlho1.svg" alt="" width="150" class="mb-4">-->
            <!-- original url: https://res.cloudinary.com/mhmd/image/upload/v1564991372/image_pxlho1.svg -->
        </div>

        <form id="imageInfo" class="needs-validation" action="" method="post"
              onsubmit="return false;" novalidate>
            <div class="row py-4">
                <div class="col-lg-6 mx-auto">
                    <div class="image-area mt-4"><img id="imageResult"
                                                      src="http://localhost:8081/ShareImage_war_exploded/images/img/e0328c07-09f8-4a34-9654-4a4f66d81862_battlefield_4_game_soldier_army_4000x2250.jpg"
                                                      alt="" class="img-fluid rounded shadow-sm mx-auto d-block"></div>
                </div>
            </div>
            <div class="row py-4 bg-l">
                <div class="col-lg-6 mx-auto">
                    <div class="text-light py-4">
                        <h2>Image Information</h2>
                        <hr class="colorgraph">
                        <div class="form-row py-2">
                            <label for="title">Title</label>
                            <input type="text" name="title" id="title" class="form-control input-lg"
                                   placeholder="Title" tabindex="1" required>
                            <div class="invalid-feedback rounded bg-warning pl-2">You must provide a title for the
                                image.</div>
                            <div class="valid-feedback rounded bg-warning pl-2">Looks good.</div>
                        </div>
                        <div class="form-row py-2">
                            <label for="tags">Tags<small>(Use semicolon to split tags)</small></label>
                            <input type="text" name="tags" id="tags" class="form-control input-lg"
                                   placeholder="Tags" tabindex="1">
                        </div>
                        <div class="form-row py-2">
                            <label for="description">Description</label>
                            <input type="text" name="description" id="description" class="form-control input-lg"
                                   placeholder="Description" tabindex="1">
                        </div>
                        <div class="form-row py-4">
                            <div class="col-xs-12 col-md-12">
                                <input type="submit" style="cursor:pointer;" name="submit" id="submit"
                                       onclick="updateImage();"
                                       class="btn btn-primary btn-block btn-lg rounded-pill font-weight-bold"
                                       value="Update Your Image" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="container" style="height: 70px"></div>
</div>


<div class="container" style="height: 70px"></div>

<!-- Footer -->
<jsp:include page="include/footer.jsp"/>

<!-- JS -->

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/19a7b2457d.js" crossorigin="anonymous"></script>
<script src="js/toastr.min.js"></script>
<script src="js/main.js"></script>

<script type="application/javascript">
    initToastr();
    initImageInfoData();

    function initImageInfoData() {
        var imageId = '${imageId}';

        var imageData = getImageInfoById(imageId);
        document.getElementById("imageResult").src = imageData.path;
        document.getElementById("title").value = imageData.title;
        document.getElementById("tags").value = imageData.tags;
        document.getElementById("description").value = imageData.description;

    }

    function updateImage() {
        var imageId = '${imageId}';

        var form = document.getElementById("imageInfo");
        var formData = new FormData(form);
        if (form.checkValidity() === false) {
            return false;
        }
        var ajaxSuccess = false;
        $.ajax({
            async: false,
            type: 'POST',
            data: $('#imageInfo').serialize() + '&_method=put&imageId=' + imageId,
            url: 'v1/image',
            contentType:'application/x-www-form-urlencoded',
            success: function(result) {
                // TODO success message handler
                var imageId = result.imageId;
                var newUrl = "v1/view/image/" + imageId;
                ajaxSuccess = true;
                toastr.success('Success', '', {
                    onHidden: function() {
                        window.location.href = newUrl;
                    }
                });
                // window.location.href = newUrl;
            },
            error: function(result) {
                toastr.error('There is a issue with your internet.', 'Error');
            }
        });
    }


    function getImageTestData() {
        return JSON.parse("{\"imageId\":\"4028d781717e08e501717e0bda770000\",\"title\":\"tas1\",\"path\":\"images/img/e0328c07-09f8-4a34-9654-4a4f66d81862_battlefield_4_game_soldier_army_4000x2250.jpg\",\"type\":\"jpg\",\"resolutionW\":0,\"resolutionH\":0,\"views\":21,\"downloads\":0,\"tags\":\"tags1;tag2;tag3\",\"description\":\"123\",\"username\":\"test\",\"createTime\":\"Apr 15 2020\",\"updateTime\":\"Apr 19 2020\",\"numComments\":0}");
    }

    /*
   Bootstrap custom form validation
*/
    (function () {
        'use strict';
        window.addEventListener('load', function () {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            // var forms = document.getElementsByClassName('needs-validation');
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>
</html>