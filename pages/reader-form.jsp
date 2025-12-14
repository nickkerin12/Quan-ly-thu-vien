<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row justify-content-center mt-4">
	<div class="col-md-8">
		<div class="card shadow">
			<div class="card-header bg-primary text-white">
				<h4>
					${empty reader ? 'Thêm Độc Giả Mới' : 'Cập Nhật Thông Tin Độc Giả'}
				</h4>
			</div>
			<div class="card-body">
				<form action="${pageContext.request.contextPath}/readers" method="post">
					
					<input type="hidden" name="readerId" value="${empty reader ? 0 : reader.readerId}">

					<div class="row">
						<div class="col-md-6 mb-3">
							<label class="form-label">Mã Độc Giả</label> 
							<input type="text" name="maDocGia" class="form-control" 
								   value="${reader.maDocGia}" placeholder="Ví dụ: DG001" required>
						</div>
						
						<div class="col-md-6 mb-3">
							<label class="form-label">User ID (Tài khoản liên kết)</label> 
							<input type="number" name="userId" class="form-control" 
								   value="${empty reader ? '' : reader.userId}" required
								   placeholder="Nhập ID tài khoản User">
							<small class="text-muted">Nhập ID của tài khoản User tương ứng.</small>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label">Họ và Tên</label> 
						<input type="text" name="hoTen" class="form-control" 
							   value="${reader.hoTen}" required>
					</div>

					<div class="mb-3">
						<label class="form-label">Số Điện Thoại</label> 
						<input type="text" name="soDienThoai" class="form-control" 
							   value="${reader.soDienThoai}" required>
					</div>

					<div class="mb-3">
						<label class="form-label">Địa Chỉ</label> 
						<textarea name="diaChi" class="form-control" rows="3">${reader.diaChi}</textarea>
					</div>

					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						<a href="${pageContext.request.contextPath}/readers" class="btn btn-secondary me-md-2">
							<i class="bi bi-arrow-left"></i> Quay lại
						</a>
						<button type="submit" class="btn btn-primary">
							<i class="bi bi-save"></i> Lưu Thông Tin
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

</div> </body>
</html>