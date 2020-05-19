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
    <title>Upload Image | ShareImage</title>
</head>
<body>

<!-- Nav bar -->
<jsp:include page="include/header.jsp"/>

<div class="container-v1">
    <div class="container py-5">
        <div class="text-white text-center">
            <h1 class="display-4">Image Upload</h1>
            <p class="lead mb-2">Upload your image to ShareImage</p>
            <img src="images/image_pxlho1.svg" alt="" width="150" class="mb-4">
            <!-- original url: https://res.cloudinary.com/mhmd/image/upload/v1564991372/image_pxlho1.svg -->
        </div>

        <form id="imageInfo" class="needs-validation" enctype="multipart/form-data" action="" method="post" onsubmit="return false;" novalidate>
            <div class="row py-4">
                <div class="col-lg-6 mx-auto">
                    <!-- Upload image input-->
                    <div class="input-group mb-3 px-2 py-2 rounded-pill bg-white shadow-sm">
                        <input id="upload" type="file" onchange="readURL(this);" class="form-control border-0" name="image" required>
                        <label id="upload-label" for="upload" class="font-weight-light text-muted">Choose
                            file</label>
                        <div class="input-group-append" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                            <label for="upload" class="btn btn-primary m-0 rounded-pill px-4">
                                <i class="fa fa-cloud-upload mr-2 text-muted"></i>
                                <small class="text-uppercase font-weight-bold text-light">Choose file</small>
                            </label>
                        </div>
                    </div>

                    <!-- Uploaded image area-->
                    <p class="font-italic text-white text-center">The image uploaded will be rendered inside the box
                        below.</p>
                    <div class="image-area mt-4"><img id="imageResult" src="#" alt=""
                                                      class="img-fluid rounded shadow-sm mx-auto d-block"></div>

                </div>
            </div>
               <div class="row py-4 bg-l collapse" id="collapseExample">
<%--            <div class="row py-4 bg-l">--%>
                <div class="col-lg-6 mx-auto">
                    <div class="text-light py-4">
                        <h2>Tag Your Image.</h2>
                        <hr class="colorgraph">
                        <div class="form-row py-2">
                            <label for="title">Title</label>
                            <input type="text" name="title" id="title" class="form-control input-lg"
                                   placeholder="Title" tabindex="1" required>
                            <div class="invalid-feedback rounded bg-warning pl-2">You must provide a title for the image.</div>
                            <div class="valid-feedback rounded bg-warning pl-2">Looks good.</div>
                        </div>
                        <div class="form-row py-2">
                            <label for="tags">Tags<small>(Use semicolon to split tags)</small></label>
                            <input type="text" name="tags" id="tags" class="form-control input-lg"
                                   placeholder="Tags" tabindex="1">
                            <!--                                <div class="invalid-feedback">The username can only have number, _, and char. The length-->
                            <!--                                    is 4-16.</div>-->
                            <!--                                <div class="valid-feedback">Looks good.</div>-->
                        </div>
                        <div class="form-row py-2">
                            <label for="description">Description</label>
                            <input type="text" name="description" id="description" class="form-control input-lg"
                                   placeholder="Description" tabindex="1">
                            <!--                                <div class="invalid-feedback">The username can only have number, _, and char. The length-->
                            <!--                                    is 4-16.</div>-->
                            <!--                                <div class="valid-feedback">Looks good.</div>-->
                        </div>
                        <div class="form-row py-4">
                            <div class="col-xs-12 col-md-12">
                                <!--                                    <a href="" class="btn btn-primary btn-block btn-lg rounded-pill font-weight-bold"-->
                                <!--                                        onclick="; return false">Upload Your Image</a>-->
                                <input type="submit" style="cursor:pointer;" name="submit" id="submit" onclick="uploadImage();"
                                       class="btn btn-primary btn-block btn-lg rounded-pill font-weight-bold" value="Upload Your Image" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>





<!-- Footer -->
<jsp:include page="include/footer.jsp"/>

<!-- JS -->

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="js/toastr.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">

    initToastr();

    /*  ==========================================
            SHOW UPLOADED IMAGE
        * ========================================== */
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#imageResult')
                    .attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    $(function () {
        $('#upload').on('change', function () {
            readURL(input);
        });
    });

    /*  ==========================================
        SHOW UPLOADED IMAGE NAME
    * ========================================== */
    var input = document.getElementById('upload');
    var infoArea = document.getElementById('upload-label');

    input.addEventListener('change', showFileName);
    function showFileName(event) {
        var input = event.srcElement;
        var fileName = input.files[0].name;
        infoArea.textContent = 'File name: ' + fileName;
    }

    /*
        Upload Image - Submit Form
    */

    function uploadImage() {
        var form = document.getElementById("imageInfo");
        var formData = new FormData(form);
        if (form.checkValidity() === false) {
            return false;
        }
        var ajaxSuccess = false;
        $.ajax({
            async: false,
            type: 'POST',
            data: formData,
            url: 'v1/image',
            contentType:false,
            processData: false,
            success: function(result) {
                // TODO success message handler
                var imageId = result.imageId;
                var newUrl = "v1/view/image/" + imageId;
                ajaxSuccess = true;
                toastr.success('Success', '', {
                    onHidden: function () {
                        // window.location.reload();
                        window.location.href = newUrl;
                    }
                });
                // window.location.href = newUrl;
            },
            error: function(result) {
                toastr.error(result.responseJSON.errorMsg, 'Error');
                // alert("Error occur");
            }
        });
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