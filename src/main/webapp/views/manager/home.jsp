<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Home - Manager</title>
</head>
<body>
<div class="topbar">
  <div class="container bar">
    <div class="brand">Ứng dụng</div>
    <div>
      <a href="${pageContext.request.contextPath}/manager/profile">Hồ sơ</a>
      &nbsp;|&nbsp;
      <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    </div>
  </div>
</div>
<div class="container">
  <div class="card">
      <div class="title"><h3>Trang chủ - Manager</h3></div>
      <div class="body">
          <h2>Xin chào, <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/> (Manager)</h2>
          <p>Chào mừng bạn đến trang chủ. Nhấn nút bên dưới để quản lý danh mục của bạn.</p>
          <div>
              <a class="btn btn-primary" href="${pageContext.request.contextPath}/manager/category">Danh mục của tôi (Manager)</a>
          </div>
      </div>
  </div>
</div>
</body>
</html>