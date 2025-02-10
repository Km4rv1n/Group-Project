<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Search</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><h1 class="d-inline">Tech<span class="text-success">Sphere</span>&trade;</h1></a>

        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="/applicant/dashboard/1">Dashboard</a>
            <a class="nav-link text-white" href="/applications/${currentUser.id}/1">My Applications</a>
            <a class="nav-link text-white" href="/jobs/saved/1">Saved Jobs</a>

            <a class="nav-link text-white d-flex align-items-center" href="/user/personal-profile">
                <img src="${currentUser.profilePictureUrl}" class="rounded-circle me-2" width="30" height="30" alt="Profile Picture"/>
                <span><c:out value="${currentUser.firstName}"/> <c:out value="${currentUser.lastName}"/></span>
            </a>

            <form method="post" action="/logout" class="d-inline">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-danger btn-sm ms-3">Log out</button>
            </form>
        </div>
    </div>
</nav>

<!-- Search Results Section -->
<div class="container mt-4">
    <div class="card shadow p-3">
        <h2 class="mb-3 text-center">Search Results</h2>

        <table class="table table-striped table-hover">
            <thead class="table-dark">
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
                            <td>
                                <a href="/user/${job.createdBy.id}" class="text-decoration-none">
                                    <c:out value="${job.createdBy.firstName}"/> <c:out value="${job.createdBy.lastName}"/>
                                </a>
                            </td>
                            <td>
                                <a href="/jobs/view/${job.id}" class="btn btn-primary btn-sm">View</a>
                                <c:if test="${!currentUser.savedJobs.contains(job)}">
                                    <form method="post" action="/jobs/save/${job.id}" class="d-inline">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-success btn-sm">Save</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <tr>
                        <td colspan="7" class="text-center text-muted">No jobs found!</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav>
                <ul class="pagination justify-content-center">
                    <c:forEach begin="1" end="${totalPages}" var="index">
                        <li class="page-item">
                            <a class="page-link" href="/jobs/search/${index}">${index}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-3 mt-4">
    &copy; <span id="currentYear"></span> TechSphere. All rights reserved.
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/index.js"></script>
<script>
    document.getElementById("currentYear").textContent = new Date().getFullYear();
</script>

</body>
</html>