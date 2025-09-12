<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Thêm liên kết đến tệp CSS của Bootstrap -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-..." crossorigin="anonymous">
<!-- Thêm liên kết đến tệp CSS tùy chỉnh cho footer -->
<link href="<c:url value='/resources/css/footer.css' />" rel="stylesheet">
</head>
<body>

    <!-- Nội dung trang web ở đây -->

    <!-- Footer Component dùng chung cho toàn bộ website -->
    <footer class="bg-light text-center py-3 mt-5">
        <div class="container">
            <p class="mb-1"><strong>JPAST56</strong> - Hệ thống quản lý web Java</p>
            <small class="text-muted">© 2025 JPAST56. Sử dụng Sitemesh và Bootstrap.</small>
        </div>
    </footer>

    <!-- Thêm liên kết đến tệp JavaScript của Bootstrap -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"
        integrity="sha384-..." crossorigin="anonymous"></script>
</body>
</html>