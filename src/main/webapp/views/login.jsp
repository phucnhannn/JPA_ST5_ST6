<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
</head>
<body>
<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="#2e7d32">
  <tr>
    <td><font color="#ffffff"><b>Ứng dụng</b></font></td>
    <td align="right"><a href="<%=request.getContextPath()%>/register"><font color="#ffffff">Đăng ký</font></a></td>
  </tr>
</table>

<table align="center" width="90%" cellpadding="0" cellspacing="0" border="0">
  <tr><td height="16"></td></tr>
  <tr>
    <td>
      <table align="center" width="420" cellpadding="12" cellspacing="0" border="1" bordercolor="#c8e6c9">
        <tr bgcolor="#e8f5e9"><td><b>Đăng Nhập</b></td></tr>
        <tr>
          <td>
            <%
                Object alert = request.getAttribute("alert");
                if (alert != null) {
            %>
                <table width="100%" cellpadding="8" cellspacing="0" border="1" bordercolor="#f5c6cb"><tr bgcolor="#fdecea"><td><font color="#611a15"><%= alert.toString() %></font></td></tr></table>
                <br/>
            <%
                }
                Object success = request.getAttribute("success");
                if (success != null) {
            %>
                <table width="100%" cellpadding="8" cellspacing="0" border="1" bordercolor="#b7e1b8"><tr bgcolor="#edf7ed"><td><font color="#1e4620"><%= success.toString() %></font></td></tr></table>
                <br/>
            <%
                }
            %>

            <form action="<%=request.getContextPath()%>/login" method="post">
              <table width="100%" cellpadding="6" cellspacing="0" border="0">
                <tr><td>Tên đăng nhập</td></tr>
                <tr><td><input type="text" name="username" placeholder="Tên đăng nhập" required value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"></td></tr>
                <tr><td>Mật khẩu</td></tr>
                <tr><td><input type="password" name="password" placeholder="Mật khẩu" required></td></tr>
                <tr>
                  <td align="center">
                    <table cellpadding="10" cellspacing="0" border="0"><tr><td bgcolor="#2e7d32" align="center"><input type="submit" value="Đăng nhập"></td></tr></table>
                  </td>
                </tr>
              </table>
            </form>
            <div align="center"><a href="<%=request.getContextPath()%>/register">Chưa có tài khoản? Đăng ký</a></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>