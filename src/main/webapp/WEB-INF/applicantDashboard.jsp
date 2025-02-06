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

<html>
<head>
    <title>Applicant</title>
    <link href="/css/styles.css" rel="stylesheet">
</head>
<body>
<nav>
    <div>
        <h1>Tech
            <div id="neon-green">Sphere</div>
        </h1>&trade;
    </div>

    <a href="/applicant/dashboard/1">Dashboard</a>

    <a href="/applications/${currentUser.id}/1">My applications</a>

    <a href="/jobs/saved/1">Saved Jobs</a>

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
    <c:if test="${message != null}">
        <p><c:out value="${message}"/></p>
    </c:if>

    <form method="get" action="/jobs/search/1" id="search-form">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <div>
            <label>Search by Title</label><br>
            <input type="text" placeholder="Title" name="title">
        </div>

        <div>
            <label>Category</label><br>
            <select name="category">
                <option value="">Any</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.name}">${category.name}</option>
                </c:forEach>
            </select>
        </div>

        <div>
            <label>Experience Level</label><br>
            <select name="experience">
                <option value="">Any</option>
                <option value="JUNIOR">Junior</option>
                <option value="MEDIUM">Medium</option>
                <option value="SENIOR">Senior</option>
            </select>
        </div>

        <div>
            <label>Location</label><br>
            <select name="location">
                <option value="">Any</option>
                <option value="ONSITE">Onsite</option>
                <option value="REMOTE">Remote</option>
                <option value="HYBRID">Hybrid</option>
            </select>
        </div>

        <div>
            <label>Minimum Salary</label><br>
            <input type="number" step="5000" min="0" name="salary">
        </div>
        <input type="submit" value="Search">
    </form>

    <table border="1">
        <thead>
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
                        <td><a href="/jobs/view/${job.id}">View</a>
                            <c:if test="${!currentUser.savedJobs.contains(job)}">
                                <form method="post" action="/jobs/save/${job.id}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="submit" value="Save">
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                <div>
                    <c:forEach begin="1" end="${totalPages}" var="index">
                        <a href="/applicant/dashboard/${index}">${index}</a>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <tr>
                    <td colspan="7">No jobs found!</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</section>
<footer>
    <span>&copy; <span id="currentYear"></span> TechSphere. All rights reserved.</span>
</footer>

<script src="/js/index.js"></script>
</body>
</html>
