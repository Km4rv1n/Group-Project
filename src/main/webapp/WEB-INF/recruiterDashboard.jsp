<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Recruiter Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark p-3">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">Tech<span class="text-success">Sphere</span>™</a>
        <div class="d-flex align-items-center">
            <a href="/recruiter/dashboard/1" class="btn btn-outline-light me-3">Dashboard</a>
            <div class="dropdown">
                <a class="btn btn-light dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                    <img src="${currentUser.profilePictureUrl}" class="rounded-circle me-2" width="40" height="40" alt="profile">
                    <span><c:out value="${currentUser.firstName}"/> <c:out value="${currentUser.lastName}"/></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="/user/personal-profile">My Profile</a></li>
                    <li><form method="post" action="/logout" class="m-0">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="dropdown-item text-danger">Log out</button>
                    </form></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="fw-bold">Recruiter Dashboard</h3>
        <a href="/jobs/new" class="btn btn-success">+ Add a Job</a>
    </div>

    <!-- Success Message -->
    <c:if test="${message != null}">
        <div class="alert alert-success"><c:out value="${message}"/></div>
    </c:if>

    <!-- Jobs Table -->
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Your Job Listings</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-dark">
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
                                <td>
                                    <a href="/jobs/${job.id}" class="btn btn-sm btn-outline-primary">Edit</a>
                                    <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal-${job.id}">Delete</button>
                                </td>
                            </tr>

                            <!-- Delete Confirmation Modal -->
                            <div class="modal fade" id="deleteModal-${job.id}" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Confirm Deletion</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Are you sure you want to delete this job?</p>
                                            <ul>
                                                <li><strong>Title:</strong> <c:out value="${job.title}"/></li>
                                                <li><strong>Vacancies:</strong> <c:out value="${job.vacancies}"/></li>
                                                <li><strong>Applications:</strong> <c:out value="${job.applications.size()}"/></li>
                                            </ul>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <form method="post" action="/jobs/${job.id}" class="d-inline">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <input type="hidden" name="_method" value="Delete">
                                                <button type="submit" class="btn btn-danger">Delete</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="text-center">No jobs found!</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Pagination -->
    <div class="mt-4 d-flex justify-content-center">
        <nav>
            <ul class="pagination">
                <c:forEach begin="1" end="${totalPages}" var="index">
                    <li class="page-item <c:if test='${index == currentPage}'>active</c:if>'">
                        <a class="page-link" href="/recruiter/dashboard/${index}">${index}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>

<!-- Footer -->
<footer class="text-center p-4 bg-dark text-light mt-5">
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script>
    document.getElementById("currentYear").innerText = new Date().getFullYear();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>