<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><sitemesh:write property='title' default='JPAST56' /></title>

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<sitemesh:write property='head' />
<style>
  body {
    background-color: #e8f5e9;
    color: #1b5e20;
  }
  .navbar, .navbar-light {
    background-color: #c8e6c9 !important;
  }
  .navbar-brand, .nav-link {
    color: #388e3c !important;
  }
  .btn-primary {
    background-color: #a5d6a7;
    border-color: #388e3c;
    color: #1b5e20;
  }
  .btn-primary:hover {
    background-color: #81c784;
    color: #fff;
  }
  .card {
    background-color: #f1f8e9;
    border: 1px solid #c8e6c9;
    color: #388e3c;
  }
  .topbar, .bar {
    background-color: #c8e6c9;
    color: #388e3c;
  }
</style>
</head>
<body>
	<!-- Simple Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<a class="navbar-brand" href="<c:url value='/' />">JPAST56</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto">
					<c:set var="roleId" value="${sessionScope.currentUser != null ? sessionScope.currentUser.roleId : 0}" />
					<c:set var="profileHref" value="/user/profile" />
					<c:set var="categoryHref" value="/user/category" />
					<c:choose>
						<c:when test="${roleId == 3}">
							<c:set var="profileHref" value="/admin/profile" />
							<c:set var="categoryHref" value="/admin/category" />
						</c:when>
						<c:when test="${roleId == 2}">
							<c:set var="profileHref" value="/manager/profile" />
							<c:set var="categoryHref" value="/manager/category" />
						</c:when>
					</c:choose>
					<li class="nav-item"><a class="nav-link"
						href="<c:url value='${categoryHref}' />">Danh mục</a></li>
				</ul>

				<ul class="navbar-nav align-items-center">
					<c:choose>
						<c:when test="${not empty sessionScope.currentUser}">
							<li class="nav-item"><a class="nav-link"
								href="<c:url value='${profileHref}' />">Hồ sơ</a></li>
							<li class="nav-item"><span class="navbar-text mx-2">Xin
									chào, ${sessionScope.currentUser.username}</span></li>
							<li class="nav-item"><a class="nav-link"
								href="<c:url value='/logout' />">Đăng xuất</a></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link"
								href="<c:url value='/login' />">Đăng nhập</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Main Content -->
	<main class="container mt-4">
		<sitemesh:write property='body' />
	</main>

	<!-- Simple Footer -->
	<footer class="bg-light text-center py-3 mt-5">
		<div class="container">
			<p class="mb-0">© 2025 JPAST56 - Ứng dụng web Java</p>
		</div>
	</footer>

	<!-- Bootstrap 5 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>