<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Điều hướng mặc định về /home.jsp khi truy cập gốc ứng dụng (demo nhanh)
    response.sendRedirect(request.getContextPath() + "/home.jsp");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <meta http-equiv="refresh" content="0; url=<%=request.getContextPath()%>/home.jsp" />
</head>
<body>
Nếu trình duyệt không tự chuyển hướng, bấm vào đây: <a href="<%=request.getContextPath()%>/home.jsp">Trang chủ</a>
</body>
</html>