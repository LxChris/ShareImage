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

<section class="pb-3 bg-image-full d-flex justify-content-center bg-dark">
    <img src="" id="mainImage" style="height: 500px"/>
</section>

<!-- Content section -->
<div class="container">
    <section class="py-2">
        <div class="container row justify-content-end py-2">
            <div class="a2a_kit a2a_kit_size_32 a2a_default_style">
                <a class="a2a_dd" href="https://www.addtoany.com/share"></a>
                <a class="a2a_button_google_gmail"></a>
                <a class="a2a_button_facebook"></a>
                <a class="a2a_button_twitter"></a>
                <a class="a2a_button_print"></a>
                <a class="a2a_button_wechat"></a>
            </div>
            <a href="" id="image-download"><i class="fas fa-cloud-download-alt pr-2 fa-2x" style="cursor:pointer"></i></a>
        </div>
    </section>
    <hr>
    <section class="py-1">
        <div class="container text-center">
            <!-- Image Info Section -->

            <h3 id="image-title">Image Title</h3>
            <h5 id="image-description">Description of the image</h5>
        </div>
    </section>
    <hr>
    <section class="py-2">
        <div class="container">
            <div class="row">
                <div class="col-md-7" id="leftPanel">
                    <!-- Author Information Section -->

                    <div class="row" id="author">
                        <div class="col-md-2" id="authorLeft">
                            <img src="images/userAvator.jpg" width="75px" height="75px" class="rounded-circle"
                                 id="author_avatar" alt="" />
                        </div>
                        <div class="col-md-6" id="authorRight">
                            <div class="row">
                                <h3><span id="author_username">username</span></h3>
                            </div>
                            <!--                            <div class="row">-->
                            <!--                                <span id="author_name">firstName lastName</span>-->
                            <!--                            </div>-->
                        </div>
                    </div>

                    <hr>
                    <!-- Comment Section -->
                    <div class="row" id="comment">
                        <h4 class="text-primary">Comments</h4>
                        <div class="container comments" id="image-comments">
                            <div class="row">
                                <div class="col-md-2 d-flex justify-content-end pr-4" id="commentAuthor1">
                                    <img src="images/userAvator.jpg" width="35px" height="35px"
                                         class="rounded-circle" id="" alt="" />
                                </div>
                                <div class="col-md-6" id="commentDetail1">
                                    <div class="row">
                                        <span id="name1" class="comment-username">James Chow</span>
                                        <span class="pl-2 text-muted">04/01/2020</span>
                                    </div>
                                    <div class="row">
                                        This is a good picture. I like it.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- User post comment section -->
                        <form id="postCommentInfo" style="width: 100%" action="post" onsubmit="return false;">
                            <div class="container comments" id="image-post-comments">
                                <div class="row">
                                    <div class="col-md-2 d-flex justify-content-end pr-4" id="currentUser">
                                        <img src="images/userAvator.jpg" width="35px" height="35px"
                                             class="rounded-circle" id="currentUser-avatar-post" alt="" />
                                    </div>
                                    <div class="col-md-6" id="postCommentDetail">
                                        <div class="row">
                                            <textarea class="form-control border-primary" id="comment-content" name="commentContent" rows="3" placeholder="Add a comment"></textarea>
                                        </div>
                                        <div class="row d-flex justify-content-end pt-2">
                                            <input type="submit" style="cursor:pointer;" name="submit" id="postComment-submit" onclick="postCommentData()"
                                                   class="btn btn-primary btn-sm" value="Post Comment" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
                <!-- Image Detail Information -->
                <div class="col-md-5" id=" rightPanel">
                    <div class="row image-stat">
                        <div class="stat-item">
                            <span id="stat-view">11</span><br />
                            <small>views</small>
                        </div>
                        <div class="stat-item">
                            <span id="stat-download">1</span><br />
                            <small>downloads</small>
                        </div>
                        <div class="stat-item">
                            <span id="stat-comment">25</span><br />
                            <small>comments</small>
                        </div>
                        <div class="stat-item">
                            <span>Upload on</span>
                            <span id="stat-createTime">04/02/2020</span><br />
                            <span class="text-info">&copy; All right reserved</span>
                        </div>
                    </div>

                    <hr>
                    <div class="image-info">
                        <div class="container pb-2">
                            <i class="far fa-image fa-2x"></i>
                            <span class="pl-4" id="image-resolution">1920 x 1080</span>
                        </div>
                        <div class="container pb-2">
                            <i class="fas fa-sliders-h fa-2x"></i>
                            <span class="pl-4" id="image-type">PNG</span>
                        </div>
                    </div>

                    <hr>
                    <div class="tags">
                        <p class="text-primary">
                            Tags
                        </p>
                        <div class="container pl-0" id="image-tags">
                            <h5 class="image-tags-badge"><a href="#" class="badge badge-secondary" >Secondary</a></h5>
                            <h5 class="image-tags-badge"><a href="#" class="badge badge-secondary">Secondary</a></h5>
                        </div>
                    </div>

                    <div class="container pl-0 pt-5">
                        <div class="col-6" id="deleteImage">
<%--                        <button class="btn btn-outline-danger" onclick="deleteImage()">Delete The Image</button>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>



<div class="container" style="height: 70px"></div>

<!-- Footer -->
<jsp:include page="include/footer.jsp"/>

<!-- JS -->

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/19a7b2457d.js" crossorigin="anonymous"></script>
<script async src="https://static.addtoany.com/menu/page.js"></script>
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

    initImageData();
    initCommentData();
    initPostCommentData();

    function initImageData() {
        // debugger
        var imageId = '${imageId}';
        var currentUser = '${currentUser}';
        // var imageData = getTestData();
        var imageData = getImageData(imageId);
        // debugger
        document.getElementById("mainImage").src = imageData.path;
        document.getElementById("image-download").href = "v1/image/download/" + imageId;
        document.getElementById("image-title").textContent = imageData.title;
        document.getElementById("image-description").textContent = imageData.description;
        document.getElementById("author_username").textContent = imageData.username;
        if (getUserAvatarPath(imageData.username) !== "") {
            document.getElementById("author_avatar").src = getUserAvatarPath(imageData.username);
        }
        document.getElementById("stat-view").textContent = imageData.views;
        document.getElementById("stat-download").textContent = imageData.downloads;
        document.getElementById("stat-comment").textContent = imageData.numComments;
        document.getElementById("stat-createTime").textContent = imageData.createTime;
        document.getElementById("image-resolution").textContent = imageData.resolutionH + " x " + imageData.resolutionW;
        document.getElementById("image-type").textContent = imageData.type;

        // handle tags
        var tags = imageData.tags.split(";");
        imageTagsHTML = "";
        for (i in tags) {
            // TODO change href to search link in the future
            imageTagsHTML += "<h5 class=\"image-tags-badge\"><a href=\"javascript:void(0)\" class=\"badge badge-secondary\"  onclick='gotoSearchPage(\"tag\",\"" + tags[i] + "\" , 0)'>" + tags[i] + "</a></h5>";
        }
        document.getElementById("image-tags").innerHTML = imageTagsHTML;

        // Delete image button
        var deleteImageContainer = document.getElementById("deleteImage");
        if (currentUser === imageData.username) {
            deleteImageContainer.innerHTML = "<button class=\"btn btn-block btn-outline-primary\" onclick=\"gotoUpdateImagePage('" + imageId + "')\">Update The Image</button>" +
                                             "<button class=\"btn btn-block btn-outline-danger\" onclick=\"deleteImage('" + imageId +"')\">Delete The Image</button><br/>";
        }

    }

    function getImageData(imageId) {
        var imageData = "";
        $.ajax({
            async: false,
            type: 'GET',
            url: 'v1/image/' + imageId,
            dataType: 'json',
            success: function (result) {
                imageData = result;
            },
            error: function (result) {
                alert("Error occure" + result);
            }
        });
        return imageData;
    }

    function initCommentData() {
        var imageId = '${imageId}';
        var currentUser = '${currentUser}';
        commentsData = getCommentsData(imageId);

        var commentsContainer = document.getElementById("image-comments");
        var commentsContainerHTML = "";
        for (x in commentsData) {
            if (currentUser === commentsData[x].username) {
                commentsContainerHTML += "<div class=\"row pb-3\">\n" +
                    "                                    <div class=\"col-md-2 d-flex justify-content-end pr-4\" id=\"commentAuthor1\">\n" +
                    "                                        <img src=\"" + getUserAvatarPath(commentsData[x].username) +"\" width=\"35px\" height=\"35px\"\n" +
                    "                                            class=\"rounded-circle\" id=\"\" alt=\"\" />\n" +
                    "                                    </div>\n" +
                    "                                    <div class=\"col-md-6\" id=\"commentDetail1\">\n" +
                    "                                        <div class=\"row\">\n" +
                    "                                            <span id=\"name1\" class=\"comment-username\">" + commentsData[x].username + "</span>\n" +
                    "                                            <span class=\"pl-2 text-muted\">" + commentsData[x].updateTime + "</span>\n" +
                    "                                        </div>\n" +
                    "                                        <div class=\"row\">\n" + commentsData[x].content +
                    "                                        </div>\n" + "<div class=\"row\">\n" +
                    "                    <a href=\"javascript:void(0); onclick=deleteComment('" + commentsData[x].commentId + "')\"><small class=\"text-danger\">Delete</small></a>\n" +
                    "                </div>" +
                    "                                    </div>\n" +
                    "                                </div>";
            } else {
                commentsContainerHTML += "<div class=\"row pb-3\">\n" +
                    "                                    <div class=\"col-md-2 d-flex justify-content-end pr-4\" id=\"commentAuthor1\">\n" +
                    "                                        <img src=\"" + getUserAvatarPath(commentsData[x].username) +"\" width=\"35px\" height=\"35px\"\n" +
                    "                                            class=\"rounded-circle\" id=\"\" alt=\"\" />\n" +
                    "                                    </div>\n" +
                    "                                    <div class=\"col-md-6\" id=\"commentDetail1\">\n" +
                    "                                        <div class=\"row\">\n" +
                    "                                            <span id=\"name1\" class=\"comment-username\">" + commentsData[x].username + "</span>\n" +
                    "                                            <span class=\"pl-2 text-muted\">" + commentsData[x].updateTime + "</span>\n" +
                    "                                        </div>\n" +
                    "                                        <div class=\"row\">\n" + commentsData[x].content +
                    "                                        </div>\n" +
                    "                                    </div>\n" +
                    "                                </div>";
            }

        }
        commentsContainer.innerHTML = commentsContainerHTML;
    }

    function getCommentsData(imageId) {
        var commentsData = "";
        $.ajax({
            async: false,
            type: 'GET',
            url: 'v1/image/' + imageId + '/allComment',
            dataType: 'json',
            success: function (result) {
                commentsData = result;
            },
            error: function (result) {
                toastr.error('There is a issue with your internet.', 'Error');
            }
        });
        return commentsData;
    }

    function initPostCommentData() {
        // debugger
        var currentUsername = '${currentUser}';
        if (currentUsername == '') {
            // TODO need to validate
            // if not login do not retrieve user avatar
            // If not logged in hide it
            document.getElementById("image-post-comments").style.display = "none";
            return false;
        }
        if (getUserAvatarPath(currentUsername) != "") {
            // TODO  if user has not set up avatar yet
            document.getElementById("currentUser-avatar-post").src = getUserAvatarPath(currentUsername);
            // document.getElementById("postComment-submit").disable = true;
        }
        // document.getElementById("postCommentDetail").innerHTML = "<div class=\"row\">\n" +
        //     "                                            <textarea class=\"form-control border-primary\" id=\"comment-content\" name=\"commentContent\" rows=\"3\" placeholder=\"Add a comment\"></textarea>\n" +
        //     "                                        </div>\n" +
        //     "                                        <div class=\"row d-flex justify-content-end pt-2\">\n" +
        //     "                                            <input type=\"submit\" style=\"cursor:pointer;\" name=\"submit\" id=\"postComment-submit\" onclick=\"postCommentData()\"\n" +
        //     "                                                   class=\"btn btn-primary btn-sm\" value=\"Post Comment\" />\n" +
        //     "                                        </div>";
        // document.getElementById("postComment-submit").disable = false;
    }

    function postCommentData() {
        var imageId = '${imageId}';
        $.ajax({
            async: false,
            type: 'POST',
            url: 'v1/image/' + imageId + '/comment',
            contentType:'application/x-www-form-urlencoded',
            data: $('#postCommentInfo').serialize(),
            success: function(result) {
                // debugger
                toastr.success('Success', '', {
                    onHidden: function() {
                        window.location.reload();
                    }
                });
            },
            error: function(result) {
                // debugger
                toastr.error('There is a issue with your internet.', 'Error');
            }
        })
    }

    function gotoUpdateImagePage(imageId) {
        url = "v1/view/image/update/" + imageId;
        window.location = url;
    }

    function deleteImage(imageId) {
        if (confirm("Are you sure you want to delete the image?")) {
            var successFlag = false;
            $.ajax({
                async: false,
                type: 'POST',
                url: 'v1/image/' + imageId,
                contentType:'application/x-www-form-urlencoded',
                data: '_method=delete',
                success: function(result) {
                    // debugger
                    // successFlag = true;
                    toastr.success('Success', '', {
                        onHidden: function() {
                            window.location = "";
                        }
                    });
                },
                error: function(result) {
                    // debugger
                    toastr.error('There is a issue with your internet.', 'Error');
                }
            });

            if (successFlag) {
                window.location = "";
            }
        }
    }

    function deleteComment(commentId) {
        if (confirm("Are you sure you want to delete the comment?")) {
            var successFlag = false;
            console.log(commentId);
            $.ajax({
                async: false,
                type: 'POST',
                url: 'v1/comment/' + commentId,
                contentType:'application/x-www-form-urlencoded',
                data: '_method=delete',
                success: function(result) {
                    // debugger
                    // successFlag = true;
                    toastr.success('Success', '', {
                        onHidden: function() {
                            window.location.reload();
                        }
                    });
                },
                error: function(result) {
                    // debugger
                    toastr.error('There is a issue with your internet.', 'Error');
                }
            });

            if (successFlag) {
                location.reload();
            }
        }
    }


    function getTestData() {
        return JSON.parse("{\"imageId\":\"4028d781717b23a101717b23e5b30001\",\"title\":\"imageTitle\",\"path\":\"images/img/clouds-cold-evening-freezing-314860.jpg\",\"type\":\"jpg\",\"resolutionW\":1080,\"resolutionH\":1920,\"views\":11115,\"downloads\":123,\"tags\":\"tag1;tag2\",\"description\":\"Test desc\",\"username\":\"test\",\"createTime\":\"Apr 14 2020\",\"updateTime\":\"Apr 14 2020\",\"numComments\":1}");
    }

</script>
</html>