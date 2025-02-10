<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Application Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="#">Tech<span class="text-success">Sphere</span>&trade;</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav me-auto">
            <li class="nav-item">
                <a class="nav-link" href="/recruiter/dashboard/1">Dashboard</a>
            </li>
        </ul>
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="/user/personal-profile">
                    <img src="${currentUser.profilePictureUrl}" class="rounded-circle" width="30" height="30" alt="profile-picture">
                    <span><c:out value="${currentUser.firstName}"/>&nbsp;<c:out value="${currentUser.lastName}"/></span>
                </a>
            </li>
            <li class="nav-item">
                <form method="post" action="/logout" class="d-inline">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-danger btn-sm">Log out</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <div class="card p-4 shadow">
        <div class="text-center">
            <img src="${application.applicant.profilePictureUrl}" alt="Profile-picture" class="rounded-circle" width="100">
            <h3 class="mt-3"><c:out value="${application.applicant.firstName}"/>&nbsp;<c:out value="${application.applicant.lastName}"/></h3>
        </div>
        <p><strong>Phone:</strong> <c:out value="${application.applicant.phone}"/></p>
        <p><strong>Applying for:</strong> <c:out value="${application.job.title}"/></p>
        <h4>Motivation:</h4>
        <p><c:out value="${application.motivation}"/></p>
        <a href="${application.cvUrl}" class="btn btn-primary" download>Download CV</a>

        <c:if test="${application.status == 'PENDING'}">
            <div class="mt-3">
                <form method="post" action="/applications/accept/${application.id}" class="d-inline">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="_method" value="put">
                    <button type="submit" class="btn btn-success">Accept</button>
                </form>
                <form method="post" action="/applications/reject/${application.id}" class="d-inline">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="_method" value="put">
                    <button type="submit" class="btn btn-danger">Reject</button>
                </form>
            </div>
        </c:if>

        <c:if test="${application.status == 'ACCEPTED'}">
            <p class="text-success">This application has been accepted.</p>
        </c:if>
        <c:if test="${application.status == 'REJECTED'}">
            <p class="text-danger">This application has been rejected.</p>
        </c:if>
    </div>
</div>

<footer class="text-center mt-4 py-3 bg-light">
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/index.js"></script>
</body>
</html>