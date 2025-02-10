<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 4.2.25
  Time: 8:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Edit Job</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Tech<span class="text-success">Sphere</span>&trade;</a>
    <div class="navbar-nav">
      <a class="nav-link" href="/recruiter/dashboard/1">Dashboard</a>
      <a class="nav-link" href="/user/personal-profile">
        <img src="${currentUser.profilePictureUrl}" class="rounded-circle" width="30" alt="profile">
        <span class="text-white">${currentUser.firstName} ${currentUser.lastName}</span>
      </a>
    </div>
    <form class="d-flex" method="post" action="/logout">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <button class="btn btn-danger btn-sm" type="submit">Log out</button>
    </form>
  </div>
</nav>

<div class="container mt-4">
  <c:if test="${message != null}">
    <div class="alert alert-info">${message}</div>
  </c:if>

  <div class="card">
    <div class="card-header">Edit Job</div>
    <div class="card-body">
      <form:form method="post" action="/jobs/${job.id}" modelAttribute="job" class="row g-3">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="_method" value="put">

        <div class="col-md-6">
          <label class="form-label">Job Title</label>
          <form:input path="title" class="form-control"/>
        </div>

        <div class="col-md-6">
          <label class="form-label">Date added</label>
          <form:input path="createdAt" class="form-control" readonly="true"/>
        </div>

        <div class="col-md-4">
          <label class="form-label">Salary</label>
          <form:input path="salary" type="number" class="form-control" step="1000" min="20000"/>
        </div>

        <div class="col-md-4">
          <label class="form-label">Available Vacancies</label>
          <form:input path="vacancies" type="number" class="form-control" step="1" min="1" max="50"/>
        </div>

        <div class="col-md-4">
          <label class="form-label">Category</label>
          <form:input path="category.name" class="form-control" list="existing-categories"/>
          <datalist id="existing-categories">
            <c:forEach var="category" items="${categories}">
              <option>${category.name}</option>
            </c:forEach>
          </datalist>
        </div>

        <div class="col-md-6">
          <label class="form-label">Experience Level</label>
          <form:select path="experienceLevel" class="form-select">
            <form:option value="JUNIOR">Junior</form:option>
            <form:option value="MEDIUM">Medium</form:option>
            <form:option value="SENIOR">Senior</form:option>
          </form:select>
        </div>

        <div class="col-md-6">
          <label class="form-label">Location</label>
          <form:select path="location" class="form-select">
            <form:option value="ONSITE">Onsite</form:option>
            <form:option value="REMOTE">Remote</form:option>
            <form:option value="HYBRID">Hybrid</form:option>
          </form:select>
        </div>

        <div class="col-12">
          <label class="form-label">Description</label>
          <form:textarea path="description" class="form-control" rows="5"/>
        </div>

        <div class="col-12">
          <button type="submit" class="btn btn-primary">Submit</button>
        </div>
      </form:form>
    </div>
  </div>

  <div class="card mt-4">
    <div class="card-header">Applications</div>
    <div class="card-body">
      <ul class="list-group">
        <c:choose>
          <c:when test="${job.applications.size() != 0}">
            <c:forEach var="application" items="${job.applications}">
              <li class="list-group-item d-flex justify-content-between align-items-center">
                <div>
                  <img src="${application.applicant.profilePictureUrl}" class="rounded-circle me-2" width="30">
                  <span>${application.applicant.firstName} ${application.applicant.lastName}</span>
                </div>
                <span>${application.formattedApplicationDate}</span>
                <a href="/applications/view/${application.id}" class="btn btn-sm btn-info">View</a>
              </li>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <li class="list-group-item text-center">No applications yet!</li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</div>

<footer class="bg-dark text-white text-center py-3 mt-4">
  &copy; <span id="currentYear"></span> TechSphere. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/index.js"></script>
</body>
</html>