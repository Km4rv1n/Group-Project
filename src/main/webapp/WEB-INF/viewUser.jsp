<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 6.2.25
  Time: 12:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>View User</title>
    <link href="/css/styles.css" rel="stylesheet">

</head>
<body>
<nav>
    <div>
        <h1>Tech
            <div id="neon-green">Sphere</div>
        </h1>&trade;
    </div>

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
    <img src="${user.profilePictureUrl}" class="profile-picture" alt="Profile-picture">
    <h3><c:out value="${user.firstName}"/>&nbsp;<c:out value="${user.lastName}"/></h3>
    <a href="mailto:${user.email}"><c:out value="${user.email}"/></a>
    <p><c:out value="${user.phone}"/></p>
</section>

<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
