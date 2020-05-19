<%--
  Created by IntelliJ IDEA.
  User: Zlx
  Date: 2020/4/7
  Time: 20:16
  To change this template use File | Settings | File Templates  .
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
    <title>Search | ShareImage</title>
</head>
<body>

<!-- Nav bar -->
<jsp:include page="include/header.jsp"/>


<!-- Page Content -->
<div class="container-v1">

    <div class="container">

        <!-- Search Section-->
        <div class="text-center py-5">
            <div class="text-white text-center align-middle">
                <h1>Search Image</h1>

                <form action="" method="get" novalidate="novalidate" onsubmit="return false;">
                    <div class="row pt-5">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-3 col-md-3 col-sm-12 pr-0">
                                    <select class="form-control search-slt custom-select-lg" id="search-type" name="searchType">
                                        <option value="">Search By</option>
                                        <option value="title">Title</option>
                                        <option value="tag">Tag</option>
                                        <option value="username">User</option>
                                    </select>
                                </div>
                                <div class="col-lg-6 col-md-3 col-sm-12 p-0">
                                    <input type="text" class="form-control form-control-lg search-slt text-right" id="search-keyword" placeholder="Key Word" name="keyword">
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-12 pl-0">
                                    <button type="button" class="btn btn-lg btn-primary wrn-btn" onclick="searchImage()"><i class="fas fa-search"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Search Result Section -->
        <div class="row text-center" id="search-result">
            <%--<div class="col-lg-4 col-md-6 mb-4">
                <div class="card border-0 image-card" onclick="gotoImageViewPageWithImageId('4028d781717b23a101717b23e5b30001')" style="cursor: pointer">
                    <img class="card-img-top imageGallery-ind" src="https://source.unsplash.com/LAaSoL0LrYs/1920x1080" alt="">
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
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card border-0 image-card" onclick="gotoImageViewPageWithImageId('4028d781717b23a101717b23e5b30001')" style="cursor: pointer">
                    <img class="card-img-top imageGallery-ind" src="https://source.unsplash.com/LAaSoL0LrYs/1920x1080" alt="">
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
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card border-0 image-card" onclick="gotoImageViewPageWithImageId('4028d781717b23a101717b23e5b30001')" style="cursor: pointer">
                    <img class="card-img-top imageGallery-ind" src="https://source.unsplash.com/LAaSoL0LrYs/1920x1080" alt="">
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
            </div>--%>
        </div>

        <ul id="pagination-demo" class="pagination justify-content-center"></ul>

    </div>




    <!-- Space for footer -->
    <div class="container" style="height: 70px"></div>
</div>




<!-- Footer -->
<jsp:include page="include/footer.jsp"/>

<!-- JS -->

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/19a7b2457d.js" crossorigin="anonymous"></script>
<script src="js/jquery.twbsPagination.js"></script>
<script src="js/main.js"></script>

<script type="text/javascript">
    initFormValue();

    function initFormValue() {
        var searchType = getRequestArgs("searchType");
        var keyword = getRequestArgs("keyword");
        // var pageNum = getRequestArgs("pageNum");
        if (searchType != null) {
            document.getElementById("search-type").value = searchType;
        }

        if (keyword != null) {
            document.getElementById("search-keyword").value = keyword;
        }
    }

    function searchImage() {
        var searchType = document.getElementById("search-type").value;
        var keyword = document.getElementById("search-keyword").value;
        var pageNum = 0;
        gotoSearchPage(searchType, keyword, pageNum);
    }

    var initPageNum = getRequestArgs("pageNum");

    if (initPageNum == null) {
        initPageNum = 0;
    }
    // Search result is 0
    var initSearchData = getInitData();
    // if (initSearchData.content.length === 0) {
    //     initPageNum = 0;
    // }

    function getInitData() {
        var searchType = document.getElementById("search-type").value;
        var keyword = document.getElementById("search-keyword").value;

        var imageData;
        $.ajax({
            async: false,
            type: 'GET',
            url: 'v1/image/search?searchType=' + searchType + '&keyword=' + keyword + '&pageNum=0',
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

    $('#pagination-demo').twbsPagination({
        totalPages: initSearchData.totalPages === 0 ? 1: initSearchData.totalPages,
        visiblePages: 10,
        startPage: initPageNum + 1,
        onPageClick: function(event, page) {
            var searchType = document.getElementById("search-type").value;
            var keyword = document.getElementById("search-keyword").value;

            var imageData;
            $.ajax({
                async: false,
                type: 'GET',
                url: 'v1/image/search?searchType=' + searchType + '&keyword=' + keyword + '&pageNum=' + (page-1),
                dataType: 'json',
                success: function (result) {
                    imageData = result;
                },
                error: function (result) {
                    alert("Error occure" + result);
                }
            });
            displayImageInGallery("search-result", imageData);
        }
    });
</script>
</html>