<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 5.2.25
  Time: 8:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Application Details</title>
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav>
    <div><h1>Tech<div id="neon-green">Sphere</div></h1>&trade;</div>

    <a href="/recruiter/dashboard/1">Dashboard</a>

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
    <img src="${application.applicant.profilePictureUrl}" alt="Profile-picture" class="profile-picture">
    <h3><c:out value="${application.applicant.firstName}"/>&nbsp;<c:out value="${application.applicant.lastName}"/></h3>
    <p><c:out value="${application.applicant.firstName}"/></p>
    <p><c:out value="${application.applicant.phone}"/></p>
    <p>Applying for position:&nbsp;<c:out value="${application.job.title}"/></p>
    <h4>Motivation:</h4>
    <p><c:out value="${application.motivation}"/></p>
    <a href="${application.cvUrl}" download>Download CV</a>

    <c:if test="${application.status == 'PENDING'}">
        <form method="post" action="/applications/accept/${application.id}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="_method" value="put">
            <input type="submit" value="Accept">
        </form>

        <form method="post" action="/applications/reject/${application.id}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="_method" value="put">
            <input type="submit" value="Reject">
        </form>
    </c:if>
    <c:if test="${application.status == 'ACCEPTED'}">
        <p>This application has been accepted.</p>
    </c:if>
    <c:if test="${application.status == 'REJECTED'}">
        <p>This application has been rejected.</p>
    </c:if>
</section>
<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
