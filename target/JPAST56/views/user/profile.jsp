<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Hồ sơ cá nhân</title>
</head>
<body>
<div class="container mt-4">
    <h2>Hồ sơ cá nhân</h2>

    <c:if test="${not empty alert}">
        <div class="alert alert-info">${alert}</div>
    </c:if>

    <c:set var="u" value="${empty user ? sessionScope.currentUser : user}"/>

    <div class="row">
        <div class="col-md-4 text-center">
            <c:choose>
                <c:when test="${not empty u.image}">
                    <c:choose>
                        <c:when test="${fn:startsWith(u.image, '/')}">
                            <img src="${pageContext.request.contextPath}${u.image}" alt="avatar" class="img-thumbnail" style="max-width: 240px;"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${u.image}" alt="avatar" class="img-thumbnail" style="max-width: 240px;"/>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="border rounded p-5 text-muted">Chưa có ảnh</div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-md-8">
            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/user/profile">
                <div class="mb-3">
                    <label class="form-label">Tài khoản</label>
                    <input class="form-control" type="text" value="${u.username}" disabled />
                </div>
                <div class="mb-3">
                    <label class="form-label">Họ và tên</label>
                    <input class="form-control" type="text" name="fullName" value="${u.fullName}"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input class="form-control" type="text" name="phone" value="${u.phone}"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Ảnh (URL - tùy chọn)</label>
                    <input class="form-control" type="text" name="image" value="${u.image}"/>
                    <div class="form-text">Hoặc tải ảnh bên dưới</div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Tải ảnh (png, jpg, jpeg, gif, webp, svg)</label>
                    <input class="form-control" type="file" name="imageFile" accept="image/*"/>
                </div>
                <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
