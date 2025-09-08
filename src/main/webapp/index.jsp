<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Điều hướng mặc định về /login khi truy cập gốc ứng dụng
    response.sendRedirect(request.getContextPath() + "/login");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <meta http-equiv="refresh" content="0; url=<%=request.getContextPath()%>/login" />
</head>
<body>
Nếu trình duyệt không tự chuyển hướng, bấm vào đây: <a href="<%=request.getContextPath()%>/login">Đăng nhập</a>
</body>
</html>
