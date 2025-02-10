<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Job Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="navbar-brand">
        <h1>Tech <div id="neon-green">Sphere</div>&trade;</h1>
    </div>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="/applicant/dashboard/1">Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/applications/${currentUser.id}/1">My applications</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/jobs/saved/1">Saved Jobs</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/user/personal-profile">
                    <img src="${currentUser.profilePictureUrl}" class="profile-icon rounded-circle" alt="profile-picture" />
                    <span><c:out value="${currentUser.firstName}"/>&nbsp;<c:out value="${currentUser.lastName}"/></span>
                </a>
            </li>
            <li class="nav-item">
                <form method="post" action="/logout" class="form-inline">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="submit" class="btn btn-danger btn-sm text-white" value="Log out">
                </form>
            </li>
        </ul>
    </div>
</nav>

<section class="container mt-5">
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
                    <p class="alert alert-info"><c:out value="${message}"/></p>
                </c:if>

                <form:form method="post" action="/applications/new/${job.id}" modelAttribute="application" enctype="multipart/form-data">
                    <p><form:errors path="*"/></p>

                    <div class="form-group">
                        <label>Briefly describe your motivations:</label>
                        <form:textarea path="motivation" class="form-control" rows="5"/>
                    </div>

                    <div class="form-group">
                        <label>Upload your CV:</label>
                        <input type="file" accept=".pdf, .docx" name="cv" class="form-control" required/>
                    </div>
                    <input type="submit" class="btn btn-primary" value="Submit">
                </form:form>
            </section>
        </c:when>

        <c:otherwise>
            <p>You have already applied for this position.</p>
        </c:otherwise>
    </c:choose>
</section>

<footer class="bg-light text-center py-3 mt-5">
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="/js/index.js"></script>
</body>
</html>