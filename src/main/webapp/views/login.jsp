<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<style>
    body { background: #f9f9f9; font-family: Arial, sans-serif; }
    .login-box { max-width: 380px; margin: 80px auto; background: #fff; padding: 24px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,.1); }
    .login-box h3 { text-align: center; margin-bottom: 20px; font-weight: bold; }
    .field { margin-bottom: 12px; }
    .field label { display:block; margin-bottom: 6px; }
    .field input { width: 100%; padding: 10px; box-sizing: border-box; }
    .alert { padding:10px 12px; border-radius:6px; margin-bottom:12px; }
    .alert-danger { background:#ffecec; color:#a80000; border:1px solid #f1b0b7; }
    .alert-success { background:#e6ffed; color:#116329; border:1px solid #a3e7b1; }
    .btn { display: inline-block; width: 100%; padding: 10px; background:#007bff; color:#fff; border:none; border-radius:6px; cursor:pointer; }
    .btn:hover { background:#0069d9; }
    .links { margin-top: 12px; text-align:center; }
</style>
</head>
<body>
<div class="login-box">
    <h3>Đăng Nhập</h3>

    <%
        Object alert = request.getAttribute("alert");
        if (alert != null) {
    %>
        <div class="alert alert-danger" role="alert"><%= alert.toString() %></div>
    <%
        }
        Object success = request.getAttribute("success");
        if (success != null) {
    %>
        <div class="alert alert-success" role="alert"><%= success.toString() %></div>
    <%
        }
    %>

    <form action="<%=request.getContextPath()%>/login" method="post">
        <div class="field">
            <label>Tên đăng nhập</label>
            <input type="text" name="username" placeholder="Tên đăng nhập" required
                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
        </div>
        <div class="field">
            <label>Mật khẩu</label>
            <input type="password" name="password" placeholder="Mật khẩu" required>
        </div>
        <button type="submit" class="btn">Đăng nhập</button>
    </form>
    <div class="links">
        <a href="<%=request.getContextPath()%>/register">Chưa có tài khoản? Đăng ký</a>
    </div>
</div>
</body>
</html>