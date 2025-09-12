<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Header đơn giản cho user -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<c:url value='/home.jsp' />">JPAST56</a>
        
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="<c:url value='/user/category' />">Danh mục</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span class="navbar-text me-2">Xin chào, ${sessionScope.user.username}</span>
                    <a class="nav-link" href="<c:url value='/logout' />">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a class="nav-link" href="<c:url value='/login' />">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>