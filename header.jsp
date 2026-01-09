<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            📚 Library System
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
                </li>
                
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/books">Sách</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/borrow">Mượn/Trả</a>
                    </li>
                    
                    <c:if test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Thủ thư'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/readers">Độc giả</a>
                        </li>
                    </c:if>
                </c:if>
            </ul>
            
            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="navbar-text text-white me-2">
                            Xin chào, <strong>${sessionScope.user.fullName}</strong>
                        </span>
                        <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn btn-light btn-sm">
                            Đăng xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-outline-light btn-sm">
                            Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-light btn-sm">
                            Đăng ký
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>