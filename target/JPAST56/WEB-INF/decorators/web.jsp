<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.sitemesh.org/sitemesh" prefix="sitemesh" %>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title><sitemesh:write property='title' default='JPAST56 - Trang chủ' /></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<sitemesh:write property='head' />
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">JPAST56</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Home">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/ProfileController">Profile</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<main class="container py-4">
		<sitemesh:write property='body' />
	</main>

	<footer class="border-top py-3 mt-auto">
		<div class="container text-center text-muted small">
			&copy; <%= java.time.Year.now() %> JPAST56. All rights reserved.
		</div>
	</footer>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>