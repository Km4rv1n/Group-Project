<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 5.2.25
  Time: 11:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Job Details</title>
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
<section>
    <section>
        <h2>Position: <c:out value="${job.title}"/></h2>
        <p><strong>Posted By:&nbsp;</strong><c:out value="${job.createdBy.firstName}"/>&nbsp;<c:out value="${job.createdBy.lastName}"/>&nbsp;on&nbsp;<c:out value="${job.createdAt}"/></p>
        <p><strong>Available Vacancies:&nbsp;</strong><c:out value="${job.vacancies}"/></p>
        <p><strong>Job Category:&nbsp;</strong><c:out value="${job.category.name}"/></p>
        <p><strong>Experience Level:&nbsp;</strong><c:out value="${job.experienceLevel}"/></p>
        <p><strong>Salary:&nbsp;</strong><c:out value="${job.salary}"/></p>
        <p><strong>Location:&nbsp;</strong><c:out value="${job.location}"/></p>
        <p><strong>Job Description:&nbsp;</strong><c:out value="${job.description}"/></p>
    </section>

    <c:choose>
        <c:when test="${!hasApplied}">
            <section>
                <h2>Apply</h2>
                <c:if test="${message != null}">
                    <p><c:out value="${message}"/></p>
                </c:if>

                <form:form method="post" action="/applications/new/${job.id}" modelAttribute="application" enctype="multipart/form-data">
                    <p><form:errors path="*"/></p>

                    <div>
                        <label>Briefly describe your motivations:</label><br>
                        <form:textarea path="motivation" rows="5"/>
                    </div>

                    <div>
                        <label>Upload your CV:</label><br>
                        <input type="file" accept=".pdf, .docx" name="cv" required/>
                    </div>
                    <input type="submit" value="Submit">
                </form:form>
            </section>
        </c:when>

        <c:otherwise>
            <p>You have already applied for this position.</p>
        </c:otherwise>
    </c:choose>

</section>
<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
