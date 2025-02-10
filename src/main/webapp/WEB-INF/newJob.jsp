<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create a Job</title>
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
            <li class="nav-item"><a class="nav-link" href="/recruiter/dashboard/1">Dashboard</a></li>
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

<!-- Form Section -->
<section class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4>Create a Job</h4>
        </div>
        <div class="card-body">
            <form:form method="post" action="/jobs/new" modelAttribute="job">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="alert alert-danger" role="alert">
                    <form:errors path="*"/>
                </div>

                <div class="form-group">
                    <label for="title">Job Title:</label>
                    <form:input path="title" class="form-control" id="title" />
                </div>

                <div class="form-group">
                    <label for="salary">Salary:</label>
                    <form:input path="salary" type="number" step="5000" min="30000" class="form-control" id="salary"/>
                </div>

                <div class="form-group">
                    <label for="vacancies">Available Vacancies:</label>
                    <form:input path="vacancies" type="number" step="1" min="1" max="50" class="form-control" id="vacancies"/>
                </div>

                <div class="form-group">
                    <label for="category">Category:</label>
                    <form:input path="category.name" list="existing-categories" class="form-control" id="category"/>
                    <datalist id="existing-categories">
                        <c:forEach var="category" items="${categories}">
                            <option><c:out value="${category.name}"/></option>
                        </c:forEach>
                    </datalist>
                </div>

                <div class="form-group">
                    <label for="experienceLevel">Experience Level:</label>
                    <form:select path="experienceLevel" class="form-control" id="experienceLevel">
                        <form:option value="JUNIOR">Junior</form:option>
                        <form:option value="MEDIUM">Medium</form:option>
                        <form:option value="SENIOR">Senior</form:option>
                    </form:select>
                </div>

                <div class="form-group">
                    <label for="location">Location:</label>
                    <form:select path="location" class="form-control" id="location">
                        <form:option value="ONSITE">Onsite</form:option>
                        <form:option value="REMOTE">Remote</form:option>
                        <form:option value="HYBRID">Hybrid</form:option>
                    </form:select>
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <form:textarea path="description" rows="5" class="form-control" id="description"/>
                </div>

                <button type="submit" class="btn btn-primary">Submit</button>
            </form:form>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-3 text-center mt-5">
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