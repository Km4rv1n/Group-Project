<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>View User</title>
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
            <c:if test="${currentUser.role == 'ROLE_RECRUITER'}">
                <li class="nav-item">
                    <a class="nav-link" href="/recruiter/dashboard/1">Dashboard</a>
                </li>
            </c:if>
            <c:if test="${currentUser.role == 'ROLE_APPLICANT'}">
                <li class="nav-item">
                    <a class="nav-link" href="/applicant/dashboard/1">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/applications/${currentUser.id}/1">My applications</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/jobs/saved/1">Saved Jobs</a>
                </li>
            </c:if>
            <li class="nav-item">
                <a class="nav-link" href="/user/personal-profile">
                    <img src="${currentUser.profilePictureUrl}" class="profile-icon rounded-circle" alt="profile-picture"/>
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

<section class="container mt-5 text-center">
    <img src="${user.profilePictureUrl}" class="profile-picture rounded-circle mb-3" alt="Profile-picture" style="width: 150px; height: 150px;">
    <h3><c:out value="${user.firstName}"/>&nbsp;<c:out value="${user.lastName}"/></h3>
    <a href="mailto:${user.email}" class="d-block mb-2"><c:out value="${user.email}"/></a>
    <p><c:out value="${user.phone}"/></p>
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
</html>(