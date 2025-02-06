<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 2.2.25
  Time: 7:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Recruiter Dashboard</title>
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
    <a href="/jobs/new">&plus; Add a job</a>

    <c:if test="${message != null}">
        <div><c:out value="${message}"/></div>
    </c:if>

    <table border="1">
        <thead>
            <tr>
                <th>Job Title</th>
                <th>Vacancies</th>
                <th>Applications</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
                <c:when test="${jobsByCurrentUser.content.size() != 0}">
                    <c:forEach var="job" items="${jobsByCurrentUser.content}">
                        <tr>
                            <td><c:out value="${job.title}"/></td>
                            <td><c:out value="${job.vacancies}"/></td>
                            <td><c:out value="${job.applications.size()}"/></td>
                            <td><a href="/jobs/${job.id}">Edit</a>
                                |
                                <button onclick="document.getElementById('modal-${job.id}').showModal();">Delete</button></td>
                        </tr>

                        <dialog id="modal-${job.id}">
                            <h3>Are you sure you want to delete this job?</h3>

                            <p>Title: <c:out value="${job.title}"/></p>
                            <p>Vacancies: <c:out value="${job.vacancies}"/></p>
                            <p>Applications: <c:out value="${job.applications.size()}"/></p>

                            <form method="dialog">
                                <input type="submit" value="Cancel">
                            </form>

                            <form method="post" action="/jobs/${job.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="_method" value="Delete">
                                <input type="submit" value="Delete">
                            </form>
                        </dialog>
                    </c:forEach>

                    <div>
                        <c:forEach begin="1" end="${totalPages}" var="index">
                            <a href="/recruiter/dashboard/${index}">${index}</a>
                        </c:forEach>
                    </div>


                </c:when>


                <c:otherwise>
                    <tr colspan="4">No jobs found!</tr>
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
