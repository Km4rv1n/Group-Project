<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 2.2.25
  Time: 7:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Applicant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body class="container">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Tech<span class="text-success">Sphere</span>&trade;</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/applicant/dashboard/1">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="/applications/${currentUser.id}/1">My Applications</a></li>
                <li class="nav-item"><a class="nav-link" href="/jobs/saved/1">Saved Jobs</a></li>
            </ul>
        </div>
        <div class="d-flex align-items-center">
            <a href="/user/personal-profile" class="d-flex align-items-center text-white text-decoration-none me-3">
                <img src="${currentUser.profilePictureUrl}" class="rounded-circle" width="40" height="40" alt="Profile" />
                <span class="ms-2"><c:out value="${currentUser.firstName}"/>&nbsp;<c:out value="${currentUser.lastName}"/></span>
            </a>
            <form method="post" action="/logout" class="d-inline">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-danger btn-sm">Log out</button>
            </form>
        </div>
    </div>
</nav>

<section class="mb-4">
    <c:if test="${message != null}">
        <div class="alert alert-info"> <c:out value="${message}"/> </div>
    </c:if>

    <form method="get" action="/jobs/search/1" id="search-form" class="row g-3">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <div class="col-md-4">
            <label class="form-label">Search by Title</label>
            <input type="text" class="form-control" placeholder="Title" name="title">
        </div>

        <div class="col-md-2">
            <label class="form-label">Category</label>
            <select name="category" class="form-select">
                <option value="">Any</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.name}">${category.name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="col-md-2">
            <label class="form-label">Experience Level</label>
            <select name="experience" class="form-select">
                <option value="">Any</option>
                <option value="JUNIOR">Junior</option>
                <option value="MEDIUM">Medium</option>
                <option value="SENIOR">Senior</option>
            </select>
        </div>

        <div class="col-md-2">
            <label class="form-label">Location</label>
            <select name="location" class="form-select">
                <option value="">Any</option>
                <option value="ONSITE">Onsite</option>
                <option value="REMOTE">Remote</option>
                <option value="HYBRID">Hybrid</option>
            </select>
        </div>

        <div class="col-md-2">
            <label class="form-label">Minimum Salary</label>
            <input type="number" step="5000" min="0" name="salary" class="form-control">
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>
</section>

<table class="table table-bordered table-striped">
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
        <c:when test="${allJobs.content.size()!=0}">
            <c:forEach var="job" items="${allJobs.content}">
                <tr>
                    <td><c:out value="${job.title}"/></td>
                    <td><c:out value="${job.category.name}"/></td>
                    <td><c:out value="${job.location}"/></td>
                    <td><c:out value="${job.salary}"/></td>
                    <td><c:out value="${job.experienceLevel}"/></td>
                    <td><a href="/user/${job.createdBy.id}"><c:out value="${job.createdBy.firstName}"/>&nbsp;<c:out value="${job.createdBy.lastName}"/></a></td>
                    <td>
                        <a href="/jobs/view/${job.id}" class="btn btn-info btn-sm">View</a>
                        <c:if test="${!currentUser.savedJobs.contains(job)}">
                            <form method="post" action="/jobs/save/${job.id}" class="d-inline">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-warning btn-sm">Save</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="7" class="text-center">No jobs found!</td>
            </tr>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>

<footer class="text-center py-3 mt-4 bg-light">
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/index.js"></script>
</body>
</html>