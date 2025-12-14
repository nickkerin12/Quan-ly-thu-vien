<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<%@ include file="pages/header.jsp"%>
<c:if test="${empty sessionScope.user}">
	<c:redirect url="/auth" />
</c:if>

<div class="container mt-4">

	<div class="p-5 mb-4 bg-light rounded-3 shadow-sm border">
		<div class="container-fluid py-3">
			<h1 class="display-5 fw-bold text-primary">Xin chào,
				${sessionScope.user.fullName}!</h1>
			<p class="col-md-8 fs-5 text-muted">Hệ thống quản lý thư viện đã
				sẵn sàng.</p>
			<a class="btn btn-primary btn-lg"
				href="${pageContext.request.contextPath}/borrow?action=new"
				role="button"> <i class="bi bi-journal-plus"></i> Tạo Phiếu Mượn
				Ngay
			</a>
		</div>
	</div>

	<div class="row align-items-md-stretch">

		<div class="col-md-4 mb-4">
			<div class="h-100 p-4 text-white bg-dark rounded-3 shadow hover-card">
				<h3>📚 Kho Sách</h3>
				<p>Quản lý đầu sách, cập nhật số lượng nhập và tồn kho.</p>
				<a href="${pageContext.request.contextPath}/books"
					class="btn btn-outline-light mt-3">Truy cập</a>
			</div>
		</div>

		<c:if
			test="${sessionScope.user.role == 'admin' || sessionScope.user.role == 'Admin'}">
			<div class="col-md-4 mb-4">
				<div
					class="h-100 p-4 bg-primary text-white rounded-3 shadow hover-card">
					<h3 class="text-white">👥 Độc Giả</h3>
					<p>Quản lý thông tin thành viên, cập nhật địa chỉ và liên lạc.</p>
					<a href="${pageContext.request.contextPath}/readers"
						class="btn btn-light text-primary mt-3 fw-bold">Truy cập</a>
				</div>
			</div>
		</c:if>
		<div class="col-md-4 mb-4">
			<div
				class="h-100 p-4 text-white bg-success rounded-3 shadow hover-card">
				<h3>🔄 Mượn / Trả</h3>
				<p>Theo dõi lịch sử mượn, ghi nhận trả sách và tính phí phạt.</p>
				<a href="${pageContext.request.contextPath}/borrow"
					class="btn btn-light text-success mt-3">Truy cập</a>
			</div>
		</div>

	</div>
</div>

</body>
</html>