<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <a class="navbar-brand" href="#">Tech <span id="neon-green" class="text-success">Sphere</span>&trade;</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="/applicant/dashboard/1">Dashboard</a></li>
            <li class="nav-item"><a class="nav-link" href="/applications/${currentUser.id}/1">My Applications</a></li>
            <li class="nav-item"><a class="nav-link" href="/jobs/saved/1">Saved Jobs</a></li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/user/personal-profile">
                    <img src="${currentUser.profilePictureUrl}" class="profile-icon rounded-circle mr-2" alt="profile-picture" style="width: 30px; height: 30px;">
                    <span><c:out value="${currentUser.firstName}"/>&nbsp;<c:out value="${currentUser.lastName}"/></span>
                </a>
            </li>
            <li class="nav-item">
                <form method="post" action="/logout" class="form-inline">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-danger btn-sm">Log out</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<!-- Table Section -->
<section class="container mt-4">
    <table class="table table-striped table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>Job</th>
            <th>Application Date</th>
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
                <tr>
                    <td colspan="3" class="text-center">
                        <c:forEach begin="1" end="${totalPages}" var="index">
                            <a href="/applications/${currentUser.id}/${index}" class="btn btn-link">${index}</a>
                        </c:forEach>
                    </td>
                </tr>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="3" class="text-center">No applications found!</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-3 text-center">
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Custom JS for current year -->
<script>
    document.getElementById("currentYear").innerText = new Date().getFullYear();
</script>
</body>
</html>