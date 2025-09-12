<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Home - User</title>
    <style>
      body {
        background-color: #e8f5e9;
        color: #1b5e20;
      }
      .topbar, .bar {
        background-color: #c8e6c9;
        color: #388e3c;
        padding: 10px 0;
        border-bottom: 1px solid #a5d6a7;
      }
      .brand {
        font-weight: bold;
        color: #388e3c;
        font-size: 1.3em;
      }
      .card {
        background-color: #f1f8e9;
        border: 1px solid #c8e6c9;
        color: #388e3c;
        margin-top: 30px;
        box-shadow: 0 2px 8px #c8e6c9;
      }
      .title h3 {
        color: #388e3c;
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
    </style>
</head>
<body>
<div class="topbar">
  <div class="container bar">
    <div class="brand">Ứng dụng</div>
    <div><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></div>
  </div>
</div>
<div class="container">
  <div class="card">
      <div class="title"><h3>Trang chủ - User</h3></div>
      <div class="body">
          <h2>Xin chào, <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/> (User)</h2>
          <p>Chào mừng bạn đến trang chủ. Nhấn nút bên dưới để quản lý danh mục.</p>
          <div>
              <a class="btn btn-primary" href="${pageContext.request.contextPath}/user/category">Danh mục của tôi (User)</a>
          </div>
      </div>
  </div>
</div>
</body>
</html>