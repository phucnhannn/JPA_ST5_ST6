<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Home</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .topbar { margin-bottom: 16px; }
        .panel { border: 1px solid #c6d5e3; border-radius: 6px; }
        .panel h3 { margin: 0; padding: 10px 12px; background: #d7ebf7; }
        .panel .body { padding: 12px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background: #eaf3ff; }
        .muted { color:#666; font-size:12px; }
        .btn { display:inline-block; padding:8px 14px; background:#1976d2; color:#fff; text-decoration:none; border-radius:6px; }
        .btn:hover { background:#125aa0; }
        .header { display:flex; justify-content: space-between; align-items:center; margin-bottom:12px; }
    </style>
</head>
<body>
<div class="topbar">
    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</div>

<c:set var="roleId" value="${currentUser.roleId}"/>
<c:set var="roleName">
    <c:choose>
        <c:when test="${roleId == 1}">User</c:when>
        <c:when test="${roleId == 2}">Manager</c:when>
        <c:when test="${roleId == 3}">Admin</c:when>
        <c:otherwise>Unknown</c:otherwise>
    </c:choose>
</c:set>

<div class="header">
    <h2>Xin chào, <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/> (<c:out value="${roleName}"/>)</h2>
    <c:set var="rolePath">
        <c:choose>
            <c:when test="${roleId == 1}">/user/category</c:when>
            <c:when test="${roleId == 2}">/manager/category</c:when>
            <c:otherwise>/admin/category</c:otherwise>
        </c:choose>
    </c:set>
    <a class="btn" href="${pageContext.request.contextPath}${rolePath}">Quản lý danh mục</a>
</div>
<p class="muted">
    <c:choose>
        <c:when test="${roleId == 2}">Hiển thị danh sách danh mục của bạn.</c:when>
        <c:otherwise>Hiển thị danh sách tất cả danh mục.</c:otherwise>
    </c:choose>
</p>

<div class="panel">
    <h3>Danh sách danh mục</h3>
    <div class="body">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Icon</th>
                <th>Chủ sở hữu</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${categories}">
                <tr>
                    <td>${item.cateid}</td>
                    <td>${item.catename}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty item.icon}">
                                <img src="${item.icon}" alt="icon" style="height:20px"/>
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td><c:out value="${item.owner != null ? (item.owner.fullName != null ? item.owner.fullName : item.owner.username) : 'N/A'}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
