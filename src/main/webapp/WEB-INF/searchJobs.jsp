<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 6.2.25
  Time: 10:58 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Search</title>
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav>
    <div><h1>Tech<div id="neon-green">Sphere</div></h1>&trade;</div>

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
<h3>Search Results</h3>
<section>
    <table border="1">
        <thead>
        <tr>
            <th>Job Title</th>
            <th>Category</th>
            <th>Location</th>
            <th>Salary</th>
            <th>Experience Level</th>
            <th>Posted By</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${jobs.content.size()!=0}">
                <c:forEach var="job" items="${jobs.content}">
                    <tr>
                        <td><c:out value="${job.title}"/></td>
                        <td><c:out value="${job.category.name}"/></td>
                        <td><c:out value="${job.location}"/></td>
                        <td><c:out value="${job.salary}"/></td>
                        <td><c:out value="${job.experienceLevel}"/></td>
                        <td><a href="/user/${job.createdBy.id}"><c:out value="${job.createdBy.firstName}"/>&nbsp;<c:out value="${job.createdBy.lastName}"/></a></td>
                        <td><a href="/jobs/view/${job.id}">View</a>
                            <c:if test="${!currentUser.savedJobs.contains(job)}">
                                <form method="post" action="/jobs/save/${job.id}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="submit" value="Save">
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                <div>
                    <c:forEach begin="1" end="${totalPages}" var="index">
                        <a href="/jobs/search/${index}">${index}</a>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <tr>
                    <td colspan="7">No jobs found!</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>

<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>
</body>
</html>
