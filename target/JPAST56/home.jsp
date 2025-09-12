<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - JPAST56</title>
</head>
<body>
    <div class="row">
        <div class="col-12">
            <h1>Chào mừng đến với JPAST56</h1>
            <p class="lead">Hệ thống quản lý web được xây dựng bằng Java JSP Servlet với Sitemesh Decorator và Bootstrap.</p>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Sitemesh Decorator</h5>
                    <p class="card-text">Template decorator system cho việc tái sử dụng layout.</p>
                    <a href="#" class="btn btn-primary">Tìm hiểu</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Bootstrap 5</h5>
                    <p class="card-text">Framework CSS responsive và đơn giản.</p>
                    <a href="#" class="btn btn-primary">Xem thêm</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Java Web</h5>
                    <p class="card-text">Ứng dụng web Java với JSP và Servlet.</p>
                    <a href="#" class="btn btn-primary">Khám phá</a>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <h3>Chức năng chính</h3>
        </div>
        <div class="col-md-6">
            <a href="<c:url value='/user/category' />" class="btn btn-outline-primary w-100 mb-3">
                Quản lý danh mục
            </a>
        </div>
        <div class="col-md-6">
            <a href="<c:url value='/login' />" class="btn btn-outline-success w-100 mb-3">
                Đăng nhập hệ thống
            </a>
        </div>
    </div>
</body>
</html>