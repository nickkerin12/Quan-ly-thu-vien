<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="row mb-3">
	<div class="col">
		<h2>Quản Lý Sách</h2>
	</div>
	<div class="col text-end">
		<a href="${pageContext.request.contextPath}/books?action=new"
			class="btn btn-success"> <i class="bi bi-plus-circle"></i> Thêm
			Sách Mới
		</a>
	</div>
</div>

<table class="table table-bordered table-hover">
	<thead class="table-dark">
		<tr>
			<th>Mã Sách</th>
			<th>Tên Sách</th>
			<th>Tác Giả</th>
			<th>Năm XB</th>
			<th>SL Tổng</th>
			<th>SL Còn</th>
			<th>Trạng Thái</th>
			<th>Thao Tác</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="b" items="${bookList}">
			<tr>
				<td>${b.maSach}</td>
				<td>${b.tenSach}</td>
				<td>${b.tacGia}</td>
				<td>${b.namXB}</td>
				<td>${b.soLuong}</td>
				<td>${b.soLuongConLai}</td>
				<td><c:choose>
						<c:when test="${b.soLuongConLai > 0}">
							<span class="badge bg-success">Có sẵn</span>
						</c:when>
						<c:otherwise>
							<span class="badge bg-danger">Hết sách</span>
						</c:otherwise>
					</c:choose></td>
				<td><a href="books?action=edit&bookId=${b.bookId}"
					class="btn btn-sm btn-warning">Sửa</a> <a
					href="books?action=delete&bookId=${b.bookId}"
					class="btn btn-sm btn-danger"
					onclick="return confirm('Bạn có chắc muốn xóa sách: ${b.tenSach}?')">Xóa</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

</div>
</body>
</html>