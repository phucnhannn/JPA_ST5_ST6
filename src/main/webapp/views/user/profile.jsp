<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Hồ sơ cá nhân</title>
    <style>
        .container { max-width: 960px; margin: 24px auto; padding: 0 16px; }
        .row { display: flex; flex-wrap: wrap; gap: 24px; align-items: flex-start; }
        .col-left { flex: 0 0 320px; max-width: 100%; }
        .col-right { flex: 1 1 0; min-width: 260px; }
        .card { border: 1px solid #e0e0e0; border-radius: 8px; overflow: hidden; background: #fff; }
        .card-header { background: #f6f6f6; padding: 12px 16px; font-weight: 600; }
        .card-body { padding: 16px; }
        .avatar { display: block; width: 100%; max-width: 260px; height: auto; border: 1px solid #eee; border-radius: 6px; margin: 0 auto; }
        .placeholder { color: #777; border: 1px dashed #bbb; border-radius: 6px; padding: 40px 12px; text-align: center; }
        .form-row { margin-bottom: 12px; }
        .form-row label { display: block; font-size: 14px; margin-bottom: 6px; color: #333; }
        .form-row input[type="text"], .form-row input[type="file"] { width: 100%; padding: 8px 10px; border: 1px solid #ccc; border-radius: 4px; }
        .btn { display: inline-block; padding: 8px 14px; background: #2e7d32; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
        .alert { border: 1px solid #b3e5fc; background: #e1f5fe; padding: 10px 12px; border-radius: 6px; margin-bottom: 16px; }
        @media (max-width: 720px) { .col-left { flex: 1 1 100%; } .col-right { flex: 1 1 100%; } .row { gap: 16px; } }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">Hồ sơ cá nhân</div>
        <div class="card-body">
            <c:if test="${not empty alert}">
                <div class="alert">${alert}</div>
            </c:if>

            <c:set var="u" value="${empty user ? sessionScope.currentUser : user}"/>

            <div class="row">
                <div class="col-left">
                    <c:choose>
                        <c:when test="${not empty u.image}">
                            <c:choose>
                                <c:when test="${fn:startsWith(u.image, '/')}">
                                    <img class="avatar" src="${pageContext.request.contextPath}${u.image}<c:if test='${not empty cacheBust}'>?v=${cacheBust}</c:if>" alt="avatar"/>
                                </c:when>
                                <c:otherwise>
                                    <img class="avatar" src="${u.image}<c:if test='${not empty cacheBust}'>?v=${cacheBust}</c:if>" alt="avatar"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <div class="placeholder">Chưa có ảnh</div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-right">
                    <c:set var="roleId" value="${sessionScope.currentUser != null ? sessionScope.currentUser.roleId : 0}" />
                    <c:set var="profileAction" value="/user/profile" />
                    <c:choose>
                        <c:when test="${roleId == 3}">
                            <c:set var="profileAction" value="/admin/profile" />
                        </c:when>
                        <c:when test="${roleId == 2}">
                            <c:set var="profileAction" value="/manager/profile" />
                        </c:when>
                    </c:choose>

                    <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}${profileAction}">
                        <div class="form-row">
                            <label>Tài khoản</label>
                            <input type="text" value="${u.username}" disabled />
                        </div>
                        <div class="form-row">
                            <label>Họ và tên</label>
                            <input type="text" name="fullName" value="${u.fullName}"/>
                        </div>
                        <div class="form-row">
                            <label>Số điện thoại</label>
                            <input type="text" name="phone" value="${u.phone}"/>
                        </div>
                        <div class="form-row">
                            <label>Ảnh (URL - tùy chọn)</label>
                            <input type="text" name="image" value="${u.image}"/>
                        </div>
                        <div class="form-row">
                            <label>Tải ảnh (png, jpg, jpeg, gif, webp, svg)</label>
                            <input type="file" name="imageFile" accept="image/*"/>
                        </div>
                        <button class="btn" type="submit">Lưu thay đổi</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>