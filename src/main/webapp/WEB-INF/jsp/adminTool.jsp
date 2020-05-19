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
    <title>Image | ShareImage</title>
</head>
<body>

<!-- Nav bar -->
<jsp:include page="include/header.jsp"/>


<!-- Page Content -->
<div class="container-v1">
    <div class="container py-5">
        <div class="text-white text-center">
            <h1 class="display-4">Admin Tools</h1>
        </div>

        <form id="imageInfo" class="needs-" enctype="multipart/form-data" action="" method="post"
              onsubmit="return false;" >
            <div class="row py-4 bg-l">
                <div class="col-lg-6 mx-auto">
                    <div class="text-light py-4">
                        <h2>Delete a image</h2>
                        <hr class="colorgraph">
                        <div class="form-row py-2">
                            <div class="col-10">
                                <input type="text" name="imageId" id="image-id" class="form-control input-lg"
                                       placeholder="imageId to delete" tabindex="1">
                            </div>
                            <div class="col-2">
                                <button class="btn btn-danger btn-block rounded-pill" onclick="deleteImage()">Delete</button>
                            </div>
                        </div>
                    </div>
                    <div class="text-light py-4">
                        <h2>Delete a comment</h2>
                        <hr class="colorgraph">
                        <div class="form-row py-2">
                            <div class="col-10">
                                <input type="text" name="commentId" id="comment-id" class="form-control input-lg"
                                       placeholder="commentId to delete" tabindex="1">
                            </div>
                            <div class="col-2">
                                <button class="btn btn-danger btn-block rounded-pill" onclick="deleteComment()">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
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



    function deleteImage() {
        var imageId = document.getElementById("image-id").value;

        $.ajax({
            async: false,
            type: 'POST',
            url: 'v1/admin/deleteImage/' + imageId + '?_method=delete',
            contentType:'application/x-www-form-urlencoded',
            success: function(result) {
                toastr.success('Success');
            },
            error: function(result) {
                // debugger
                toastr.error('The imageId does not exist', 'Error');
            }
        });
    }

    function deleteComment() {
        var commentId = document.getElementById("comment-id").value;

        $.ajax({
            async: false,
            type: 'POST',
            url: 'v1/admin/deleteComment/' + commentId + '?_method=delete',
            contentType:'application/x-www-form-urlencoded',
            success: function(result) {
                toastr.success('Success');
            },
            error: function(result) {
                // debugger
                toastr.error('The commentId does not exist', 'Error');
            }
        });
    }


    function getImageTestData() {
        return JSON.parse("{\"imageId\":\"4028d781717e08e501717e0bda770000\",\"title\":\"tas1\",\"path\":\"images/img/e0328c07-09f8-4a34-9654-4a4f66d81862_battlefield_4_game_soldier_army_4000x2250.jpg\",\"type\":\"jpg\",\"resolutionW\":0,\"resolutionH\":0,\"views\":21,\"downloads\":0,\"tags\":\"tags1;tag2;tag3\",\"description\":\"123\",\"username\":\"test\",\"createTime\":\"Apr 15 2020\",\"updateTime\":\"Apr 19 2020\",\"numComments\":0}");
    }

</script>
</html>