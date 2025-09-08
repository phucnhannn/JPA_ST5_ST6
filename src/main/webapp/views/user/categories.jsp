<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Danh mục - User</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .container { display: grid; grid-template-columns: 2fr 1fr; gap: 24px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px 12px; }
        th { background: #eaf3ff; }
        .actions a { margin-right: 8px; }
        .panel { border: 1px solid #c6d5e3; border-radius: 6px; }
        .panel h3 { margin: 0; padding: 10px 12px; background: #d7ebf7; }
        .panel .body { padding: 12px; }
        input[type=text] { width: 100%; padding: 8px; margin: 6px 0 6px; box-sizing: border-box; }
        .form-actions { margin-top: 12px; }
        button { padding: 8px 14px; }
        .muted { color:#666; font-size:12px; }
        .topbar { margin-bottom: 12px; }
        label { display:block; margin-top:8px; }
        /* Center icon column and enlarge image a bit for readability */
        .icon-cell { text-align: center; }
        .icon-cell img { height: 36px; max-width: 56px; object-fit: contain; display: inline-block; }
    </style>
</head>
<body>
<div class="topbar">
    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</div>
<h2>Danh mục (User)</h2>
<p class="muted">Xin chào, <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/>. Bạn chỉ có thể sửa/xóa danh mục do bạn tạo.</p>
<div class="container">
    <div>
        <div class="panel">
            <h3>Danh sách tất cả danh mục</h3>
            <div class="body">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên danh mục</th>
                        <th>Icon</th>
                        <th>Chủ sở hữu</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${categories}">
                        <tr>
                            <td>${item.cateid}</td>
                            <td>${item.catename}</td>
                            <td class="icon-cell">
                                <c:choose>
                                    <c:when test="${not empty item.icon}">
                                        <c:choose>
                                            <c:when test="${fn:startsWith(item.icon, '/')}">
                                                <img class="icon-img" src="${pageContext.request.contextPath}${item.icon}" alt="icon"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img class="icon-img" src="${item.icon}" alt="icon"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${item.owner != null ? (item.owner.fullName != null ? item.owner.fullName : item.owner.username) : 'N/A'}"/></td>
                            <td class="actions">
                                <c:if test="${currentUser != null && item.owner != null && currentUser.userId == item.owner.userId}">
                                    <a href="${pageContext.request.contextPath}/user/category/edit?id=${item.cateid}">Cập nhật</a>
                                    <a href="${pageContext.request.contextPath}/user/category/delete?id=${item.cateid}"
                                       onclick="return confirm('Xóa danh mục này?')">Xóa</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div>
        <div class="panel">
            <h3><c:if test="${empty cate}">Thêm danh mục</c:if><c:if test="${not empty cate}">Cập nhật danh mục</c:if></h3>
            <div class="body">
                <c:set var="isEdit" value="${not empty cate}"/>
                <form method="post" enctype="multipart/form-data"
                      action="${pageContext.request.contextPath}<c:out value='${isEdit ? "/user/category/update" : "/user/category/create"}'/>">
                    <c:if test="${isEdit}">
                        <input type="hidden" name="id" value="${cate.cateid}"/>
                    </c:if>
                    <label>Tên danh mục</label>
                    <input type="text" name="catename" value="<c:out value='${isEdit ? cate.catename : ""}'/>" required/>

                    <label>Icon (URL ảnh - tùy chọn)</label>
                    <input type="text" name="icon" value="<c:out value='${isEdit ? cate.icon : ""}'/>"/>

                    <label>Hoặc tải ảnh (png, jpg, jpeg, gif, webp, svg)</label>
                    <input type="file" name="iconFile" accept="image/*"/>

                    <div class="form-actions">
                        <button type="submit">Submit</button>
                        <c:if test="${isEdit}">
                            <a href="${pageContext.request.contextPath}/user/category" style="margin-left:8px;">Hủy</a>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>