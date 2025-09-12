<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Đăng ký tài khoản</title>
</head>
<body>
<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="#2e7d32">
  <tr>
    <td><font color="#ffffff"><b>Ứng dụng</b></font></td>
    <td align="right"><a href="<%=request.getContextPath()%>/login"><font color="#ffffff">Đăng nhập</font></a></td>
  </tr>
</table>

<table align="center" width="90%" cellpadding="0" cellspacing="0" border="0">
  <tr><td height="16"></td></tr>
  <tr>
    <td>
      <table align="center" width="480" cellpadding="12" cellspacing="0" border="1" bordercolor="#c8e6c9">
        <tr bgcolor="#e8f5e9"><td><b>Đăng ký tài khoản</b></td></tr>
        <tr>
          <td>
            <% if (request.getAttribute("alert") != null) { %>
              <table width="100%" cellpadding="8" cellspacing="0" border="1" bordercolor="#f5c6cb"><tr bgcolor="#fdecea"><td><font color="#611a15"><%= request.getAttribute("alert") %></font></td></tr></table>
              <br/>
            <% } %>

            <form method="post" action="<%=request.getContextPath()%>/register">
              <table width="100%" cellpadding="6" cellspacing="0" border="0">
                <tr><td>Tên đăng nhập</td></tr>
                <tr><td><input type="text" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required/></td></tr>

                <tr><td>Họ tên</td></tr>
                <tr><td><input type="text" name="fullName" value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"/></td></tr>

                <tr><td>Mật khẩu</td></tr>
                <tr><td><input type="password" name="password" required/></td></tr>

                <tr><td>Nhập lại mật khẩu</td></tr>
                <tr><td><input type="password" name="confirm" required/></td></tr>

                <tr>
                  <td align="center">
                    <table cellpadding="10" cellspacing="0" border="0">
                      <tr>
                        <td bgcolor="#2e7d32" align="center"><input type="submit" value="Đăng ký"></td>
                        <td><a href="<%=request.getContextPath()%>/login">Đã có tài khoản? Đăng nhập</a></td>
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
</body>
</html>