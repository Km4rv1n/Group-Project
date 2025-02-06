<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 4.2.25
  Time: 10:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>My Profile</title>
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>

<nav>
    <div><h1>Tech<div id="neon-green">Sphere</div></h1>&trade;</div>

    <c:if test="${currentUser.role == 'ROLE_RECRUITER'}">
        <a href="/recruiter/dashboard/1">Dashboard</a>
    </c:if>

    <c:if test="${currentUser.role == 'ROLE_APPLICANT'}">
        <a href="/applicant/dashboard/1">Dashboard</a>

        <a href="/applications/${currentUser.id}/1">My applications</a>

        <a href="/jobs/saved/1">Saved Jobs</a>
    </c:if>

    <a href="/user/personal-profile">
        <img src="${currentUser.profilePictureUrl}" class="profile-icon" alt="profile-picture"/>
        <span><c:out value="${currentUser.firstName}"/>&nbsp;<c:out value="${currentUser.lastName}"/></span>
    </a>

    <form method="post" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" class="btn btn-danger btn-sm text-white" value="Log out">
    </form>
</nav>

<section>
    <div class="card shadow-lg p-4  w-50">
        <fieldset class="border p-4 rounded">
            <legend class="w-auto float-none text-center ps-3 pe-3">My Profile</legend>

            <form:form method="post" action="/user/personal-profile" modelAttribute="user" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="_method" value="put">

                <div class="d-flex flex-column align-items-center mb-4">
                    <form:input path="profilePictureUrl" type="hidden"/>
                    <img src="${currentUser.profilePictureUrl}" class="profile-picture rounded-circle img-fluid mb-3"
                         alt="Profile-Picture"><br>
                    <input type="file" name="profilePictureFile" class="form-control w-50"
                           accept="image/png, image/jpeg, image/jpg">
                </div>

                <form:input path="id" type="hidden"/>
                <form:input path="password" type="hidden"/>
                <form:input path="passwordConfirmation" type="hidden"/>
                <form:input path="role" type="hidden"/>

                <div class="form-floating mb-3">
                    <form:input path="firstName" class="form-control" id="edit-first-name" placeholder="First Name"/>
                    <label for="edit-first-name">First Name</label>
                    <i><small class="form-text text-danger"><form:errors path="firstName"/></small></i>
                </div>
                <div class="form-floating mb-3">
                    <form:input path="lastName" class="form-control" id="edit-last-name" placeholder="Last Name"/>
                    <label for="edit-last-name">Last Name</label>
                    <i><small class="form-text text-danger"><form:errors path="lastName"/></small></i>
                </div>
                <div class="form-floating mb-3">
                    <form:input path="phone" class="form-control" id="edit-phone" placeholder="Phone" type="tel"/>
                    <label for="edit-phone">Phone</label>
                    <i><small class="form-text text-danger"><form:errors path="phone"/></small></i>
                </div>
                <div class="form-floating mb-3">
                    <form:input path="email" class="form-control" id="edit-email" placeholder="Email"/>
                    <label for="edit-email">Email</label>
                    <i><small class="form-text text-danger"><form:errors path="email"/></small></i>
                </div>
                <div class="form-floating mb-3">
                    <form:input path="dateJoined" class="form-control" readonly="true" id="date-joined"
                                placeholder="Date Joined"/>
                    <label for="date-joined">Date Joined</label>
                </div>
                <input type="submit" value="Save Changes" class="btn btn-primary w-100">
            </form:form>
        </fieldset>
    </div>
</section>

<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
