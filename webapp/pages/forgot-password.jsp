<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Quên Mật Khẩu</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f0f2f5;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
}

.card-auth {
	width: 100%;
	max-width: 400px;
}
</style>
</head>
<body>

	<div class="card card-auth shadow border-0">
		<div class="card-body p-4">
			<h3 class="text-center text-primary mb-3">KHÔI PHỤC MẬT KHẨU</h3>
			<p class="text-center text-muted small">Nhập email đã đăng ký để
				nhận mật khẩu mới.</p>

			<c:if test="${not empty error}">
				<div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty message}">
				<div class="alert alert-success">${message}</div>
			</c:if>

			<form action="${pageContext.request.contextPath}/auth" method="post">
				<input type="hidden" name="action" value="forgotPassword">

				<div class="mb-3">
					<label class="form-label">Tên tài khoản</label> <input type="text"
						name="username" class="form-control"
						placeholder="Nhập tên đăng nhập..." required>
				</div>

				<div class="mb-3">
					<label class="form-label">Email đăng ký</label> <input type="email"
						name="email" class="form-control" placeholder="vidu@gmail.com"
						required>
				</div>

				<button type="submit" class="btn btn-primary w-100">Gửi Mật Khẩu Mới</button>

				<div class="text-center mt-3">
					<a href="${pageContext.request.contextPath}/auth" class="text-decoration-none">Quay lại Đăng nhập</a>
				</div>
			</form>
		</div>
	</div>

</body>
</html>