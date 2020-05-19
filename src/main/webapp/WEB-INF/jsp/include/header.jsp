<%--
  Created by IntelliJ IDEA.
  User: Zlx
  Date: 2020/4/5
  Time: 12:12
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">


    <title>ShareImage</title>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">
        <img src="https://getbootstrap.com/docs/4.4/assets/brand/bootstrap-solid.svg" width="30" height="30" class="d-inline-block align-top" alt="">
        ShareImage
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
        <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
            <!-- <li class="nav-item active">
              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item">
              <a class="nav-link disabled" href="#">Disabled</a>
            </li> -->
        </ul>
        <div class="navbar-nav ml-auto">
            <form class="form-inline my-2 my-lg-0" onsubmit="return false;">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" id="keyword">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit" onclick="headerSearch()">Search</button>
                <a href="v1/view/uploadImage" class="btn btn-outline-primary ml-2">Upload Image</a>
            </form>
            <ul class="navbar-nav">
                <c:if test="${empty currentUser}">
                    <li class="nav-item">
                        <a class="nav-link" href="v1/view/register">Register</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="v1/view/login">Login</a>
                    </li>
                </c:if>
                <c:if test="${not empty currentUser}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            ${sessionScope.currentUser}
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="v1/view/profile">Profile</a>
                            <a class="dropdown-item" href="v1/view/self/images">My Image</a>
                            <c:if test="${currentUser eq 'admin'}">
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="v1/view/adminTool">Admin Tool</a>
                            </c:if>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="logout">Log out</a>
                        </div>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="js/main.js"></script>

<script type="application/javascript">
    function headerSearch() {
        var keyword = document.getElementById("keyword").value;
        gotoSearchPage("title", keyword, 0);
    }
</script>

</body>
</html>