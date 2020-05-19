<%--
  Created by IntelliJ IDEA.
  User: Zlx
  Date: 2020/4/2
  Time: 22:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    session.setAttribute("currentUser", null);
    session.invalidate();
//    response.sendRedirect("loginPage.jsp?logout=logout");
//    request.getRequestDispathcer("login.jsp").forward(request, response);
    request.getRequestDispatcher("loginPage.jsp?logout=logout").forward(request, response);
%>

</body>
</html>
