<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error</title>
  <!-- Bootstrap CSS -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container d-flex justify-content-center align-items-center min-vh-100">
  <div class="text-center p-5 bg-white rounded shadow">
    <h1 class="text-danger mb-4"><c:out value="${message}"/></h1>

    <c:if test="${authorities.contains('ROLE_RECRUITER')}">
      <a href="/recruiter/dashboard/1" class="btn btn-primary">Back to Dashboard</a>
    </c:if>

    <c:if test="${authorities.contains('ROLE_APPLICANT')}">
      <a href="/applicant/dashboard/1" class="btn btn-primary">Back to Dashboard</a>
    </c:if>
  </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>