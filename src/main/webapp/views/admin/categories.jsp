<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Quản lý danh mục</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; }
        .container { display: grid; grid-template-columns: 2fr 1fr; gap: 24px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background: #eaf3ff; }
        .actions a { margin-right: 8px; }
        .panel { border: 1px solid #c6d5e3; border-radius: 6px; }
        .panel h3 { margin: 0; padding: 10px 12px; background: #d7ebf7; }
        .panel .body { padding: 12px; }
        input[type=text] { width: 100%; padding: 8px; margin: 6px 0 12px; box-sizing: border-box; }
        button { padding: 8px 14px; }
    </style>
</head>
<body>
<h2>Quản lý danh mục</h2>

<div class="container">
    <div>
        <div class="panel">
            <h3>Danh sách danh mục</h3>
            <div class="body">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên danh mục</th>
                        <th>Icon</th>
                        <th>Hành động</th>
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
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${item.cateid}">Cập nhật</a>
                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${item.cateid}"
                                   onclick="return confirm('Xóa danh mục này?')">Xóa</a>
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
                <form method="post"
                      action="${pageContext.request.contextPath}<c:out value='${isEdit ? "/admin/category/update" : "/admin/category/create"}'/>">
                    <c:if test="${isEdit}">
                        <input type="hidden" name="id" value="${cate.cateid}"/>
                    </c:if>
                    <label>Tên danh mục</label>
                    <input type="text" name="catename" value="<c:out value='${isEdit ? cate.catename : ""}'/>" required/>

                    <label>Icon (URL ảnh)</label>
                    <input type="text" name="icon" value="<c:out value='${isEdit ? cate.icon : ""}'/>"/>

                    <button type="submit">Submit</button>
                    <c:if test="${isEdit}">
                        <a href="${pageContext.request.contextPath}/admin/category" style="margin-left:8px;">Hủy</a>
                    </c:if>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>