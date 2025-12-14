<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %> 
<div class="row mb-3">
	<div class="col">
		<h2 class="text-success">Quản Lý Mượn / Trả Sách</h2>
	</div>
	<div class="col text-end">
		<a href="${pageContext.request.contextPath}/borrow?action=new"
			class="btn btn-primary"> <i class="bi bi-journal-plus"></i> Tạo Phiếu Mượn
		</a>
	</div>
</div>

<div class="card shadow-sm">
	<div class="card-body">
		<table class="table table-bordered table-striped align-middle">
			<thead class="table-secondary">
				<tr>
					<th>Mã Phiếu</th>
					<th>Mã Độc Giả (ID)</th>
					<th>Mã Sách (ID)</th>
					<th>Ngày Mượn</th>
					<th>Hẹn Trả</th>
					<th>Ngày Trả</th>
					<th>Trạng Thái</th>
					<th>Tiền Phạt</th>
					<th style="min-width: 180px;">Hành Động</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty borrowList}">
					<tr>
						<td colspan="9" class="text-center text-muted">Chưa có lịch sử mượn trả nào.</td>
					</tr>
				</c:if>

				<c:forEach var="br" items="${borrowList}">
					<tr>
						<td>#${br.borrowId}</td>
						<td>${br.readerId}</td>
						<td>${br.bookId}</td>
						<td>${br.borrowDate}</td>
						<td>${br.dueDate}</td>
						<td>
							${empty br.returnDate ? '-' : br.returnDate}
						</td>
						
						<td>
							<c:choose>
								<c:when test="${br.status == 'Đã trả'}">
									<span class="badge bg-secondary">Đã trả</span>
								</c:when>
								<c:when test="${br.status == 'Quá hạn'}">
									<span class="badge bg-danger">Quá hạn</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-warning text-dark">Đang mượn</span>
								</c:otherwise>
							</c:choose>
						</td>
						
						<td class="text-danger fw-bold">
							${br.fineAmount > 0 ? br.fineAmount : '0'} đ
						</td>
						
						<td>
							<div class="d-flex gap-1">
								<c:if test="${br.status != 'Đã trả'}">
									<a href="${pageContext.request.contextPath}/borrow?action=return&id=${br.borrowId}"
									   class="btn btn-sm btn-success"
									   onclick="return confirm('Xác nhận độc giả đã trả sách cho phiếu #${br.borrowId}?')">
									   <i class="bi bi-check-circle"></i> Trả sách
									</a>
								</c:if>

								<c:if test="${br.fineAmount > 0}">
							        <a href="${pageContext.request.contextPath}/borrow?action=payFine&id=${br.borrowId}"
							           class="btn btn-sm btn-danger"
							           onclick="return confirm('Xác nhận thu tiền phạt ${br.fineAmount} đ?')">
							           <i class="bi bi-cash-coin"></i> Nộp phạt
							        </a>
							    </c:if>
						    </div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

</div> </body>
</html>