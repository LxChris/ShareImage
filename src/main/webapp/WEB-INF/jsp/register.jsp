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
<%--    <meta http-equiv="X-UA-Compatible" content="ie=edge">--%>
    <title>Sign Up | ShareImage</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500&display=swap" rel="stylesheet">

    <!-- Main css -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" href="css/main.css" />
</head>
<body>
<!-- Nav bar -->
<jsp:include page="include/header.jsp"/>

<div class="container-v1">
    <!--    <br>-->
    <!--    <br>-->
    <div class="container container-v2">
        <div class="row justify-content-center mt-4">
            <div class="col-6 bg-light card p-4 ">
                <!--                <div class="col-md-12">-->
                <div>
                    <h2 class="pb-4 text-center">CREATE ACCOUNT</h2>

                    <form class="needs-validation" id="user-register" method="POST" action="v1/user" onsubmit="return false" novalidate>
                        <div class="form-group">
                            <input type="text" class="form-control form-input" name="username" id="name"
                                   pattern="^[a-z0-9_-]{4,16}$" placeholder="Your Username" required />
                            <div class="invalid-feedback">The username can only have number, _, and char. The length
                                is 4-16.</div>
                            <div class="valid-feedback">Looks good.</div>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control form-input" name="email" id="email"
                                   placeholder="Your Email" required />
                            <div class="invalid-feedback">Please choose a valid email.</div>
                            <div class="valid-feedback">Looks good.</div>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control form-input" name="password" id="password"
                                   placeholder="Password" required />
                            <span toggle="#password" class="zmdi zmdi-eye-off field-icon toggle-password"></span>
                            <div class="invalid-feedback">Please choose a valid password.</div>
                            <div class="valid-feedback">Looks good.</div>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control form-input" name="re_password"
                                   id="re_password" placeholder="Repeat your password" required />
                        </div>
                        <div class="form-group">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                <label class="form-check-label" for="invalidCheck">
                                    Agree to terms and conditions
                                </label>
                                <div class="invalid-feedback">
                                    You must agree before submitting.
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="submit" style="cursor:pointer;" name="submit" id="submit"
                                       class="form-submit" value="Sign up" onclick="register()"/>
                            </div>
                        </div>
                    </form>
                    <p class="loginhere">
                        Have already an account ? <a href="v1/view/login" class="loginhere-link">Login here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="include/footer.jsp"/>


    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/reg.js"></script>

    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script src="js/toastr.min.js"></script>
    <script src="js/main.js"></script>

    <script type="text/javascript">
        initToastr();

        function register() {
            // debugger
            var form = document.getElementById("user-register");
            if (!validatePassword(form)) {
                return false;
            }
            $.ajax({
                async: false,
                type: 'POST',
                url: 'v1/user',
                contentType: 'application/x-www-form-urlencoded',
                data: $('#user-register').serialize(),
                success: function (result) {
                    // debugger
                    toastr.success('Success', '', {
                        onHidden: function () {
                            // window.location.reload();
                            window.location.href = "";
                        }
                    });

                },
                error: function (result) {
                    // debugger
                    // alert("Error occur");
                    toastr.error(result.responseJSON.errorMsg, 'Error');
                }
            });
        }

        function validatePassword(form) {
            if (form.password.value != form.re_password.value) {
                toastr.error('The password you enter does not match', 'Error');
                // alert("The password you enter does not match");
                // form.password.focuse()
                return false;
            }
            return true;
        }
    </script>
</body>
</html>