<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Home - Admin</title>
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
<table align="center" width="90%" cellpadding="0" cellspacing="0" border="0">
  <tr><td height="16"></td></tr>
  <tr>
    <td>
      <table width="100%" cellpadding="12" cellspacing="0" border="1" bordercolor="#c8e6c9">
        <tr bgcolor="#e8f5e9"><td><b>Trang chủ - Admin</b></td></tr>
        <tr>
          <td>
            <h3>Xin chào, <c:out value="${currentUser.fullName != null ? currentUser.fullName : currentUser.username}"/> (Admin)</h3>
            <p>Chào mừng bạn đến trang chủ. Nhấn nút bên dưới để quản lý danh mục.</p>
            <table cellpadding="10" cellspacing="0" border="0">
              <tr>
                <td bgcolor="#2e7d32" align="center"><a href="${pageContext.request.contextPath}/admin/category"><font color="#ffffff"><b>Danh mục của tôi (Admin)</b></font></a></td>
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