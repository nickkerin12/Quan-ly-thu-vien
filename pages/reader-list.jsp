<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row mb-3">
	<div class="col">
		<h2 class="text-primary">Danh Sách Độc Giả</h2>
	</div>
	<div class="col text-end">
		<a href="${pageContext.request.contextPath}/readers?action=new"
			class="btn btn-primary"> <i class="bi bi-person-plus-fill"></i> Thêm Độc Giả
		</a>
	</div>
</div>

<div class="card shadow-sm">
	<div class="card-body">
		<table class="table table-bordered table-hover align-middle">
			<thead class="table-secondary">
				<tr>
					<th>Mã ĐG</th>
					<th>Họ và Tên</th>
					<th>Địa Chỉ</th>
					<th>Số Điện Thoại</th>
					<th>User ID</th> <th style="width: 150px;">Thao Tác</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty readerList}">
					<tr>
						<td colspan="6" class="text-center text-muted">Chưa có dữ liệu độc giả.</td>
					</tr>
				</c:if>

				<c:forEach var="r" items="${readerList}">
					<tr>
						<td class="fw-bold">${r.maDocGia}</td>
						<td>${r.hoTen}</td>
						<td>${r.diaChi}</td>
						<td>${r.soDienThoai}</td>
						<td>${r.userId}</td>
						<td>
							<a href="${pageContext.request.contextPath}/readers?action=edit&id=${r.readerId}"
								class="btn btn-sm btn-warning">
								<i class="bi bi-pencil-square"></i> Sửa
							</a> 
							<a href="${pageContext.request.contextPath}/readers?action=delete&id=${r.readerId}"
								class="btn btn-sm btn-danger"
								onclick="return confirm('Bạn có chắc muốn xóa độc giả: ${r.hoTen}? Hành động này có thể xóa cả lịch sử mượn trả liên quan!')">
								<i class="bi bi-trash"></i> Xóa
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

</div> </body>
</html>