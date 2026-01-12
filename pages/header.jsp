<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Hệ Thống Thư Viện</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
		<div class="container">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/pages/index.jsp">LIBRARY SYSTEM
			</a>

			<div class="collapse navbar-collapse">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/books">Sách</a></li>

					<c:if
						test="${sessionScope.user.role == 'admin' || sessionScope.user.role == 'Admin'}">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/readers">Độc Giả</a></li>
					</c:if>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/borrow">Mượn/Trả</a></li>
				</ul>

				<ul class="navbar-nav">
					<c:if test="${not empty sessionScope.user}">
						<li class="nav-item"><span
							class="nav-link text-white fw-bold">Xin chào,
								${sessionScope.user.fullName}</span></li>
						<li class="nav-item"><a
							class="nav-link btn btn-danger text-white btn-sm ms-2"
							href="${pageContext.request.contextPath}/auth?action=logout">Đăng
								Xuất</a></li>
					</c:if>

					<c:if test="${empty sessionScope.user}">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/auth">Đăng
								Nhập</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/pages/register.jsp">Đăng
								Ký</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">