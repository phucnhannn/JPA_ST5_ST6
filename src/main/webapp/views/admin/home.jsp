<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Home - Admin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .topbar { margin-bottom: 16px; }
        .box { max-width: 640px; border: 1px solid #e1e1e1; border-radius: 8px; padding: 24px; }
        .actions { margin-top: 20px; }
        .btn { display:inline-block; padding:10px 16px; background:#1976d2; color:#fff; text-decoration:none; border-radius:6px; }
        .btn:hover { background:#125aa0; }
    </style>
</head>
<body>
<div class="topbar">
    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</div>
<div class="box">
    <h2>Xin chào, <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/> (Admin)</h2>
    <p>Chào mừng bạn đến trang chủ. Nhấn nút bên dưới để quản lý danh mục.</p>
    <div class="actions">
        <a class="btn" href="${pageContext.request.contextPath}/admin/category">Quản lý danh mục</a>
    </div>
</div>
</body>
</html>
