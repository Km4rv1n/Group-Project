<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>

<html>
<head>
    <title>New Job</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark p-3">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">Tech<span class="text-success">Sphere</span>™</a>
        <div class="d-flex align-items-center">
            <a href="/recruiter/dashboard/1" class="btn btn-outline-light me-3">Dashboard</a>
            <a href="/user/personal-profile" class="d-flex align-items-center text-white text-decoration-none">
                <img src="${currentUser.profilePictureUrl}" class="rounded-circle me-2" width="40" height="40" alt="profile">
                <span><c:out value="${currentUser.firstName}"/> <c:out value="${currentUser.lastName}"/></span>
            </a>
            <form method="post" action="/logout" class="ms-3">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-danger btn-sm">Log out</button>
            </form>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Create a Job</h4>
        </div>
        <div class="card-body">
            <form:form method="post" action="/jobs/new" modelAttribute="job">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="mb-3"><form:errors path="*" class="text-danger"/></div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Job Title:</label>
                        <form:input path="title" class="form-control"/>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Salary:</label>
                        <form:input path="salary" class="form-control" type="number" step="5000" min="30000"/>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Available Vacancies:</label>
                        <form:input path="vacancies" class="form-control" type="number" min="1" max="50"/>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Category:</label>
                        <form:input path="category.name" class="form-control" list="existing-categories"/>
                        <datalist id="existing-categories">
                            <c:forEach var="category" items="${categories}">
                                <option><c:out value="${category.name}"/></option>
                            </c:forEach>
                        </datalist>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Experience Level:</label>
                        <form:select path="experienceLevel" class="form-select">
                            <form:option value="JUNIOR">Junior</form:option>
                            <form:option value="MEDIUM">Medium</form:option>
                            <form:option value="SENIOR">Senior</form:option>
                        </form:select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Location:</label>
                        <form:select path="location" class="form-select">
                            <form:option value="ONSITE">Onsite</form:option>
                            <form:option value="REMOTE">Remote</form:option>
                            <form:option value="HYBRID">Hybrid</form:option>
                        </form:select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <form:textarea path="description" class="form-control" rows="5"/>
                </div>

                <button type="submit" class="btn btn-primary w-100">Submit</button>
            </form:form>
        </div>
    </div>
</div>

<footer class="text-center p-4 bg-dark text-light mt-5">
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script>
    document.getElementById("currentYear").innerText = new Date().getFullYear();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>