<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 6.2.25
  Time: 9:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Applications</title>
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav>
    <div>
        <h1>Tech
            <div id="neon-green">Sphere</div>
        </h1>&trade;
    </div>

    <a href="/applicant/dashboard/1">Dashboard</a>

    <a href="/applications/${currentUser.id}/1">My applications</a>

    <a href="/jobs/saved/1">Saved Jobs</a>

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
    <table border="1">
        <thead>
        <tr>
            <th>Job</th>
            <th>Application date</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${applications.content.size() != 0}">
                <c:forEach var="application" items="${applications.content}">
                    <tr>
                        <td><a href="/jobs/view/${application.job.id}"><c:out value="${application.job.title}"/></a></td>
                        <td><c:out value="${application.formattedApplicationDate}"/></td>
                        <td><c:out value="${application.status}"/></td>
                    </tr>
                </c:forEach>

                <div>
                    <c:forEach begin="1" end="${totalPages}" var="index">
                        <a href="/applications/${currentUser.id}/${index}">${index}</a>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <tr>
                    <td colspan="3">No applications found!</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>

<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
