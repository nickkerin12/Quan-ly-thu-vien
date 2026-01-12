<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ include file="header.jsp"%>
<%@ page import="java.time.LocalDate"%>

<div class="container mt-4">
	<div class="card shadow p-4" style="max-width: 600px; margin: auto;">
		<h3 class="text-center text-primary mb-4">Phiếu Mượn Sách</h3>

		<form action="${pageContext.request.contextPath}/borrow" method="post">
			<input type="hidden" name="borrowId"
				value="${record.borrowId != null ? record.borrowId : 0}" />

			<div class="mb-3">
				<label class="form-label fw-bold">Người Mượn:</label>

				<c:choose>
					<%-- TRƯỜNG HỢP 1: ADMIN HOẶC THỦ THƯ -> Hiện danh sách thả xuống (Dropdown) --%>
					<c:when
						test="${sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Thủ thư'}">
						<select name="readerId" class="form-select" required>
							<option value="">-- Chọn Độc Giả --</option>
							<c:forEach var="r" items="${readers}">
								<option value="${r.readerId}"
									${r.readerId == record.readerId ? 'selected' : ''}>
									${r.maDocGia} - ${r.hoTen}</option>
							</c:forEach>
						</select>
					</c:when>

					<%-- TRƯỜNG HỢP 2: ĐỘC GIẢ -> Hiện tên dạng Text (Không cho chọn người khác) --%>
					<c:otherwise>
						<input type="text" class="form-control"
							value="${myReader.hoTen} (${myReader.maDocGia})" disabled
							readonly />

						<input type="hidden" name="readerId" value="${myReader.readerId}" />
					</c:otherwise>
				</c:choose>
			</div>

			<div class="mb-3">
				<label class="form-label fw-bold">Chọn Sách:</label> <select
					name="bookId" class="form-select" required>
					<option value="">-- Chọn Sách --</option>
					<c:forEach var="b" items="${books}">
						<c:if test="${b.soLuongConLai > 0 || b.bookId == record.bookId}">
							<option value="${b.bookId}"
								${b.bookId == record.bookId ? 'selected' : ''}>
								${b.tenSach} (Còn: ${b.soLuongConLai})</option>
						</c:if>
					</c:forEach>
				</select>
			</div>

			<div class="row">
				<div class="col-md-6 mb-3">
					<label class="form-label">Ngày Mượn</label> <input type="date"
						name="borrowDate" class="form-control" required
						value="${record.borrowDate == null ? LocalDate.now() : record.borrowDate}">
				</div>
				<div class="col-md-6 mb-3">
					<label class="form-label">Hẹn Trả</label> <input type="date"
						name="dueDate" class="form-control" required
						value="${record.dueDate}">
				</div>
			</div>

			<div class="d-flex justify-content-between mt-3">
				<a href="${pageContext.request.contextPath}/borrow"
					class="btn btn-secondary">Quay lại</a>
				<button type="submit" class="btn btn-primary">Xác Nhận Mượn</button>
			</div>
		</form>
	</div>
</div>
</body>
</html>