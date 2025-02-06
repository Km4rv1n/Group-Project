<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 2.2.25
  Time: 6:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true" %>
<html>
<head>
    <title>Log In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/css/styles.css">
</head>
<body>
    <fieldset>
      <legend>Login</legend>

      <c:if test="${logoutMessage != null}">
        <div class="alert alert-info">
          <c:out value="${logoutMessage}"/>
        </div>
      </c:if>

      <c:if test="${successMessage != null}">
        <div class="alert alert-success">
          <c:out value="${successMessage}"/>
        </div>
      </c:if>

      <c:if test="${errorMessage != null}">
        <div class="alert alert-danger">
          <c:out value="${errorMessage}"/>
        </div>
      </c:if>

      <form method="POST" action="/login">
        <div class="form-floating mb-3">
          <input type="text" id="username" name="username" class="form-control" placeholder="Email"/>
          <label for="username" class="form-label">Email</label>
        </div>


        <div class="form-floating mb-3">
          <input type="password" id="password" name="password" class="form-control" placeholder="Password"/>
          <label for="password" class="form-label">Password</label>
        </div>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <button type="submit" class="btn btn-primary w-100">Login</button>
      </form>

      <div class="text-center">
        <a href="/register">Don't have an account? <strong>Register.</strong></a>
      </div>

    </fieldset>

<footer>
  <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
