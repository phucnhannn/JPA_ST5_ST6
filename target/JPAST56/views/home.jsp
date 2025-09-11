<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Home</title>
</head>
<body>
<!-- Topbar xanh lá -->
<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="#2e7d32">
  <tr>
    <td><font color="#ffffff"><b>Ứng dụng</b></font></td>
    <td align="right"><a href="${pageContext.request.contextPath}/logout"><font color="#ffffff">Đăng xuất</font></a></td>
  </tr>
</table>

<!-- Nội dung -->
<table align="center" width="95%" cellpadding="0" cellspacing="0" border="0">
  <tr><td height="12"></td></tr>
  <tr>
    <td>
      <c:set var="roleId" value="${currentUser.roleId}"/>
      <c:set var="roleName">
          <c:choose>
              <c:when test="${roleId == 1}">User</c:when>
              <c:when test="${roleId == 2}">Manager</c:when>
              <c:when test="${roleId == 3}">Admin</c:when>
              <c:otherwise>Unknown</c:otherwise>
          </c:choose>
      </c:set>
      <c:set var="rolePath">
          <c:choose>
              <c:when test="${roleId == 1}">/user/category</c:when>
              <c:when test="${roleId == 2}">/manager/category</c:when>
              <c:otherwise>/admin/category</c:otherwise>
          </c:choose>
      </c:set>

      <!-- Khung thông tin -->
      <table width="100%" cellpadding="10" cellspacing="0" border="1" bordercolor="#c8e6c9">
        <tr bgcolor="#e8f5e9"><td><b>Xin chào</b></td></tr>
        <tr>
          <td>
            <b>Xin chào,</b> <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/> (<c:out value="${roleName}"/>)
            <br/>
            <table cellpadding="8" cellspacing="0" border="0">
              <tr>
                <td bgcolor="#2e7d32"><a href="${pageContext.request.contextPath}${rolePath}"><font color="#ffffff"><b>Danh mục của tôi (<c:out value='${roleName}'/>)</b></font></a></td>
              </tr>
            </table>
            <br/>
            <c:choose>
              <c:when test="${roleId == 2}">Hiển thị danh sách danh mục của bạn.</c:when>
              <c:otherwise>Hiển thị danh sách tất cả danh mục.</c:otherwise>
            </c:choose>
          </td>
        </tr>
      </table>

      <br/>

      <!-- Bảng danh mục -->
      <table width="100%" cellpadding="12" cellspacing="0" border="1" bordercolor="#c8e6c9">
        <tr bgcolor="#e8f5e9"><td><b>Danh sách danh mục</b></td></tr>
        <tr>
          <td>
            <table width="100%" cellpadding="8" cellspacing="0" border="1" bordercolor="#e0e0e0">
              <thead>
                <tr bgcolor="#f1f8e9">
                  <th align="left">ID</th>
                  <th align="left">Tên danh mục</th>
                  <th align="center">Icon</th>
                  <th align="left">Chủ sở hữu</th>
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
                          <img src="${item.icon}" alt="icon" height="20"/>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                      </c:choose>
                    </td>
                    <td><c:out value="${item.owner != null ? (item.owner.fullName != null ? item.owner.fullName : item.owner.username) : 'N/A'}"/></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>