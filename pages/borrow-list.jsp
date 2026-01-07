<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ include file="header.jsp"%>

<div class="container mt-4">
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="text-primary">Quản Lý Mượn / Trả Sách</h2>

		<a href="${pageContext.request.contextPath}/borrow?action=new"
			class="btn btn-primary"> + Tạo Phiếu Mượn </a>
	</div>

	<div class="card shadow-sm">
		<div class="card-body">
			<table class="table table-bordered table-hover align-middle">
				<thead class="table-dark">
					<tr>
						<th>Mã Phiếu</th>
						<th>Mã Độc Giả</th>
						<th>Mã Sách</th>
						<th>Ngày Mượn</th>
						<th>Hẹn Trả</th>
						<th>Ngày Trả</th>
						<th>Trạng Thái</th>
						<th>Tiền Phạt</th>

						<c:if
							test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Thủ thư'}">
							<th class="text-center">Hành Động</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="br" items="${borrowList}">
						<tr>
							<td>#${br.borrowId}</td>
							<td>${br.readerId}</td>
							<td>${br.bookId}</td>
							<td>${br.borrowDate}</td>
							<td>${br.dueDate}</td>
							<td>${br.returnDate == null ? '-' : br.returnDate}</td>
							<td><c:choose>
									<c:when test="${br.status == 'Đang mượn'}">
										<span class="badge bg-warning text-dark">${br.status}</span>
									</c:when>
									<c:when test="${br.status == 'Đã trả'}">
										<span class="badge bg-success">${br.status}</span>
									</c:when>
									<c:when test="${br.status == 'Quá hạn'}">
										<span class="badge bg-danger">${br.status}</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-secondary">${br.status}</span>
									</c:otherwise>
								</c:choose></td>
							<td
								class="fw-bold ${br.fineAmount > 0 ? 'text-danger' : 'text-success'}">
								${br.fineAmount} đ</td>

							<c:if
								test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Thủ thư'}">
								<td class="text-center"><c:if
										test="${br.status != 'Đã trả'}">
										<a href="borrow?action=return&id=${br.borrowId}"
											class="btn btn-success btn-sm"
											onclick="return confirm('Xác nhận trả sách cho phiếu #${br.borrowId}?')">
											Trả sách </a>
									</c:if> <c:if test="${br.status == 'Đã trả'}">
										<span class="text-success">&#10004; Xong</span>
									</c:if></td>
							</c:if>
						</tr>
					</c:forEach>

					<c:if test="${empty borrowList}">
						<tr>
							<td colspan="9" class="text-center text-muted py-3">Bạn chưa có lịch sử mượn sách nào.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>