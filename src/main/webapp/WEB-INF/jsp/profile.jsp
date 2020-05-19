<%--
  Created by IntelliJ IDEA.
  User: Zlx
  Date: 2020/4/7
  Time: 20:09
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

    <!-- Main css -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="css/main.css" />
    <title>Profile | ShareImage</title>
</head>
<body>

<!-- Nav bar -->
<jsp:include page="include/header.jsp"/>

<div class="container-v1">
    <br>
    <br>
    <div class="row" id="main">
        <div class="col-md-4 bg-info card p-4" id="leftPanel">
            <div class="row text-center">
                <div class="col-md-12">
                    <div>
                        <img src="images/userAvator.jpg" width="200px" height="200px" id="avatar" class="rounded-circle img-thumbnail avatar">
                        <h2 class="text-white pt-4">${sessionScope.currentUser}</h2>

                        <form role="form" action="v1/user/self/avatar" method="post" enctype="multipart/form-data">
                            <label for="fileUpload" class="file-upload btn btn-warning rounded-pill">Change Avatar
                                <input id="fileUpload" type="file" name="avatar" onchange="form.submit()"/>
                            </label>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8 card p-4 bg-light" id="rightPanel">
            <div class="row">
                <div class="col-md-12">
                    <form role="form" id="userInfoForm" action="" method="post" >
                        <h2>Edit your profile.</h2>
                        <hr class="colorgraph">
                        <div class="form-row">
                            <div class="col-md-4 mb-3">
                                <label for="firstName">First Name</label>
                                <input type="text" name="firstName" id="firstName" class="form-control input-lg" placeholder="First Name" tabindex="1">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="lastName">Last Name</label>
                                <input type="text" name="lastName" id="lastName" class="form-control input-lg" placeholder="Last Name" tabindex="2">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="gender">Gender</label>
                                <select class="custom-select" id="gender" name="gender" required>
                                    <option selected disabled value="">Choose...</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-12 mb-3">
                                <label for="email">Email</label>
                                <input type="email" name="email" id="email" class="form-control input-lg" placeholder="Email Address" tabindex="4" disabled>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-6 mb-3">
                                <label for="password">Password</label>
                                <input type="password" name="password" id="password" class="form-control input-lg" placeholder="Password" tabindex="5">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="password_confirmation">Password Confirmation</label>
                                <input type="password" name="password_confirmation" id="password_confirmation" class="form-control input-lg" placeholder="Confirm Password" tabindex="6">
                            </div>
                        </div>
                        <hr class="colorgraph">
                        <div class="row">
                            <div class="col-xs-12 col-md-6"></div>
                            <div class="col-xs-12 col-md-6"><a href="" class="btn btn-success btn-block btn-lg" onclick="updateUserData(); return false">Save</a></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
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
    initUserData();
    function initUserData() {
        var username = '${sessionScope.currentUser}';
        var userData = getUserDataByUsername(username);
        document.getElementById("firstName").value = userData.firstName;
        document.getElementById("lastName").value = userData.lastName;
        document.getElementById("email").value = userData.email;
        if (userData.gender === "Female") {
            document.getElementById("gender").value = "Female";
        } if (userData.gender === "Male") {
            document.getElementById("gender").value = "Male";
        }
        if (userData.profileImagePath != null) {
            document.getElementById("avatar").src = userData.profileImagePath;
        }
    }

    function getUserDataByUsername(username) {
        var userData = "";
        var user = {};
        $.ajax({
            async: false,
            type: 'GET',
            url: 'v1/user/self',
            dataType: 'json',
            success: function(result) {
                userData = result;
            },
            error: function(result) {
                toastr.error('There is a issue with your internet.', 'Error');
            }
        });
        // userData = JSON.parse(userData);
        return userData;
    }

    function updateUserData() {
        // debugger

        $.ajax({
            async: false,
            type: 'POST',
            url: 'v1/user/self',
            contentType:'application/x-www-form-urlencoded',
            data: $('#userInfoForm').serialize() + '&_method=put',
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
                // alert("Error occur");
                toastr.error('There is a issue with your internet.', 'Error');
            }
        });
    }

    function testUserData() {
        return $('#userInfoForm').serialize();
    }


</script>
</html>