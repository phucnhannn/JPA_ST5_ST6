<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Đăng ký tài khoản</title>
    <style>
        body { background: #f9f9f9; font-family: Arial, sans-serif; }
        .box { max-width: 420px; margin: 60px auto; background: #fff; padding: 24px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,.1); }
        .box h3 { text-align: center; margin-bottom: 18px; }
        label { display:block; margin-top: 10px; }
        input[type=text], input[type=password] { width: 100%; padding: 10px; box-sizing: border-box; margin-top:6px; }
        .alert { padding:10px 12px; border-radius:6px; margin-bottom:12px; }
        .alert-danger { background:#ffecec; color:#a80000; border:1px solid #f1b0b7; }
        .alert-success { background:#e6ffed; color:#116329; border:1px solid #a3e7b1; }
        .actions { margin-top: 16px; display:flex; justify-content: space-between; align-items:center; }
        .btn { display:inline-block; padding:10px 16px; background:#1976d2; color:#fff; text-decoration:none; border-radius:6px; border:none; cursor:pointer; }
        .btn:hover { background:#125aa0; }
    </style>
</head>
<body>
<div class="box">
    <h3>Đăng ký tài khoản</h3>

    <% if (request.getAttribute("alert") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("alert") %></div>
    <% } %>

    <form method="post" action="<%=request.getContextPath()%>/register">
        <label>Tên đăng nhập</label>
        <input type="text" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" required/>

        <label>Họ tên</label>
        <input type="text" name="fullName" value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"/>

        <label>Mật khẩu</label>
        <input type="password" name="password" required/>

        <label>Nhập lại mật khẩu</label>
        <input type="password" name="confirm" required/>

        <div class="actions">
            <a href="<%=request.getContextPath()%>/login">Đã có tài khoản? Đăng nhập</a>
            <button type="submit" class="btn">Đăng ký</button>
        </div>
    </form>
</div>
</body>
</html>
