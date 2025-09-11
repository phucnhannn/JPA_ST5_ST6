<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Danh mục - User</title>
</head>
<body>
<!-- Topbar xanh lá -->
<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="#2e7d32">
  <tr>
    <td><font color="#ffffff"><b>Ứng dụng</b></font></td>
    <td align="right"><a href="${pageContext.request.contextPath}/logout"><font color="#ffffff">Đăng xuất</font></a></td>
  </tr>
</table>

<table align="center" width="95%" cellpadding="0" cellspacing="0" border="0">
  <tr><td height="12"></td></tr>
  <tr>
    <td>
      <h2>Danh mục của tôi (User)</h2>
      <p>Xin chào, <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/>. Bạn chỉ có thể sửa/xóa danh mục do bạn tạo.</p>

      <table width="100%" cellpadding="8" cellspacing="0" border="0">
        <tr valign="top">
          <!-- Danh sách -->
          <td width="66%">
            <table width="100%" cellpadding="10" cellspacing="0" border="1" bordercolor="#c8e6c9">
              <tr bgcolor="#e8f5e9"><td><b>Danh sách tất cả danh mục</b></td></tr>
              <tr>
                <td>
                  <table width="100%" cellpadding="8" cellspacing="0" border="1" bordercolor="#e0e0e0">
                    <thead>
                      <tr bgcolor="#f1f8e9">
                        <th align="left">ID</th>
                        <th align="left">Tên danh mục</th>
                        <th align="center">Icon</th>
                        <th align="left">Chủ sở hữu</th>
                        <th align="left">Hành động</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="item" items="${categories}">
                        <tr>
                          <td>${item.cateid}</td>
                          <td>${item.catename}</td>
                          <td align="center">
                            <c:choose>
                              <c:when test="${not empty item.icon}">
                                <c:choose>
                                  <c:when test="${fn:startsWith(item.icon, '/')}">
                                    <img class="icon-img" src="${pageContext.request.contextPath}${item.icon}" alt="icon" height="36"/>
                                  </c:when>
                                  <c:otherwise>
                                    <img class="icon-img" src="${item.icon}" alt="icon" height="36"/>
                                  </c:otherwise>
                                </c:choose>
                              </c:when>
                              <c:otherwise>-</c:otherwise>
                            </c:choose>
                          </td>
                          <td><c:out value="${item.owner != null ? (item.owner.fullName != null ? item.owner.fullName : item.owner.username) : 'N/A'}"/></td>
                          <td>
                            <c:if test="${currentUser != null && item.owner != null && currentUser.userId == item.owner.userId}">
                              <a href="${pageContext.request.contextPath}/user/category/edit?id=${item.cateid}">Cập nhật</a>
                              &nbsp;|&nbsp;
                              <a href="${pageContext.request.contextPath}/user/category/delete?id=${item.cateid}"
                                 onclick="return confirm('Xóa danh mục này?')">Xóa</a>
                            </c:if>
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </td>
              </tr>
            </table>
          </td>

          <!-- Form -->
          <td width="34%">
            <table width="100%" cellpadding="10" cellspacing="0" border="1" bordercolor="#c8e6c9">
              <tr bgcolor="#e8f5e9"><td><b><c:if test="${empty cate}">Thêm danh mục</c:if><c:if test="${not empty cate}">Cập nhật danh mục</c:if></b></td></tr>
              <tr>
                <td>
                  <c:set var="isEdit" value="${not empty cate}"/>
                  <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}<c:out value='${isEdit ? "/user/category/update" : "/user/category/create"}'/>">
                    <c:if test="${isEdit}">
                      <input type="hidden" name="id" value="${cate.cateid}"/>
                    </c:if>
                    <table width="100%" cellpadding="6" cellspacing="0" border="0">
                      <tr><td>Tên danh mục</td></tr>
                      <tr><td><input type="text" name="catename" value="<c:out value='${isEdit ? cate.catename : ""}'/>" required/></td></tr>

                      <tr><td>Icon (URL ảnh - tùy chọn)</td></tr>
                      <tr><td><input type="text" name="icon" value="<c:out value='${isEdit ? cate.icon : ""}'/>"/></td></tr>

                      <tr><td>Hoặc tải ảnh (png, jpg, jpeg, gif, webp, svg)</td></tr>
                      <tr><td><input type="file" name="iconFile" accept="image/*"/></td></tr>

                      <tr>
                        <td align="center">
                          <table cellpadding="8" cellspacing="0" border="0">
                            <tr>
                              <td bgcolor="#2e7d32" align="center"><input type="submit" value="Submit"></td>
                              <c:if test="${isEdit}">
                                <td><a href="${pageContext.request.contextPath}/user/category">Hủy</a></td>
                              </c:if>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </form>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>