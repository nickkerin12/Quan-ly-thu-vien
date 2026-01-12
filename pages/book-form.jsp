<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row justify-content-center">
	<div class="col-md-8">
		<div class="card shadow">
			<div class="card-header bg-primary text-white">
				<h4>${empty book ? 'Thêm Sách Mới' : 'Cập Nhật Sách'}</h4>
			</div>
			<div class="card-body">
				<form action="${pageContext.request.contextPath}/books"
					method="post">
					<input type="hidden" name="bookId"
						value="${empty book ? 0 : book.bookId}">

					<div class="mb-3">
						<label>Mã Sách</label> <input type="text" name="maSach"
							class="form-control" value="${book.maSach}" required>
					</div>

					<div class="mb-3">
						<label>Tên Sách</label> <input type="text" name="tenSach"
							class="form-control" value="${book.tenSach}" required>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label>Tác Giả</label> <input type="text" name="tacGia"
								class="form-control" value="${book.tacGia}">
						</div>
						<div class="col-md-6 mb-3">
							<label>Thể Loại</label> <input type="text" name="theLoai"
								class="form-control" value="${book.theLoai}">
						</div>
					</div>

					<div class="row">
						<div class="col-md-4 mb-3">
							<label>Năm XB</label> <input type="number" name="namXB"
								class="form-control" value="${empty book ? 2024 : book.namXB}">
						</div>
						<div class="col-md-4 mb-3">
							<label>Tổng Số Lượng</label> <input type="number" name="soLuong"
								class="form-control" value="${empty book ? 1 : book.soLuong}"
								required>
						</div>
						<div class="col-md-4 mb-3">
							<label>Số Lượng Còn Lại</label> <input type="number"
								name="soLuongConLai" class="form-control"
								value="${empty book ? 1 : book.soLuongConLai}" required>
						</div>
					</div>

					<button type="submit" class="btn btn-primary">Lưu Lại</button>
					<a href="books" class="btn btn-secondary">Quay lại</a>
				</form>
			</div>
		</div>
	</div>
</div>

</div>
</body>
</html>