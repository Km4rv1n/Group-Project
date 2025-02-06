<%--
  Created by IntelliJ IDEA.
  User: marvinkika
  Date: 6.2.25
  Time: 1:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <title>Error</title>
</head>
<body>
<h1><c:out value="${message}"/></h1>

<c:if test="${authorities.contains('ROLE_RECRUITER')}">
  <a href="/recruiter/dashboard/1">Back to Dashboard</a>
</c:if>

<c:if test="${authorities.contains('ROLE_APPLICANT')}">
  <a href="/applicant/dashboard/1">Back to Dashboard</a>
</c:if>
</body>
</html>
