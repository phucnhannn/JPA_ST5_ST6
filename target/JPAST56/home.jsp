<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Trang chủ - JPAST56</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    /* Demo để thấy phần <head> được inject vào decorator */
    .demo-head-note { color:#0d6efd; font-weight:600; }
  </style>
</head>
<body>
  <h1 class="h3">Trang chủ</h1>
  <p class="demo-head-note">Trang này được trang trí bởi decorator công khai (web.jsp).</p>
  <p>Hãy thử truy cập /admin/ và /manager/ để xem các layout khác.</p>
</body>
</html>
