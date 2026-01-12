<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ thống Quản lý Thư viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero-section { background-color: #f8f9fa; padding: 80px 0; text-align: center; }
        .feature-icon { font-size: 3rem; margin-bottom: 20px; color: #0d6efd; }
        .button {background-color: white; border: none }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />
			<c:if test="${not empty error}">
				<div class="alert alert-danger text-center" role="alert">
					${error}</div>
			</c:if>
		
    <div class="hero-section">
        <div class="container">
            <h1 class="display-4 fw-bold text-primary">Chào mừng đến với Thư viện</h1>
            <p class="lead text-secondary">Hệ thống quản lý sách và mượn trả trực tuyến tiện lợi, nhanh chóng.</p>
        </div>
    </div>

    <div class="container mt-5 mb-5">
        <div class="row text-center g-4">
            <div class="col-md-4">
                <div class="p-4 border rounded shadow-sm h-100">
                <a href = "${pageContext.request.contextPath}/books">
                <button type="submit" class = "button">
                    <div class="feature-icon">📖</div>
                    <h3>Tra cứu sách</h3>
                    <p class="text-muted">Tìm kiếm hàng ngàn đầu sách đa dạng thể loại một cách dễ dàng.</p>
                </button>
                </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="p-4 border rounded shadow-sm h-100">
                <a href = "${pageContext.request.contextPath}/borrow">
                <button type="submit" class = "button">
                    <div class="feature-icon">📅</div>
                    <h3>Mượn trả tiện lợi</h3>
                    <p class="text-muted">Theo dõi lịch sử mượn trả, gia hạn sách và kiểm soát hạn nộp phạt.</p>
                </button>
                </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="p-4 border rounded shadow-sm h-100">
                <a href = "${pageContext.request.contextPath}/readers">
                <button type="submit" class = "button">
                    <div class="feature-icon">👥</div>
                    <h3>Quản lý Độc giả</h3>
                    <p class="text-muted">Hệ thống phân quyền chi tiết dành cho Admin và Thủ thư quản lý thành viên.</p>
                </button>
                </a>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-light text-center py-3 mt-auto">
        <div class="container">
            <span class="text-muted small">© 2024 Library Management System. All rights reserved.</span>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>