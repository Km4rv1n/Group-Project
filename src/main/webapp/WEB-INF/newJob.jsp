<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 4.2.25
  Time: 5:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true" %>

<html>
<head>
    <title>New Job</title>
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav>
    <div><h1>Tech<div id="neon-green">Sphere</div></h1>&trade;</div>

    <a href="/recruiter/dashboard/1">Dashboard</a>

    <a href="/user/personal-profile">
        <img src="${currentUser.profilePictureUrl}" class="profile-icon" alt="profile-picture"/>
        <span><c:out value="${currentUser.firstName}"/>&nbsp;<c:out value="${currentUser.lastName}"/></span>
    </a>

    <form method="post" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" class="btn btn-danger btn-sm text-white" value="Log out">
    </form>
</nav>

<section>


</section>
    <fieldset>
        <legend>Create a Job</legend>
        <form:form method="post" action="/jobs/new" modelAttribute="job">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div><form:errors path="*"/></div>

            <div>
                <label>Job Title:</label>
                <form:input path="title"/>
            </div>

            <div>
                <label>Salary:</label>
                <form:input path="salary" type="number" step="1000" min="30000"/>
            </div>

            <div>
                <label>Available Vacancies:</label>
                <form:input path="vacancies" type="number" step="1" min="1" max="50"/>
            </div>

            <div>
                <label>Category:</label>
                <form:input path="category.name" list="existing-categories"/>
                <datalist id="existing-categories">
                    <c:forEach var="category" items="${categories}">
                        <option><c:out value="${category.name}"/></option>
                    </c:forEach>
                </datalist>
            </div>
            <div>
                <label>Experience Level:</label>
                <form:select path="experienceLevel">
                    <form:option value="JUNIOR">Junior</form:option>
                    <form:option value="MEDIUM">Medium</form:option>
                    <form:option value="SENIOR">Senior</form:option>
                </form:select>
            </div>

            <div>
                <label>Location:</label>
                <form:select path="location" id="location">
                    <form:option value="ONSITE">Onsite</form:option>
                    <form:option value="REMOTE">Remote</form:option>
                    <form:option value="HYBRID">Hybrid</form:option>
                </form:select>
            </div>

            <div>
                <label>Description</label>
                <form:textarea path="description" rows="5"/>
            </div>
            <input type="submit" value="Submit">
        </form:form>
    </fieldset>
<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
